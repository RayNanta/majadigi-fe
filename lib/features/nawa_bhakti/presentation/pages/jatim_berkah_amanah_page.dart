import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimBerkahAmanahPage extends StatelessWidget {
  const JatimBerkahAmanahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Berkah & Amanah',
      imageAssetPath: 'assets/images/nawa_bhakti/berkah_amanah.png',
      description:
          'Optimasi pemerintahan efektif, efisien, dan anti korupsi sesuai nilai agama dan pancasila',
      services: [],
    );
  }
}
