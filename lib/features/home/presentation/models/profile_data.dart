import 'package:shared_preferences/shared_preferences.dart';

class ProfileData {
  const ProfileData({
    required this.fullName,
    required this.email,
    required this.nik,
    required this.address,
    required this.phoneNumber,
  });

  final String fullName;
  final String email;
  final String nik;
  final String address;
  final String phoneNumber;

  static Future<ProfileData> getRemoteProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final savedName = prefs.getString('user_real_name') ?? 'Guest';

    final savedEmail = prefs.getString('user_email') ?? 'name@gmail.com';

    final savedNik = prefs.getString('user_nik') ?? '3514075406040002';
    final savedAddress = prefs.getString('user_address') ?? 'jl suroyo Dsn Mulyorejo\nNo.07';
    final savedPhone = prefs.getString('user_phone') ?? '085748460431';

    return ProfileData(
      fullName: savedName,
      email: savedEmail,
      nik: savedNik,
      address: savedAddress,
      phoneNumber: savedPhone,
    );
  }
}
const demoProfileData = ProfileData(
  fullName: 'Anggun Amalia',
  email: 'anggunmedia1@gmail.com',
  nik: '3514075406040002',
  address: 'jl suroyo Dsn Mulyorejo\nNo.07',
  phoneNumber: '085748460431',
);