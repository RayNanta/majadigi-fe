import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme_extensions.dart';

class LazyLoadErrorState extends StatelessWidget {
  const LazyLoadErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: context.appSubtleSurfaceColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.refresh_rounded,
                color: AppColors.welcomeAccent,
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.appTextColor,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class LazyCardSkeleton extends StatelessWidget {
  const LazyCardSkeleton({
    super.key,
    this.height = 156,
    this.borderRadius = 28,
  });

  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 180;

          return Container(
            decoration: BoxDecoration(
              color: context.appSurfaceColor,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [context.appCardShadow],
            ),
            child: Padding(
              padding: EdgeInsets.all(compact ? 18 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: compact
                    ? const [
                        _SkeletonLine(widthFactor: 0.48, height: 14),
                        SizedBox(height: 14),
                        _SkeletonLine(widthFactor: 0.76, height: 14),
                        SizedBox(height: 10),
                        _SkeletonLine(widthFactor: 0.56, height: 14),
                        Spacer(),
                        _SkeletonLine(widthFactor: 0.7, height: 32, radius: 16),
                      ]
                    : const [
                        _SkeletonLine(widthFactor: 0.38, height: 18),
                        SizedBox(height: 20),
                        _SkeletonLine(widthFactor: 0.72, height: 16),
                        SizedBox(height: 12),
                        _SkeletonLine(widthFactor: 0.52, height: 16),
                        Spacer(),
                        _SkeletonLine(
                          widthFactor: 0.88,
                          height: 42,
                          radius: 21,
                        ),
                      ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SliverLazyCardSkeletonList extends StatelessWidget {
  const SliverLazyCardSkeletonList({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(24, 22, 24, 28),
    this.itemCount = 3,
    this.itemHeight = 180,
  });

  final EdgeInsetsGeometry padding;
  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) => LazyCardSkeleton(height: itemHeight),
      ),
    );
  }
}

class SliverLazyLoadErrorState extends StatelessWidget {
  const SliverLazyLoadErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: LazyLoadErrorState(message: message, onRetry: onRetry),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({
    required this.widthFactor,
    required this.height,
    this.radius = 999,
  });

  final double widthFactor;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? const Color(0xFF20324F)
              : const Color(0xFFEAF0FA),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
