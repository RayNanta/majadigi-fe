import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimAksesPage extends StatelessWidget {
  const JatimAksesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Akses',
      imageAssetPath: 'assets/images/nawa_bhakti/akses.png',
      description:
          'Perkuat konektivitas dan aglomerasi lewat infrastruktur serta transportasi terpadu',
      services: [
        NawaBhaktiServiceLink(
          serviceId: 'bapenda-jatim',
          title: 'BAPENDA Jawa Timur',
          subtitle: 'Badan Pendapatan Daerah',
        ),
        NawaBhaktiServiceLink(
          serviceId: 'nomor-darurat',
          title: 'Nomor Darurat',
          subtitle: 'Dinas Komunikasi & Informatika',
        ),
      ],
    );
  }
}
