import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_section_card.dart';
import '../controllers/home_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchCount = ref.watch(homeLaunchCountProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Majadigi Mobile')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Flutter app shell is ready.',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This project now starts with a feature-first structure that is ready for go_router, Riverpod, Dio, and shared_preferences.',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            launchCount.when(
              data: (count) => AppSectionCard(
                title: 'Shared preferences demo',
                message:
                    'App ini sudah membaca local storage. Total dibuka $count kali di device ini.',
              ),
              loading: () => const _LoadingCard(),
              error: (error, stackTrace) => AppSectionCard(
                title: 'Shared preferences status',
                message: 'Gagal membaca local storage: $error',
              ),
            ),
            const SizedBox(height: 16),
            const AppSectionCard(
              title: 'Next implementation ideas',
              message:
                  'Tambahkan feature auth, pecah Dio endpoints per module, dan sambungkan route guard setelah flow login mulai dibangun.',
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
