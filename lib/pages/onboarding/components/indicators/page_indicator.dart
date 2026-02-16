import 'package:flutter/material.dart';

/// Индикатор текущей страницы онбординга
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? Colors.blue
                : Colors.blue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
