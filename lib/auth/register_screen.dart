import 'dart:convert';
import 'package:demo/auth/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:demo/auth/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+91');
  final TextEditingController _mobileController = TextEditingController();
  bool _agree = false;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _countryCodeController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || !_agree) return;

    setState(() => _submitting = true);
    final String phone =
        '${_countryCodeController.text}${_mobileController.text}';

    try {
      /// Step 1: Register User
      final registerResponse = await http.post(
        Uri.parse('https://mock-api.calleyacd.com/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        }),
      );

      if (registerResponse.statusCode == 201) {
        /// Step 2: Send OTP if register successful
        final otpResponse = await http.post(
          Uri.parse('https://mock-api.calleyacd.com/api/auth/send-otp'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': _emailController.text.trim()}),
        );

        setState(() => _submitting = false);

        if (otpResponse.statusCode == 200) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  OtpScreen(
                phone: phone,
                email: _emailController.text.trim(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        } else {
          final error = jsonDecode(otpResponse.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    error['message'] ?? 'Failed to send OTP after register')),
          );
        }
      } else {
        setState(() => _submitting = false);
        final error = jsonDecode(registerResponse.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    }
  }

  Widget _buildBoxTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    TextInputType type = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(38, 0, 0, 0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              SizedBox(
                height: 80,
                child: Center(
                  child: Image.asset(
                    "assets/images/image.png",
                    height: 64,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                'Welcome!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Please register to continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBoxTextField(
                        controller: _nameController,
                        label: "Name",
                        icon: Icons.person_outline,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Required'
                            : null,
                      ),
                      _buildBoxTextField(
                        controller: _emailController,
                        label: "Email Address",
                        icon: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                        validator: (v) => (v == null || !v.contains('@'))
                            ? 'Enter valid email'
                            : null,
                      ),
                      _buildBoxTextField(
                        controller: _passwordController,
                        label: "Password",
                        icon: Icons.lock_outline,
                        obscure: true,
                        validator: (v) =>
                            (v == null || v.length < 6) ? 'Min 6 characters' : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildBoxTextField(
                              controller: _countryCodeController,
                              label: "Code",
                              icon: Icons.flag_circle,
                              type: TextInputType.phone,
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? '!' : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: _buildBoxTextField(
                              controller: _mobileController,
                              label: "Mobile Number",
                              icon: Icons.phone_iphone,
                              type: TextInputType.phone,
                              validator: (v) =>
                                  (v == null || v.length < 7) ? 'Invalid' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(
                            value: _agree,
                            onChanged: (bool? v) =>
                                setState(() => _agree = v ?? false),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black87),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black87),
                            children: [
                              const TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Sign In',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _submitting || !_agree ? null : _submit,
                          child: _submitting
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
