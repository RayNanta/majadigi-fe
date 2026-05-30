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
import '../hoax_clinic/presentation/pages/hoax_clinic_page.dart';
import '../hoax_clinic/presentation/pages/hoax_clinic_main_page.dart';
import '../hoax_clinic/presentation/pages/hoax_latest_report_detail_page.dart';
import '../hoax_clinic/presentation/pages/hoax_latest_reports_page.dart';
import '../hoax_clinic/presentation/pages/hoax_report_page.dart';
import '../hoax_clinic/presentation/pages/hoax_track_report_page.dart';
import '../hoax_clinic/presentation/pages/hoax_track_result_page.dart';
import '../sinaker/presentation/pages/sinaker_main_page.dart';
import '../sinaker/presentation/pages/sinaker_page.dart';
import '../sinaker/presentation/pages/sinaker_training_center_sumenep_page.dart';
import '../sinaker/presentation/pages/sinaker_training_centers_page.dart';
import '../sinaker/presentation/pages/sinaker_training_registration_list.dart';
import '../sinaker/presentation/pages/sinaker_training_registration_check_page.dart';
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
  static const tbcScreeningPath = '/layanan/skrining-tbc';
  static const sinakerPath = '/layanan/sinaker';
  static const sinakerMainPath = '/layanan/sinaker/utama';
  static const sinakerTrainingListPath = '/layanan/sinaker/utama/pelatihan';
  static const sinakerTrainingCentersPath = '/layanan/sinaker/utama/blk';
  static const sinakerTrainingCenterSumenepPath =
      '/layanan/sinaker/utama/blk/sumenep';
  static const sinakerTrainingRegistrationCheckPath =
      '/layanan/sinaker/utama/cek-pendaftaran';
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
      path: tbcScreeningPath,
      name: RouteNames.homeTbcScreening,
      builder: (context, state) => const TbcScreeningPage(),
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
