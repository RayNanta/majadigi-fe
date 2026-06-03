import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimSejahteraPage extends StatelessWidget {
  const JatimSejahteraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Sejahtera',
      imageAssetPath: 'assets/images/nawa_bhakti/sejahtera.png',
      description:
          'Percepatan pengentasan kemiskinan lintas sektoral spasial dan berbasis data terpadu',
      services: [
        NawaBhaktiServiceLink(
          serviceId: 'siskaper-bapo',
          title: 'Harga Bahan Pokok (SISKAPERBAPO)',
          subtitle: 'Dinas Perindustrian dan Perdagangan Provinsi Jawa Timur',
        ),
      ],
    );
  }
}
