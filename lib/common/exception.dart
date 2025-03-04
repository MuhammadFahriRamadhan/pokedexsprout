import 'dart:convert';

class ServerException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  ServerException({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  // Factory constructor to create an instance from JSON
  factory ServerException.fromJson(Map<String, dynamic> json) {
    return ServerException(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  String toString() => 'ServerException($statusCode): $message';
}