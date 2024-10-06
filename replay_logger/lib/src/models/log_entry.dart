class LogEntry {
  const LogEntry({
    required this.resource,
    required this.message,
    required this.eventTime,
    this.stackTrace,
  });

  final String resource;
  final Map<String, dynamic> message;
  final int eventTime;
  final StackTrace? stackTrace;

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    final resource = json['resource'] as String;
    final message = json['message'] as Map<String, dynamic>;
    final eventTime = json['eventTime'] as int;

    return LogEntry(
      resource: resource,
      message: message,
      eventTime: eventTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resource': resource,
      'message': message,
      'eventTime': eventTime,
      // 'stackTrace': stackTrace.toString(),
    };
  }
}
