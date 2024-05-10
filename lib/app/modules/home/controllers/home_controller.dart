import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/DataEvent.dart';
import '../../../data/DataListEvent.dart';

class HomeController extends GetxController {
  // RxInt digunakan untuk merespon perubahan
  var tabIndex = 0.obs;
  // Membuat variable observables untuk event
  var events = <Map<String, dynamic>>[].obs;
  var eventList = <Map<String, dynamic>>[].obs;
  var filteredEvents = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      filteredEvents.assignAll(events);
    } else if (index == 1) {
      filteredEvents.assignAll(eventList);
    }
  }

  void loadEvents() {
    // Menetapkan data dari DataEvent
    events.assignAll(DataEvent.events);
    eventList.assignAll(DataListEvent.events);
    changeTabIndex(tabIndex.value);
  }

  void filterEvents(String category, DateTime? date) {
    // Determine which list to use based on the tabIndex
    List<Map<String, dynamic>> sourceList =
        tabIndex.value == 0 ? events : eventList;

    var filtered = sourceList.where((event) {
      bool matchesCategory = category.isEmpty ||
          event['category']
              .toString()
              .toLowerCase()
              .contains(category.toLowerCase());
      bool matchesDate = date == null ||
          DateTime.parse(event['date']).day == date.day &&
              DateTime.parse(event['date']).month == date.month &&
              DateTime.parse(event['date']).year == date.year;
      return matchesCategory && matchesDate;
    }).toList();

    filteredEvents.assignAll(filtered);
  }

  bool isURL(String path) {
    return Uri.tryParse(path)?.hasAbsolutePath ?? false;
  }

  void registerForEvent(String name, String nim, String phone) {
    print('Registered with Name: $name, NIM: $nim, Phone: $phone');
    Get.snackbar(
      'Registration Successful',
      'Registered as $name',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      backgroundColor: Color.fromARGB(255, 74, 84, 213),
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
