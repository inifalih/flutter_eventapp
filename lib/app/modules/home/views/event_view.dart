import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class EventView extends StatelessWidget {
  EventView({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => controller.filterEvents(value, null),
                    decoration: InputDecoration(
                      labelText: 'Search by Category',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      controller.filterEvents('', date);
                    }
                  },
                  tooltip: 'Select Date',
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    children: controller.filteredEvents
                        .map(
                          (event) => GestureDetector(
                            onTap: () =>
                                _showRegistrationDialog(context, event),
                            child: Card(
                              margin: EdgeInsets.all(8),
                              elevation: 5,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            _getImageProvider(event['image']),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            event['title'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(event['date']),
                                          Text(event['time']),
                                          SizedBox(height: 5),
                                          Text(
                                            event['category'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              color: Color.fromARGB(
                                                  255, 4, 119, 191),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  ImageProvider _getImageProvider(String path) {
    if (controller.isURL(path)) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }

  void _showRegistrationDialog(
      BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController nimController = TextEditingController();
        TextEditingController phoneController = TextEditingController();

        return AlertDialog(
          title: Text('Register for Event'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Event: ${event['title']}'),
                Text('Date: ${event['date']}'),
                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: nimController,
                  decoration: InputDecoration(
                    labelText: 'Your NIM',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'WhatsApp Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                controller.registerForEvent(nameController.text,
                    nimController.text, phoneController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
