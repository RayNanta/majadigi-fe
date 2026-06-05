import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimSehatPage extends StatelessWidget {
  const JatimSehatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Sehat',
      imageAssetPath: 'assets/images/nawa_bhakti/sehat.png',
      description:
          'Peningkatan layanan kesehatan yang bermutu, aksesibel, sinergis, dan adil untuk semua',
      services: [
        NawaBhaktiServiceLink(
          serviceId: 'rsud-saiful-anwar',
          title: 'RSUD Dr. Saiful Anwar',
          subtitle: 'Rumah Sakit Umum Daerah Dr. Saiful Anwar Malang',
        ),
        NawaBhaktiServiceLink(
          serviceId: 'skrining-tbc',
          title: 'Skrining Mandiri TBC',
          subtitle: 'Dinas Kesehatan',
        ),
      ],
    );
  }
}
