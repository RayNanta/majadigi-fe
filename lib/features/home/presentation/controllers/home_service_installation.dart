import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_services_controller.dart';

void installHomeService(BuildContext context, String serviceId) {
  ProviderScope.containerOf(
    context,
    listen: false,
  ).read(homeSelectedServiceIdsProvider.notifier).addService(serviceId);
}
