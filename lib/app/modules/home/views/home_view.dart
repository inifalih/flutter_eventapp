import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../data/DataNotifications.dart';
import './event_view.dart';
import './list_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Obx(() {
          var currentIndex = controller.tabIndex.value;
          return Text(currentIndex == 0 ? 'Event' : 'Order',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white));
        }),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.deepPurple.withOpacity(0.5),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.notifications, color: Colors.white),
            onSelected: (String value) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Notification'),
                    content: Text(value),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            itemBuilder: (BuildContext context) =>
                DataNotifications.notifications.map((String notification) {
              return PopupMenuItem<String>(
                value: notification,
                child: Text(notification),
              );
            }).toList(),
          ),
        ],
      ),
      body: Obx(() {
        var currentIndex = controller.tabIndex.value;
        switch (currentIndex) {
          case 0:
            return EventView();
          case 1:
            return EventListView();
          default:
            return EventView();
        }
      }),
      bottomNavigationBar: Obx(() => Container(
            margin: EdgeInsets.all(10), // Margin dari semua sisi
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20), // Sudut yang melengkung
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  20), // Pastikan ini sama dengan di BoxDecoration
              child: BottomNavigationBar(
                backgroundColor: Colors.deepPurple,
                currentIndex: controller.tabIndex.value,
                onTap: controller.changeTabIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event),
                    label: 'Event',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Order',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
