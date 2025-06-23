import 'package:flutter/material.dart';

import 'interest_picker_page.dart';
import 'new_user_profile.dart';
import 'profile_info_page.dart';

class ProfileOnboardingFlow extends StatefulWidget {
  const ProfileOnboardingFlow({super.key});

  @override
  State<ProfileOnboardingFlow> createState() => _ProfileOnboardingFlowState();
}

class _ProfileOnboardingFlowState extends State<ProfileOnboardingFlow> {
  final _controller = PageController();
  final _profile = NewUserProfile();

  void _toNext() => _controller.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.ease,
  );

  void _finish() {
    // TODO: send _profile to backend
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('Thiết lập hồ sơ'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ProfileInfoPage(profile: _profile, onNext: _toNext),
          InterestPickerPage(profile: _profile, onFinish: _finish),
        ],
      ),
    );
  }
}
