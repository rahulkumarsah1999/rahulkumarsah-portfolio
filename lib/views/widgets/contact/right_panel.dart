import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/services/contact_service.dart';
import 'package:portfolio/views/widgets/buttons/send_button.dart';
import 'package:portfolio/views/widgets/contact/field_label.dart';
import 'package:portfolio/views/widgets/contact/form_header.dart';
import 'package:portfolio/views/widgets/contact/input_field.dart';
import 'package:portfolio/views/widgets/contact/message_field.dart';
import 'package:portfolio/views/widgets/contact/privacy_note.dart';

class RightPanel extends StatefulWidget {
  final bool isDialog;

  const RightPanel({
    super.key,
    this.isDialog = false,
  });

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController subjectCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();
  bool isSending = false;
  DateTime? lastSentTime;

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    subjectCtrl.dispose();
    messageCtrl.dispose();
    super.dispose();
  }

  Future<void> handleSend() async {
    if (isSending) return;

    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final subject = subjectCtrl.text.trim();
    final message = messageCtrl.text.trim();

    /// Empty validation
    if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    /// Email validation
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    /// Cooldown
    if (lastSentTime != null &&
        DateTime.now().difference(lastSentTime!).inSeconds < 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait 30 sec before sending again'),
        ),
      );
      return;
    }

    try {
      setState(() {
        isSending = true;
      });

      await ContactService.sendEmail(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );

      lastSentTime = DateTime.now();

      nameCtrl.clear();
      emailCtrl.clear();
      subjectCtrl.clear();
      messageCtrl.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully 🚀')),
      );

      if (widget.isDialog && mounted) {
        Future.delayed(const Duration(milliseconds: 900), () {
          if (mounted) Navigator.pop(context);
        });
      }
    } catch (e) {
      debugPrint('EMAIL ERROR: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed: $e')));
    } finally {
      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // sizing
    final panelPadding = 28.0;
    final sectionSpacing = 18.0;
    final fieldSpacing = 8.0;
    final largeSpacing = 28.0;
    final submitSpacing = 24.0;

    // decoration
    final panelDecoration = BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.accent.withValues(alpha: 0.22),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 40,
          spreadRadius: 0,
          offset: const Offset(0, 8),
        ),
      ],
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.isDialog ? 560 : double.infinity,
      ),
      child: Container(
        padding: EdgeInsets.all(panelPadding),
        decoration: panelDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHeader(

            ),
            SizedBox(height: largeSpacing),
            FieldLabel(text: 'Your Name'),
            SizedBox(height: fieldSpacing),
            InputField(
              controller: nameCtrl,
              hint: 'Enter your full name',
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: sectionSpacing),
            FieldLabel(text: 'Your Email'),
            SizedBox(height: fieldSpacing),
            InputField(
              controller: emailCtrl,
              hint: 'Enter your email address',
              icon: const Icon(
                Icons.email_rounded,
                color: Colors.grey,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: sectionSpacing),
            FieldLabel(text: 'Subject'),
            SizedBox(height: fieldSpacing),
            InputField(
              controller: subjectCtrl,
              hint: 'What is this regarding?',
              icon: const Icon(
                Icons.sell_rounded,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: sectionSpacing),
            FieldLabel(text: 'Message'),
            SizedBox(height: fieldSpacing),
            MessageField(
              controller: messageCtrl,
              hint: 'Write your message here...',
              icon: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: submitSpacing),
            SendButton(
              onTap: isSending ? null : handleSend,
              isLoading: isSending,
            ),
            const SizedBox(height: 14),
            PrivacyNote(),
          ],
        ),
      ),
    );
  }
}
