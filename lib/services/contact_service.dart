import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:portfolio/core/config/api_keys.dart';

class ContactService {
  static Future<void> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'origin': 'https://rahulkumarsah.com',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': ApiKeys.emailServiceId,
          'template_id': ApiKeys.emailTemplateId,
          'public_key': ApiKeys.emailPublicKey,
          'template_params': {
            'name': name.trim(),
            'email': email.trim(),
            'reply_to': email.trim(),
            'subject': subject.trim(),
            'message': message.trim(),
          }
        }),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('BODY: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint('EMAIL ERROR: $e');
      rethrow;
    }
  }
}