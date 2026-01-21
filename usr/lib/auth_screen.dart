import 'package:flutter/material.dart';

class RGSAuthScreen extends StatefulWidget {
  const RGSAuthScreen({super.key});

  @override
  State<RGSAuthScreen> createState() => _RGSAuthScreenState();
}

class _RGSAuthScreenState extends State<RGSAuthScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Controllers
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _registerPhoneEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Primary Color
  final Color _primaryColor = const Color(0xFF2563EB);

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _registerPhoneEmailController.dispose();
    _registerPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Icon(Icons.security_rounded, size: 64, color: _primaryColor),
                const SizedBox(height: 16),
                Text(
                  _isLogin ? 'RGS Trading Login' : 'Create RGS Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isLogin ? 'Secure access for investment management' : 'Join the secure trading platform',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: _isLogin ? _buildLoginFields() : _buildRegisterFields(),
                  ),
                ),

                const SizedBox(height: 24),

                // Action Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Mock authentication action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isLogin ? 'Logging in...' : 'Registering...'),
                          backgroundColor: _primaryColor,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    _isLogin ? 'LOGIN' : 'REGISTER',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                  ),
                ),

                const SizedBox(height: 24),

                // Social Login (Only for Login)
                if (_isLogin) ...[
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[300])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('OR LOGIN WITH', style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.account_balance_wallet, color: Colors.blue), // Wing placeholder
                          label: const Text('Wing'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red), // Google placeholder
                          label: const Text('Google'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],

                // Toggle View
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin ? "Don't have an account? " : "Already have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLogin = !_isLogin;
                          _formKey.currentState?.reset();
                        });
                      },
                      child: Text(
                        _isLogin ? 'Register' : 'Login',
                        style: TextStyle(
                          color: _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLoginFields() {
    return [
      TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          prefixIcon: Icon(Icons.phone_outlined),
          hintText: 'Enter your phone number',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter phone number';
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: 'Enter your password',
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter password';
          return null;
        },
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: _rememberMe,
              activeColor: _primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: (value) => setState(() => _rememberMe = value!),
            ),
          ),
          const SizedBox(width: 8),
          const Text('Remember me'),
          const Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: _primaryColor),
            child: const Text('Forgot Password?'),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildRegisterFields() {
    return [
      TextFormField(
        controller: _fullNameController,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          labelText: 'Full Name',
          prefixIcon: Icon(Icons.person_outline),
          hintText: 'Enter your full name',
        ),
        validator: (value) => value!.isEmpty ? 'Full name is required' : null,
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          labelText: 'Username',
          prefixIcon: Icon(Icons.alternate_email),
          hintText: 'Choose a username',
        ),
        validator: (value) => value!.isEmpty ? 'Username is required' : null,
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _registerPhoneEmailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Phone Number / Email',
          prefixIcon: Icon(Icons.contact_mail_outlined),
          hintText: 'Enter phone or email',
        ),
        validator: (value) => value!.isEmpty ? 'Phone or Email is required' : null,
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _registerPasswordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: 'Create a password',
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Password is required' : null,
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: 'Confirm your password',
          suffixIcon: IconButton(
            icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please confirm password';
          if (value != _registerPasswordController.text) return 'Passwords do not match';
          return null;
        },
      ),
    ];
  }
}
