import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimCerdasPage extends StatelessWidget {
  const JatimCerdasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Cerdas',
      imageAssetPath: 'assets/images/nawa_bhakti/cerdas.png',
      description:
          'Pelayanan dan akses pendidikan berkualitas, merata, dan adil untuk semua',
      services: [],
    );
  }
}
