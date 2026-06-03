import '../../../../app/router/route_names.dart';

String? routeNameForHomeServiceId(
  String serviceId, {
  bool isInstalled = false,
}) {
  if (isInstalled) {
    return mainRouteNameForHomeServiceId(serviceId);
  }

  return previewRouteNameForHomeServiceId(serviceId);
}

String? previewRouteNameForHomeServiceId(String serviceId) {
  switch (serviceId) {
    case 'bapenda-jatim':
      return RouteNames.homeBapendaJatim;
    case 'destinasi-wisata':
      return RouteNames.homeSidita;
    case 'jatim-berkah-amanah':
      return RouteNames.homeNawaBhaktiBerkahAmanah;
    case 'jatim-agro':
      return RouteNames.homeNawaBhaktiAgro;
    case 'jatim-akses':
      return RouteNames.homeNawaBhaktiAkses;
    case 'jatim-cerdas':
      return RouteNames.homeNawaBhaktiCerdas;
    case 'jatim-harmoni':
      return RouteNames.homeNawaBhaktiHarmoni;
    case 'jatim-kerja':
      return RouteNames.homeNawaBhaktiKerja;
    case 'jatim-lestari':
      return RouteNames.homeNawaBhaktiLestari;
    case 'jatim-sehat':
      return RouteNames.homeNawaBhaktiSehat;
    case 'jatim-sejahtera':
      return RouteNames.homeNawaBhaktiSejahtera;
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

String? mainRouteNameForHomeServiceId(String serviceId) {
  switch (serviceId) {
    case 'bapenda-jatim':
      return RouteNames.homeBapendaJatimMain;
    case 'destinasi-wisata':
      return RouteNames.homeSiditaMain;
    case 'jatim-berkah-amanah':
      return RouteNames.homeNawaBhaktiBerkahAmanah;
    case 'jatim-agro':
      return RouteNames.homeNawaBhaktiAgro;
    case 'jatim-akses':
      return RouteNames.homeNawaBhaktiAkses;
    case 'jatim-cerdas':
      return RouteNames.homeNawaBhaktiCerdas;
    case 'jatim-harmoni':
      return RouteNames.homeNawaBhaktiHarmoni;
    case 'jatim-kerja':
      return RouteNames.homeNawaBhaktiKerja;
    case 'jatim-lestari':
      return RouteNames.homeNawaBhaktiLestari;
    case 'jatim-sehat':
      return RouteNames.homeNawaBhaktiSehat;
    case 'jatim-sejahtera':
      return RouteNames.homeNawaBhaktiSejahtera;
    case 'islamic-center':
      return RouteNames.homeIslamicCenterMain;
    case 'rsud-saiful-anwar':
      return RouteNames.homeRsudSaifulAnwarMain;
    case 'skrining-tbc':
      return RouteNames.homeTbcIdentityForm;
    case 'sinaker':
      return RouteNames.homeSinakerMain;
    case 'siskaper-bapo':
      return RouteNames.homeSiskaperbapoMain;
    case 'nomor-darurat':
      return RouteNames.homeEmergencyNumbersMain;
    case 'klinik-hoaks':
      return RouteNames.homeHoaxClinicMain;
    case 'khas-jatim':
      return RouteNames.homeKhasJatimMain;
    default:
      return null;
  }
}
