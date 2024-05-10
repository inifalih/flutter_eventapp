import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class EventListView extends StatelessWidget {
  EventListView({Key? key}) : super(key: key);
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
                        .map((eventList) => Card(
                              margin: EdgeInsets.all(8),
                              elevation: 5,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: _getImageProvider(
                                            eventList['image']),
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
                                            eventList['title'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(eventList['date']),
                                          Text(eventList['time']),
                                          SizedBox(height: 5),
                                          Text(
                                            eventList['category'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Status: ${eventList['status']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: _getStatusColor(
                                                  eventList['status']),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
