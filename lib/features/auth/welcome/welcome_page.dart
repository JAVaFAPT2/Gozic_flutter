import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/widgets/gz_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _goLogin(BuildContext context) =>
      Navigator.of(context).pushNamed('/login');
  void _goRegister(BuildContext context) =>
      Navigator.of(context).pushNamed('/register');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  'assets/images/auth/welcome.svg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              GzButton(label: 'Đăng nhập', onPressed: () => _goLogin(context)),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  SizedBox(width: 8),
                  Text('Hoặc'),
                  SizedBox(width: 8),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4285F4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Tiếp tục bằng Google'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {},
                icon: const Icon(Icons.apple),
                label: const Text('Tiếp tục bằng Apple'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bạn chưa có tài khoản? '),
                  GestureDetector(
                    onTap: () => _goRegister(context),
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
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
    );
  }
}
