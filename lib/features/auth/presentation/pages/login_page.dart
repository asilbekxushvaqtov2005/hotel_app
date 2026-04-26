import 'package:flutter/material.dart';
import '../../../core/presentation/pages/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _phoneController = TextEditingController(text: '+998 90 123 45 67');
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Logo
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE65100),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Xush kelibsiz',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Davom etish uchun tizimga kiring',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              
              // Phone Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Telefon raqami', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '+998 90 123 45 67',
                      suffixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Password Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Parol', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: '........',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Parolni unutdingizmi?',
                    style: TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Kiritilgan nomerni MainScreen'ga uzatamiz
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(userPhone: _phoneController.text),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Kirish', style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('yoki', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 30),
              
              // Biometric Button - placeholder as it was removed but keeping space if needed
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
