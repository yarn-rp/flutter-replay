class LogEntry {
  const LogEntry({
    required this.message,
    required this.eventTime,
    required this.stackTrace,
  });

  final Map<String, dynamic> message;
  final int eventTime;
  final StackTrace stackTrace;

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    final message = json['message'] as Map<String, dynamic>;
    final eventTime = json['eventTime'] as int;
    final stackTrace = StackTrace.fromString(json['stackTrace'] as String);

    return LogEntry(
      message: message,
      eventTime: eventTime,
      stackTrace: stackTrace,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'eventTime': eventTime,
      'stackTrace': stackTrace,
    };
  }
}
