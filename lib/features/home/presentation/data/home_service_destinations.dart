import '../../../../app/router/route_names.dart';

String? routeNameForHomeServiceId(String serviceId) {
  switch (serviceId) {
    case 'bapenda-jatim':
      return RouteNames.homeBapendaJatim;
    case 'destinasi-wisata':
      return RouteNames.homeSidita;
    case 'islamic-center':
      return RouteNames.homeIslamicCenter;
    case 'rsud-saiful-anwar':
      return RouteNames.homeRsudSaifulAnwar;
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
    case 'khas-jatim':
      return RouteNames.homeKhasJatim;
    default:
      return null;
  }
}
