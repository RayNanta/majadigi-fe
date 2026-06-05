import 'package:flutter/widgets.dart';

import 'nawa_bhakti_category_page.dart';

class JatimHarmoniPage extends StatelessWidget {
  const JatimHarmoniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NawaBhaktiCategoryPage(
      title: 'Jatim Harmoni',
      imageAssetPath: 'assets/images/nawa_bhakti/harmoni.png',
      description:
          'Harmoni dalam toleransi, kesetaraan gender, serta penguatan seni, budaya, & olahraga',
      services: [
        NawaBhaktiServiceLink(
          serviceId: 'islamic-center',
          title: 'Islamic Center',
          subtitle: 'Biro Kesejahteraan Rakyat',
        ),
      ],
    );
  }
}
