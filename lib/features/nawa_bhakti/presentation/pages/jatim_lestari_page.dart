import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimLestariPage extends StatelessWidget {
  const JatimLestariPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Lestari',
      imageAssetPath: 'assets/images/nawa_bhakti/lestari.png',
      description:
          'Pengembangan ekonomi hijau dan teknologi ramah lingkungan demi kelestarian lingkungan berkelanjutan',
      services: [],
    );
  }
}
