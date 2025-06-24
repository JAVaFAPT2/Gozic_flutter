import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/widgets/gz_button.dart';

class OnboardingItem {
  final String imageAsset;
  final String title;
  final String subtitle;

  const OnboardingItem({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();

  final _items = const [
    OnboardingItem(
      imageAsset: 'assets/images/onboarding/onboarding_1.svg',
      title: 'Kết nối cộng đồng',
      subtitle:
          'Giao lưu, chia sẻ và cùng nhau tạo nên một cộng đồng yêu thiên nhiên gắn kết vững mạnh',
    ),
    OnboardingItem(
      imageAsset: 'assets/images/onboarding/onboarding_2.svg',
      title: 'Quản lý cây trồng',
      subtitle:
          'Tạo lộ trình chăm sóc, quản lý cây trồng hiệu quả, cùng mọi người phát triển vườn cây của mình',
    ),
    OnboardingItem(
      imageAsset: 'assets/images/onboarding/onboarding_3.svg',
      title: 'Cập nhật kiến thức',
      subtitle:
          'Học hỏi những kiến thức bổ ích về cây trồng, giao lưu và chia sẻ kiến thức với mọi người xung quanh',
    ),
  ];

  int _currentIndex = 0;

  void _next() {
    if (_currentIndex < _items.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _finish();
    }
  }

  void _skip() => _finish();

  void _finish() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: _skip, child: const Text('Bỏ qua')),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _items.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (_, i) {
                  final item = _items[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            item.imageAsset,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          item.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.subtitle,
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _items.length,
                    effect: WormEffect(
                      activeDotColor: theme.colorScheme.primary,
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GzButton(
                      label: _currentIndex == _items.length - 1
                          ? 'Bắt đầu'
                          : 'Tiếp tục',
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
