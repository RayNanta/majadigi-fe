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
}

const demoProfileData = ProfileData(
  fullName: 'Anggun Amalia',
  email: 'anggunmedia1@gmail.com',
  nik: '3514075406040002',
  address: 'jl suroyo Dsn Mulyorejo\nNo.07',
  phoneNumber: '085748460431',
);
