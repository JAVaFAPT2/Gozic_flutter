import 'package:flutter/material.dart';

import '../../../shared/widgets/gz_button.dart';
import 'new_user_profile.dart';

class ProfileInfoPage extends StatefulWidget {
  final NewUserProfile profile;
  final VoidCallback onNext;
  const ProfileInfoPage({
    super.key,
    required this.profile,
    required this.onNext,
  });

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _gender;
  DateTime? _dob;

  bool _valid = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _validate() {
    final ok = _nameCtrl.text.isNotEmpty && _dob != null && _gender != null;
    if (ok != _valid) setState(() => _valid = ok);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _dob = picked);
      _validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        onChanged: _validate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Thông tin',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Thông tin này giúp mọi người có thể kết nối với bạn dễ dàng hơn.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _nameCtrl,
              decoration: _decoration(
                hint: 'Tên người dùng',
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickDate,
              child: IgnorePointer(
                child: TextFormField(
                  decoration: _decoration(
                    hint: 'Ngày sinh',
                    icon: Icons.calendar_today_outlined,
                  ),
                  controller: TextEditingController(
                    text: _dob == null
                        ? ''
                        : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Nam')),
                DropdownMenuItem(value: 'female', child: Text('Nữ')),
                DropdownMenuItem(value: 'other', child: Text('Khác')),
              ],
              value: _gender,
              onChanged: (v) {
                setState(() => _gender = v);
                _validate();
              },
              decoration: _decoration(
                hint: 'Giới tính',
                icon: Icons.wc_outlined,
              ),
            ),
            const Spacer(),
            GzButton(
              label: 'Tiếp tục',
              onPressed: _valid
                  ? () {
                      widget.profile.name = _nameCtrl.text;
                      widget.profile.phone = _phoneCtrl.text;
                      widget.profile.gender = _gender;
                      widget.profile.dob = _dob;
                      widget.onNext();
                    }
                  : null,
              disabled: !_valid,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration({required String hint, required IconData icon}) {
    return InputDecoration(
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
}
