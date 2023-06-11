class DriverApprovalNotification {
  final String notificationId;
  final String title;
  final String message;
  final String userId;
  final DateTime timestamp;

  DriverApprovalNotification({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.userId,
    required this.timestamp,
  });
}
