import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimKerjaPage extends StatelessWidget {
  const JatimKerjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Kerja',
      imageAssetPath: 'assets/images/nawa_bhakti/kerja.png',
      description:
          'Ekonomi inklusif dan berdaya lewat penguatan ekonomi, investasi, dan skill kompetitif',
      services: [
        NawaBhaktiServiceLink(
          serviceId: 'sinaker',
          title: 'Pelatihan Kerja (SINAKER)',
          subtitle: 'Disnakertrans Jawa Timur',
        ),
      ],
    );
  }
}
