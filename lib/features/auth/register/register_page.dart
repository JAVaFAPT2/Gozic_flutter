import 'package:flutter/material.dart';

import '../../../shared/widgets/gz_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;
  bool _agree = false;
  bool _valid = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_valid && _agree) {
      // TODO: call register API
      Navigator.of(context).pushReplacementNamed('/register-success');
    }
  }

  void _goLogin() => Navigator.of(context).pop();

  void _validate() {
    final ok =
        (_emailCtrl.text.isNotEmpty &&
        _pwdCtrl.text.length >= 6 &&
        _pwdCtrl.text == _confirmCtrl.text &&
        _agree);
    if (ok != _valid) setState(() => _valid = ok);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          onChanged: _validate,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Đăng ký',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: _dec(
                    'Email hoặc số điện thoại',
                    Icons.person_outline,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                    final emailRegex = RegExp(
                      r'^[\w-.]+@[\w-]+\.[a-zA-Z]{2,}\$',
                    );
                    if (!emailRegex.hasMatch(v)) return 'Email không hợp lệ';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pwdCtrl,
                  decoration: _dec('Mật khẩu', Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  obscureText: _obscure,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Tối thiểu 6 ký tự' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmCtrl,
                  decoration: _dec('Xác nhận mật khẩu', Icons.lock_outline)
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                  obscureText: _obscureConfirm,
                  validator: (v) =>
                      v != _pwdCtrl.text ? 'Mật khẩu không khớp' : null,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _agree,
                      onChanged: (v) => setState(() {
                        _agree = v ?? false;
                        _validate();
                      }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const Expanded(child: Text('Đồng ý với điều khoản')),
                  ],
                ),
                const SizedBox(height: 8),
                GzButton(
                  label: 'Tiếp tục',
                  onPressed: _submit,
                  disabled: !_valid,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _goLogin,
                  child: const Text('Đã có tài khoản? Đăng nhập'),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String hint, IconData icon) => InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon, color: Colors.green),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE6E8EB)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE6E8EB)),
    ),
  );
}
