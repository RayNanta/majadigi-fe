import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimAgroPage extends StatelessWidget {
  const JatimAgroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Agro',
      imageAssetPath: 'assets/images/nawa_bhakti/agro.png',
      description:
          'Pengembangan komoditas unggulan dan dukungan infrastruktur untuk mencapai ketahanan pangan nasional',
      services: [],
    );
  }
}
