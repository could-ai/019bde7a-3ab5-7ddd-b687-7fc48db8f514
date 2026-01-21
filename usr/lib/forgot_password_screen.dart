import 'package:flutter/material.dart';

class RGSForgotPasswordScreen extends StatefulWidget {
  const RGSForgotPasswordScreen({super.key});

  @override
  State<RGSForgotPasswordScreen> createState() => _RGSForgotPasswordScreenState();
}

class _RGSForgotPasswordScreenState extends State<RGSForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final Color _primaryColor = const Color(0xFF2563EB);
  bool _isLoading = false;

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network request
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          
          // Show success dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Reset Link Sent'),
              content: Text('We have sent password reset instructions to ${_contactController.text}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back to login
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Icon(
                Icons.lock_reset_rounded,
                size: 80,
                color: _primaryColor.withOpacity(0.8),
              ),
              const SizedBox(height: 24),
              const Text(
                'Reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Enter the phone number or email address associated with your account and we will send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number / Email',
                    prefixIcon: Icon(Icons.contact_mail_outlined),
                    hintText: 'Enter phone or email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone or email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleResetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'SEND RESET LINK',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: RichText(
                  text: TextSpan(
                    text: 'Remember your password? ',
                    style: TextStyle(color: Colors.grey[600]),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
