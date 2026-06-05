import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:majadigi_mobile/features/sinaker/presentation/pages/sinaker_training_registration_list.dart';
import 'package:majadigi_mobile/features/tbc_screening/presentation/pages/tbc_result_positive_page.dart';

import 'presentation/pages/about_majadigi_page.dart';
import '../../app/router/route_names.dart';
import 'presentation/pages/about_jatim_page.dart';
import 'presentation/pages/change_language_page.dart';
import 'presentation/pages/change_password_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/personal_data_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/services_page.dart';
import 'presentation/pages/service_list_page.dart';
import 'presentation/pages/terms_conditions_page.dart';
import '../emergency_numbers/presentation/pages/emergency_numbers_page.dart';
import '../emergency_numbers/presentation/pages/emergency_numbers_main_page.dart';
import '../bapenda_jatim/presentation/pages/bapenda_jatim_page.dart';
import '../bapenda_jatim/presentation/pages/bapenda_jatim_main_page.dart';
import '../bapenda_jatim/presentation/pages/bapenda_jatim_njkb_page.dart';
import '../bapenda_jatim/presentation/pages/bapenda_jatim_njkb_result_page.dart';
import '../bapenda_jatim/presentation/pages/bapenda_jatim_pkb_page.dart';
import '../bapenda_jatim/presentation/pages/bapenda_jatim_pkb_result_page.dart';
import '../hoax_clinic/presentation/pages/hoax_clinic_page.dart';
import '../hoax_clinic/presentation/pages/hoax_clinic_main_page.dart';
import '../hoax_clinic/presentation/pages/hoax_latest_report_detail_page.dart';
import '../hoax_clinic/presentation/pages/hoax_latest_reports_page.dart';
import '../hoax_clinic/presentation/pages/hoax_report_page.dart';
import '../hoax_clinic/presentation/pages/hoax_track_report_page.dart';
import '../hoax_clinic/presentation/pages/hoax_track_result_page.dart';
import '../islamic_center/presentation/pages/islamic_center_detail_page.dart';
import '../islamic_center/presentation/pages/islamic_center_aula_booking_page.dart';
import '../islamic_center/presentation/pages/islamic_center_aula_rooms_page.dart';
import '../islamic_center/presentation/pages/islamic_center_asrama_page.dart';
import '../islamic_center/presentation/pages/islamic_center_asrama_booking_page.dart';
import '../islamic_center/presentation/pages/islamic_center_asrama_rooms_page.dart';
import '../islamic_center/presentation/pages/islamic_center_masjid_booking_page.dart';
import '../islamic_center/presentation/pages/islamic_center_masjid_page.dart';
import '../islamic_center/presentation/pages/islamic_center_masjid_rooms_page.dart';
import '../islamic_center/presentation/pages/islamic_center_main_page.dart';
import '../islamic_center/presentation/pages/islamic_center_page.dart';
import '../khas_jatim/presentation/pages/khas_jatim_main_page.dart';
import '../khas_jatim/presentation/pages/khas_jatim_manuscripts_page.dart';
import '../khas_jatim/presentation/pages/khas_jatim_page.dart';
import '../khas_jatim/presentation/pages/khas_jatim_registration_page.dart';
import '../khas_jatim/presentation/pages/khas_jatim_serat_sri_sedana_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_agro_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_akses_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_berkah_amanah_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_cerdas_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_harmoni_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_kerja_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_lestari_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_sehat_page.dart';
import '../nawa_bhakti/presentation/pages/jatim_sejahtera_page.dart';
import '../rsud_saiful_anwar/presentation/pages/rsud_saiful_anwar_main_page.dart';
import '../rsud_saiful_anwar/presentation/pages/rsud_saiful_anwar_page.dart';
import '../sidita/presentation/pages/sidita_accommodations_page.dart';
import '../sidita/presentation/pages/sidita_bromo_detail_page.dart';
import '../sidita/presentation/pages/sidita_destinations_page.dart';
import '../sidita/presentation/pages/sidita_events_page.dart';
import '../sidita/presentation/pages/sidita_main_page.dart';
import '../sidita/presentation/pages/sidita_pasar_djadoel_page.dart';
import '../sidita/presentation/pages/sidita_page.dart';
import '../sidita/presentation/pages/sidita_singhasari_page.dart';
import '../sidita/presentation/pages/sidita_travelers_page.dart';
import '../sinaker/presentation/pages/sinaker_main_page.dart';
import '../sinaker/presentation/pages/sinaker_page.dart';
import '../sinaker/presentation/pages/sinaker_training_center_sumenep_page.dart';
import '../sinaker/presentation/pages/sinaker_training_centers_page.dart';
import '../sinaker/presentation/pages/sinaker_training_registration_list.dart';
import '../sinaker/presentation/pages/sinaker_training_registration_check_page.dart';
import '../sinaker/presentation/pages/sinaker_training_registration_detail_page.dart';
import '../sinaker/presentation/pages/sinaker_training_registration_page.dart';
import '../sinaker/presentation/pages/sinaker_training_list_page.dart';
import '../siskaperbapo/presentation/pages/siskaperbapo_bawang_merah_page.dart';
import '../siskaperbapo/presentation/pages/siskaperbapo_page.dart';
import '../siskaperbapo/presentation/pages/siskaperbapo_main_page.dart';
import '../tbc_screening/presentation/pages/tbc_identity_form_page.dart';
import '../tbc_screening/presentation/pages/tbc_personal_identity_page.dart';
import '../tbc_screening/presentation/pages/tbc_result_negative_page.dart';
import '../tbc_screening/presentation/pages/tbc_screening_form_one_page.dart';
import '../tbc_screening/presentation/pages/tbc_screening_form_two_page.dart';
import '../tbc_screening/presentation/pages/tbc_screening_page.dart';

final class HomeRoutes {
  HomeRoutes._();

  static const path = '/';
  static const servicesPath = '/layanan';
  static const myServicesPath = '/layanan-saya';
  static const nawaBhaktiLestariPath = '/nawa-bhakti/lestari';
  static const nawaBhaktiKerjaPath = '/nawa-bhakti/kerja';
  static const nawaBhaktiSejahteraPath = '/nawa-bhakti/sejahtera';
  static const nawaBhaktiBerkahAmanahPath = '/nawa-bhakti/berkah-amanah';
  static const nawaBhaktiHarmoniPath = '/nawa-bhakti/harmoni';
  static const nawaBhaktiAgroPath = '/nawa-bhakti/agro';
  static const nawaBhaktiCerdasPath = '/nawa-bhakti/cerdas';
  static const nawaBhaktiAksesPath = '/nawa-bhakti/akses';
  static const nawaBhaktiSehatPath = '/nawa-bhakti/sehat';
  static const tbcScreeningPath = '/layanan/skrining-tbc';
  static const bapendaJatimPath = '/layanan/bapenda-jatim';
  static const bapendaJatimMainPath = '/layanan/bapenda-jatim/utama';
  static const bapendaJatimPkbPath =
      '/layanan/bapenda-jatim/utama/informasi-pkb';
  static const bapendaJatimPkbResultPath =
      '/layanan/bapenda-jatim/utama/informasi-pkb/hasil';
  static const bapendaJatimNjkbPath =
      '/layanan/bapenda-jatim/utama/informasi-njkb';
  static const bapendaJatimNjkbResultPath =
      '/layanan/bapenda-jatim/utama/informasi-njkb/hasil';
  static const islamicCenterPath = '/layanan/islamic-center';
  static const islamicCenterMainPath = '/layanan/islamic-center/utama';
  static const islamicCenterFacilityDetailPath = '/layanan/islamic-center/utama/detail/:id';
  static const islamicCenterAulaRoomsPath =
      '/layanan/islamic-center/utama/aula/ruangan/:facilityId';
  static const islamicCenterBookingPath =
      '/layanan/islamic-center/utama/aula/pemesanan';
  static const islamicCenterAsramaPath = '/layanan/islamic-center/utama/asrama';
  static const islamicCenterAsramaRoomsPath =
      '/layanan/islamic-center/utama/asrama/ruangan';
  static const islamicCenterAsramaBookingPath =
      '/layanan/islamic-center/utama/asrama/pemesanan';
  static const islamicCenterMasjidPath = '/layanan/islamic-center/utama/masjid';
  static const islamicCenterMasjidRoomsPath =
      '/layanan/islamic-center/utama/masjid/ruangan';
  static const islamicCenterMasjidBookingPath =
      '/layanan/islamic-center/utama/masjid/pemesanan';
  static const khasJatimPath = '/layanan/khas-jatim';
  static const khasJatimMainPath = '/layanan/khas-jatim/utama';
  static const khasJatimManuscriptsPath = '/layanan/khas-jatim/utama/naskah';
  static const khasJatimRegistrationPath =
      '/layanan/khas-jatim/utama/pendaftaran';
  static const khasJatimSeratSriSedanaPath =
      '/layanan/khas-jatim/utama/naskah/serat-sri-sedana';
  static const rsudSaifulAnwarPath = '/layanan/rsud-saiful-anwar';
  static const rsudSaifulAnwarMainPath = '/layanan/rsud-saiful-anwar/utama';
  static const siditaPath = '/layanan/sidita';
  static const siditaMainPath = '/layanan/sidita/utama';
  static const siditaDestinationsPath = '/layanan/sidita/utama/destinasi';
  static const siditaAccommodationsPath = '/layanan/sidita/utama/akomodasi';
  static const siditaTravelersPath = '/layanan/sidita/utama/wisatawan';
  static const siditaSinghasariPath =
      '/layanan/sidita/utama/akomodasi/the-singhasari-resort';
  static const siditaBromoPath = '/layanan/sidita/utama/destinasi/bromo';
  static const siditaEventsPath = '/layanan/sidita/utama/event';
  static const siditaPasarDjadoelPath =
      '/layanan/sidita/utama/event/pasar-djadoel';
  static const sinakerPath = '/layanan/sinaker';
  static const sinakerMainPath = '/layanan/sinaker/utama';
  static const sinakerTrainingListPath = '/layanan/sinaker/utama/pelatihan';
  static const sinakerTrainingCentersPath = '/layanan/sinaker/utama/blk';
  static const sinakerTrainingCenterSumenepPath =
      '/layanan/sinaker/utama/blk/sumenep';
  static const sinakerTrainingRegistrationCheckPath =
      '/layanan/sinaker/utama/cek-pendaftaran';
  static const sinakerTrainingRegistrationDetailPath =
      '/layanan/sinaker/utama/cek-pendaftaran/:registrationId';
  static const sinakerTrainingRegistrationPath =
      '/layanan/sinaker/utama/pelatihan/barista';
  static const sinakerTrainingRegistrationListPath = '/layanan/sinaker/utama/cek-list-pendaftaran';
  static const siskaperbapoPath = '/layanan/siskaper-bapo';
  static const siskaperbapoMainPath = '/layanan/siskaper-bapo/utama';
  static const siskaperbapoBawangMerahPath =
      '/layanan/siskaper-bapo/utama/bawang-merah';
  static const emergencyNumbersPath = '/layanan/nomor-darurat';
  static const emergencyNumbersMainPath = '/layanan/nomor-darurat/utama';
  static const hoaxClinicPath = '/layanan/klinik-hoaks';
  static const hoaxClinicMainPath = '/layanan/klinik-hoaks/utama';
  static const hoaxClinicReportPath = '/layanan/klinik-hoaks/utama/laporan';
  static const hoaxClinicTrackPath = '/layanan/klinik-hoaks/utama/lacak';
  static const hoaxClinicTrackResultPath =
      '/layanan/klinik-hoaks/utama/lacak/hasil';
  static const hoaxClinicLatestReportsPath =
      '/layanan/klinik-hoaks/utama/laporan-terkini';
  static const hoaxClinicLatestReportPath =
      '/layanan/klinik-hoaks/utama/laporan-terkini/donald-trump';
  static const tbcIdentityFormPath = '/layanan/skrining-tbc/form-identitas';
  static const tbcPersonalIdentityPath =
      '/layanan/skrining-tbc/form-identitas/identitas-anda';
  static const tbcScreeningFormOnePath =
      '/layanan/skrining-tbc/form-identitas/identitas-anda/formulir-1';
  static const tbcScreeningFormTwoPath =
      '/layanan/skrining-tbc/form-identitas/identitas-anda/formulir-1/formulir-2';
  static const tbcResultNegativePath =
      '/layanan/skrining-tbc/form-identitas/identitas-anda/formulir-1/formulir-2/hasil-negative';
  static const tbcResultPositivePath =
      '/layanan/skrining-tbc/form-identitas/identitas-anda/formulir-1/formulir-2/hasil-positive';
  static const profilePath = '/akun';
  static const personalDataPath = '/akun/data-diri';
  static const changePasswordPath = '/akun/ubah-kata-sandi';
  static const changeLanguagePath = '/akun/ganti-bahasa';
  static const aboutJatimPath = '/akun/tentang-jawa-timur';
  static const termsConditionsPath = '/akun/syarat-ketentuan';
  static const aboutMajadigiPath = '/akun/tentang-majadigi';

  static final routes = <RouteBase>[
    GoRoute(
      path: path,
      name: RouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: servicesPath,
      name: RouteNames.homeServices,
      builder: (context, state) => const ServicesPage(),
    ),
    GoRoute(
      path: myServicesPath,
      name: RouteNames.homeMyServices,
      builder: (context, state) => const ServiceListPage(),
    ),
    GoRoute(
      path: nawaBhaktiLestariPath,
      name: RouteNames.homeNawaBhaktiLestari,
      builder: (context, state) => const JatimLestariPage(),
    ),
    GoRoute(
      path: nawaBhaktiKerjaPath,
      name: RouteNames.homeNawaBhaktiKerja,
      builder: (context, state) => const JatimKerjaPage(),
    ),
    GoRoute(
      path: nawaBhaktiSejahteraPath,
      name: RouteNames.homeNawaBhaktiSejahtera,
      builder: (context, state) => const JatimSejahteraPage(),
    ),
    GoRoute(
      path: nawaBhaktiBerkahAmanahPath,
      name: RouteNames.homeNawaBhaktiBerkahAmanah,
      builder: (context, state) => const JatimBerkahAmanahPage(),
    ),
    GoRoute(
      path: nawaBhaktiHarmoniPath,
      name: RouteNames.homeNawaBhaktiHarmoni,
      builder: (context, state) => const JatimHarmoniPage(),
    ),
    GoRoute(
      path: nawaBhaktiAgroPath,
      name: RouteNames.homeNawaBhaktiAgro,
      builder: (context, state) => const JatimAgroPage(),
    ),
    GoRoute(
      path: nawaBhaktiCerdasPath,
      name: RouteNames.homeNawaBhaktiCerdas,
      builder: (context, state) => const JatimCerdasPage(),
    ),
    GoRoute(
      path: nawaBhaktiAksesPath,
      name: RouteNames.homeNawaBhaktiAkses,
      builder: (context, state) => const JatimAksesPage(),
    ),
    GoRoute(
      path: nawaBhaktiSehatPath,
      name: RouteNames.homeNawaBhaktiSehat,
      builder: (context, state) => const JatimSehatPage(),
    ),
    GoRoute(
      path: tbcScreeningPath,
      name: RouteNames.homeTbcScreening,
      builder: (context, state) => const TbcScreeningPage(),
    ),
    GoRoute(
      path: bapendaJatimPath,
      name: RouteNames.homeBapendaJatim,
      builder: (context, state) => const BapendaJatimPage(),
    ),
    GoRoute(
      path: bapendaJatimMainPath,
      name: RouteNames.homeBapendaJatimMain,
      builder: (context, state) => const BapendaJatimMainPage(),
    ),
    GoRoute(
      path: bapendaJatimPkbPath,
      name: RouteNames.homeBapendaJatimPkb,
      builder: (context, state) => const BapendaJatimPkbPage(),
    ),
    GoRoute(
      path: bapendaJatimPkbResultPath,
      name: RouteNames.homeBapendaJatimPkbResult,
      builder: (context, state) => BapendaJatimPkbResultPage(
        plateNumber: state.uri.queryParameters['plate'],
      ),
    ),
    GoRoute(
      path: bapendaJatimNjkbPath,
      name: RouteNames.homeBapendaJatimNjkb,
      builder: (context, state) => const BapendaJatimNjkbPage(),
    ),
    GoRoute(
      path: bapendaJatimNjkbResultPath,
      name: RouteNames.homeBapendaJatimNjkbResult,
      builder: (context, state) {
        final payload = state.extra is Map<String, String>
            ? state.extra! as Map<String, String>
            : const <String, String>{};

        return BapendaJatimNjkbResultPage(
          vehicleType: payload['vehicleType'],
          brand: payload['brand'],
          year: payload['year'],
          model: payload['model'],
          trim: payload['trim'],
        );
      },
    ),
    GoRoute(
      path: islamicCenterPath,
      name: RouteNames.homeIslamicCenter,
      builder: (context, state) => const IslamicCenterPage(),
    ),
    GoRoute(
      path: islamicCenterMainPath,
      name: RouteNames.homeIslamicCenterMain,
      builder: (context, state) => const IslamicCenterMainPage(),
    ),
    GoRoute(
      path: islamicCenterFacilityDetailPath,
      name: RouteNames.homeIslamicCenterDetail,
      builder: (context, state) {
        final id = int.parse(
          state.pathParameters['id']!,
        );

        return IslamicCenterDetailPage(
          facilityId: id,
        );
      },
    ),
    GoRoute(
      path: islamicCenterAulaRoomsPath,
      name: RouteNames.homeIslamicCenterAulaRooms,
      builder: (context, state) {
        return IslamicCenterAulaRoomsPage(
            facilityId: int.parse(
                state.pathParameters['facilityId']!,
            ),
        );
      },
    ),
    GoRoute(
      path: islamicCenterBookingPath,
      name: RouteNames.homeIslamicCenterBooking,
      builder: (context, state){
        return IslamicCenterBookingPage(
          roomId: int.parse(
            state.uri.queryParameters['roomId']!,
          ),
        );
      }
    ),
    GoRoute(
      path: islamicCenterAsramaPath,
      name: RouteNames.homeIslamicCenterAsrama,
      builder: (context, state) => const IslamicCenterAsramaPage(),
    ),
    GoRoute(
      path: islamicCenterAsramaRoomsPath,
      name: RouteNames.homeIslamicCenterAsramaRooms,
      builder: (context, state) => const IslamicCenterAsramaRoomsPage(),
    ),
    GoRoute(
      path: islamicCenterAsramaBookingPath,
      name: RouteNames.homeIslamicCenterAsramaBooking,
      builder: (context, state) => IslamicCenterAsramaBookingPage(
        roomName: state.uri.queryParameters['room'],
      ),
    ),
    GoRoute(
      path: islamicCenterMasjidPath,
      name: RouteNames.homeIslamicCenterMasjid,
      builder: (context, state) => const IslamicCenterMasjidPage(),
    ),
    GoRoute(
      path: islamicCenterMasjidRoomsPath,
      name: RouteNames.homeIslamicCenterMasjidRooms,
      builder: (context, state) => const IslamicCenterMasjidRoomsPage(),
    ),
    GoRoute(
      path: islamicCenterMasjidBookingPath,
      name: RouteNames.homeIslamicCenterMasjidBooking,
      builder: (context, state) => IslamicCenterMasjidBookingPage(
        roomName: state.uri.queryParameters['room'],
      ),
    ),
    GoRoute(
      path: khasJatimPath,
      name: RouteNames.homeKhasJatim,
      builder: (context, state) => const KhasJatimPage(),
    ),
    GoRoute(
      path: khasJatimMainPath,
      name: RouteNames.homeKhasJatimMain,
      builder: (context, state) => const KhasJatimMainPage(),
    ),
    GoRoute(
      path: khasJatimManuscriptsPath,
      name: RouteNames.homeKhasJatimManuscripts,
      builder: (context, state) => const KhasJatimManuscriptsPage(),
    ),
    GoRoute(
      path: khasJatimRegistrationPath,
      name: RouteNames.homeKhasJatimRegistration,
      builder: (context, state) => const KhasJatimRegistrationPage(),
    ),
    GoRoute(
      path: khasJatimSeratSriSedanaPath,
      name: RouteNames.homeKhasJatimSeratSriSedana,
      builder: (context, state) => const KhasJatimSeratSriSedanaPage(),
    ),
    GoRoute(
      path: rsudSaifulAnwarPath,
      name: RouteNames.homeRsudSaifulAnwar,
      builder: (context, state) => const RsudSaifulAnwarPage(),
    ),
    GoRoute(
      path: rsudSaifulAnwarMainPath,
      name: RouteNames.homeRsudSaifulAnwarMain,
      builder: (context, state) => const RsudSaifulAnwarMainPage(),
    ),
    GoRoute(
      path: siditaPath,
      name: RouteNames.homeSidita,
      builder: (context, state) => const SiditaPage(),
    ),
    GoRoute(
      path: siditaMainPath,
      name: RouteNames.homeSiditaMain,
      builder: (context, state) => const SiditaMainPage(),
    ),
    GoRoute(
      path: siditaDestinationsPath,
      name: RouteNames.homeSiditaDestinations,
      builder: (context, state) => const SiditaDestinationsPage(),
    ),
    GoRoute(
      path: siditaAccommodationsPath,
      name: RouteNames.homeSiditaAccommodations,
      builder: (context, state) => const SiditaAccommodationsPage(),
    ),
    GoRoute(
      path: siditaTravelersPath,
      name: RouteNames.homeSiditaTravelers,
      builder: (context, state) => const SiditaTravelersPage(),
    ),
    GoRoute(
      path: siditaSinghasariPath,
      name: RouteNames.homeSiditaSinghasari,
      builder: (context, state) => const SiditaSinghasariPage(),
    ),
    GoRoute(
      path: siditaBromoPath,
      name: RouteNames.homeSiditaBromo,
      builder: (context, state) => const SiditaBromoDetailPage(),
    ),
    GoRoute(
      path: siditaEventsPath,
      name: RouteNames.homeSiditaEvents,
      builder: (context, state) => const SiditaEventsPage(),
    ),
    GoRoute(
      path: siditaPasarDjadoelPath,
      name: RouteNames.homeSiditaPasarDjadoel,
      builder: (context, state) => const SiditaPasarDjadoelPage(),
    ),
    GoRoute(
      path: sinakerPath,
      name: RouteNames.homeSinaker,
      builder: (context, state) => const SinakerPage(),
    ),
    GoRoute(
      path: sinakerMainPath,
      name: RouteNames.homeSinakerMain,
      builder: (context, state) => const SinakerMainPage(),
    ),
     GoRoute(
       path: sinakerTrainingListPath,
       name: RouteNames.homeSinakerTrainingList,
       builder: (context, state) => const SinakerTrainingListPage(),
     ),
    GoRoute(
      path: sinakerTrainingRegistrationListPath,
      name: RouteNames.homeSinakerTrainingRegistrationList,
      builder: (context, state) => const SinakerTrainingRegistrationListPage(),
    ),
    // GoRoute(
    //   name: RouteNames.homeSinakerTrainingList,
    //   path: '/layanan/sinaker/utama/pelatihan/:centerId',
    //   builder: (context, state) {
    //     final id = state.pathParameters['centerId'];
    //     return SinakerTrainingListPage(
    //       centerId: id != null ? int.parse(id) : null,
    //       centerName: state.extra as String? ?? 'Daftar Pelatihan',
    //     );
    //   },
    // ),
    GoRoute(
      path: sinakerTrainingCentersPath,
      name: RouteNames.homeSinakerTrainingCenters,
      builder: (context, state) => const SinakerTrainingCentersPage(),
    ),
    GoRoute(
      path: sinakerTrainingCenterSumenepPath,
      name: RouteNames.homeSinakerTrainingCenterSumenep,
      builder: (context, state) => const SinakerTrainingCenterSumenepPage(),
    ),
    GoRoute(
      path: sinakerTrainingRegistrationCheckPath,
      name: RouteNames.homeSinakerTrainingRegistrationCheck,
      builder: (context, state) {
        return SinakerTrainingRegistrationCheckPage(
          participantId: state.extra as int,
        );
      },
    ),
    GoRoute(
      path: sinakerTrainingRegistrationDetailPath,
      name: RouteNames.homeSinakerTrainingRegistrationDetail,
      builder: (context, state) => SinakerTrainingRegistrationDetailPage(
        registrationId: state.pathParameters['registrationId'],
      ),
    ),
    GoRoute(
      path: sinakerTrainingRegistrationPath,
      name: RouteNames.homeSinakerTrainingRegistration,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return SinakerTrainingRegistrationPage(
          trainingId: extra['training_id'] as int,
          trainingName: extra['training_name'] as String,
        );
      },
    ),
    GoRoute(
      path: siskaperbapoPath,
      name: RouteNames.homeSiskaperbapo,
      builder: (context, state) => const SiskaperbapoPage(),
    ),
    GoRoute(
      path: siskaperbapoMainPath,
      name: RouteNames.homeSiskaperbapoMain,
      builder: (context, state) => const SiskaperbapoMainPage(),
    ),
    GoRoute(
      path: siskaperbapoBawangMerahPath,
      name: RouteNames.homeSiskaperbapoBawangMerah,
      builder: (context, state) => const SiskaperbapoBawangMerahPage(),
    ),
    GoRoute(
      path: emergencyNumbersPath,
      name: RouteNames.homeEmergencyNumbers,
      builder: (context, state) => const EmergencyNumbersPage(),
    ),
    GoRoute(
      path: emergencyNumbersMainPath,
      name: RouteNames.homeEmergencyNumbersMain,
      builder: (context, state) => const EmergencyNumbersMainPage(),
    ),
    GoRoute(
      path: hoaxClinicPath,
      name: RouteNames.homeHoaxClinic,
      builder: (context, state) => const HoaxClinicPage(),
    ),
    GoRoute(
      path: hoaxClinicMainPath,
      name: RouteNames.homeHoaxClinicMain,
      builder: (context, state) => const HoaxClinicMainPage(),
    ),
    GoRoute(
      path: hoaxClinicReportPath,
      name: RouteNames.homeHoaxClinicReport,
      builder: (context, state) => const HoaxReportPage(),
    ),
    GoRoute(
      path: hoaxClinicTrackPath,
      name: RouteNames.homeHoaxClinicTrack,
      builder: (context, state) => const HoaxTrackReportPage(),
    ),
    GoRoute(
      path: hoaxClinicTrackResultPath,
      name: RouteNames.homeHoaxClinicTrackResult,
      builder: (context, state) => HoaxTrackResultPage(
        ticketNumber: switch (state.extra) {
          final String value when value.trim().isNotEmpty => value.trim(),
          _ => 'MH-2024-001',
        },
      ),
    ),
    GoRoute(
      path: hoaxClinicLatestReportsPath,
      name: RouteNames.homeHoaxClinicLatestReports,
      builder: (context, state) => const HoaxLatestReportsPage(),
    ),
    GoRoute(
      path: hoaxClinicLatestReportPath,
      name: RouteNames.homeHoaxClinicLatestReport,
      builder: (context, state) => const HoaxLatestReportDetailPage(),
    ),
    GoRoute(
      path: tbcIdentityFormPath,
      name: RouteNames.homeTbcIdentityForm,
      builder: (context, state) => const TbcIdentityFormPage(),
    ),
    GoRoute(
      path: '/tbc-personal-identity',
      name: RouteNames.homeTbcPersonalIdentity,
      builder: (context, state) {

        final data =
        state.extra as Map<String, dynamic>;

        return TbcPersonalIdentityPage(
          formData: data,
        );
      },
    ),
    GoRoute(
      path: '/tbc-screening-form-one',
      name: RouteNames.homeTbcScreeningFormOne,

      builder: (context, state) {

        final data =
        state.extra as Map<String, dynamic>;

        return TbcScreeningFormOnePage(
          screeningData: data,
        );
      },
    ),
    GoRoute(
      path: '/tbc-screening-form-two',
      name: RouteNames.homeTbcScreeningFormTwo,
      builder: (context, state) {

        final screeningData =
        state.extra as Map<String, dynamic>;

        return TbcScreeningFormTwoPage(
          screeningData: screeningData,
        );
      },
    ),
    GoRoute(
      path: tbcResultPositivePath,
      name: RouteNames.homeTbcResultPositive,

      builder: (context, state) {

        final data =
        state.extra as Map<String, dynamic>;

        return TbcResultPositivePage(
          resultData: data,
        );
      },
    ),
    GoRoute(
      path: tbcResultNegativePath,
      name: RouteNames.homeTbcResultNegative,

      builder: (context, state) {

        final data =
        state.extra as Map<String, dynamic>;

        return TbcResultNegativePage(
          resultData: data,
        );
      },
    ),
    GoRoute(
      path: profilePath,
      name: RouteNames.homeProfile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: personalDataPath,
      name: RouteNames.homePersonalData,
      builder: (context, state) => const PersonalDataPage(),
    ),
    GoRoute(
      path: changePasswordPath,
      name: RouteNames.homeChangePassword,
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: changeLanguagePath,
      name: RouteNames.homeChangeLanguage,
      builder: (context, state) => const ChangeLanguagePage(),
    ),
    GoRoute(
      path: aboutJatimPath,
      name: RouteNames.homeAboutJatim,
      builder: (context, state) => const AboutJatimPage(),
    ),
    GoRoute(
      path: termsConditionsPath,
      name: RouteNames.homeTermsConditions,
      builder: (context, state) => const TermsConditionsPage(),
    ),
    GoRoute(
      path: aboutMajadigiPath,
      name: RouteNames.homeAboutMajadigi,
      builder: (context, state) => const AboutMajadigiPage(),
    ),
  ];
}
