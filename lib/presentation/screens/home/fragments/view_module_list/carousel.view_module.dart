import 'dart:async';

import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/utils/widgets/common_image.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CarouselViewModlue extends StatefulWidget with ViewModuleWidget {
  final ViewModule info;
  const CarouselViewModlue(this.info, {super.key});

  @override
  State<CarouselViewModlue> createState() => _CarouselViewModlueState();
}

class _CarouselViewModlueState extends State<CarouselViewModlue> {
  int _currentPage = 1;
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = _periodicTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Timer _periodicTimer() {
    return Timer.periodic(const Duration(seconds: 4), (timer) {
      _pageController.animateToPage(
        _pageController.page!.round() + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _handleUserScroll() {
    if (_pageController.page != _pageController.page!.toInt()) {
      _timer.cancel();
    } else {
      if (!_timer.isActive) {
        _timer = _periodicTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductInfo> products = widget.info.products;
    return RawGestureDetector(
      gestures: {
        CustomGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomGestureRecognizer>(
          () => CustomGestureRecognizer(),
          (instance) {
            instance.onDown = (details) {
              if (_timer.isActive) {
                _timer.cancel();
              }
            };

            // 유저가 drag하지 않고 손을 떼는 경우
            instance.onCancel = () {
              if (!_timer.isActive) {
                _timer = _periodicTimer();
              }
            };

            instance.onEnd = (details) {
              if (!_timer.isActive) {
                _timer = _periodicTimer();
              }
            };
          },
        ),
      },
      child: AspectRatio(
        aspectRatio: 375 / 345,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page % products.length + 1;
                });
              },
              itemBuilder: (context, index) {
                // final src = products[index % products.length].imageUrl;
                final src =
                    'https://i.pravatar.cc/150?img=${index % 5 + 2 - 1}%E2%80%8B';
                return CommonImage(src);
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: PageCountWidget(
                currentPage: _currentPage,
                totalPage: products.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGestureRecognizer extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    // recognizer가 패배하였더러도, 승리자 리스트에 추가
    acceptGesture(pointer);
  }
}

class PageCountWidget extends StatelessWidget {
  final int currentPage;
  final int totalPage;

  const PageCountWidget({
    super.key,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.74),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 8,
        ),
        child: Text(
          '$currentPage / $totalPage',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
    );
  }
}
