import '../../../../app/router/route_names.dart';

String? routeNameForHomeServiceId(String serviceId) {
  switch (serviceId) {
    case 'skrining-tbc':
      return RouteNames.homeTbcScreening;
    case 'sinaker':
      return RouteNames.homeSinaker;
    case 'siskaper-bapo':
      return RouteNames.homeSiskaperbapo;
    case 'nomor-darurat':
      return RouteNames.homeEmergencyNumbers;
    case 'klinik-hoaks':
      return RouteNames.homeHoaxClinic;
    default:
      return null;
  }
}
