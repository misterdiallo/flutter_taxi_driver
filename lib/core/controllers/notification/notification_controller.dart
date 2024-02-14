import 'package:get/get.dart';

class Notification {
  final String title;
  final String message;
  final DateTime timestamp;
  bool isRead; // Added boolean flag to track read status

  Notification({
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false, // Default to false for unread
  });
}

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();
  var notifications = <Notification>[].obs;
  var unreadNotifications = <Notification>[].obs;
  var readNotifications = <Notification>[].obs;

  @override
  void onInit() {
    super.onInit();
    for (int i = 1; i <= 8; i++) {
      Notification newNotification = Notification(
        title: 'Notification $i',
        message:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        timestamp: DateTime.now(),
      );
      addNotification(newNotification);
    }
    markAsRead(0);
    markAsRead(1);
    markAsRead(2);
    markAsRead(3);
    // markAsRead(4);
  }

  void addNotification(Notification newNotification) {
    notifications.add(newNotification);
  }

  void removeNotification(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
    }
  }

  List<Notification> getRecentNotifications({required int count}) {
    return notifications.isNotEmpty
        ? notifications.reversed.take(count).toList()
        : [];
  }

  List<Notification> getUnreadNotifications() {
    return notifications.where((notification) => !notification.isRead).toList();
  }

  void markAsRead(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index].isRead = true;
      update();
    }
  }

  List<Notification> getNotificationsSortedByReadStatus() {
    unreadNotifications = notifications
        .where((notification) => !notification.isRead)
        .toList()
        .obs;
    readNotifications =
        notifications.where((notification) => notification.isRead).toList().obs;
    return [...unreadNotifications, ...readNotifications];
  }

  void clearNotifications() {
    notifications.clear();
  }
}
