import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class TbcPersonalIdentityPage extends StatefulWidget {
  const TbcPersonalIdentityPage({super.key});

  @override
  State<TbcPersonalIdentityPage> createState() =>
      _TbcPersonalIdentityPageState();
}

class _TbcPersonalIdentityPageState extends State<TbcPersonalIdentityPage> {
  late final TextEditingController _phoneController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  late final TextEditingController _addressController;

  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;
  String? _selectedOccupation;
  String? _selectedCity;
  String? _selectedDistrict;
  String? _selectedVillage;

  static final _yearOptions = List<int>.generate(
    DateTime.now().year - 1939,
    (index) => DateTime.now().year - index,
  );

  static const _monthOptions = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const _occupationOptions = [
    'Pelajar/Mahasiswa',
    'Pegawai Swasta',
    'ASN',
    'Wiraswasta',
    'Ibu Rumah Tangga',
    'Lainnya',
  ];

  static const _cityOptions = [
    'Kota Surabaya',
    'Kota Malang',
    'Kabupaten Sidoarjo',
    'Kabupaten Jember',
    'Kabupaten Banyuwangi',
  ];

  static const _districtOptions = [
    'Klojen',
    'Lowokwaru',
    'Blimbing',
    'Sukun',
    'Kedungkandang',
  ];

  static const _villageOptions = [
    'Bareng',
    'Rampal Celaket',
    'Dinoyo',
    'Tulusrejo',
    'Mulyorejo',
  ];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  List<int> get _dayOptions {
    if (_selectedYear == null || _selectedMonth == null) {
      return List<int>.generate(31, (index) => index + 1);
    }

    final daysInMonth = DateTime(_selectedYear!, _selectedMonth! + 1, 0).day;
    return List<int>.generate(daysInMonth, (index) => index + 1);
  }

  int get _computedAge {
    if (_selectedYear == null ||
        _selectedMonth == null ||
        _selectedDay == null) {
      return 0;
    }

    final now = DateTime.now();
    final birthDate = DateTime(_selectedYear!, _selectedMonth!, _selectedDay!);
    var age = now.year - birthDate.year;

    final hasHadBirthdayThisYear =
        now.month > birthDate.month ||
        (now.month == birthDate.month && now.day >= birthDate.day);

    if (!hasHadBirthdayThisYear) {
      age -= 1;
    }

    return age < 0 ? 0 : age;
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeTbcIdentityForm);
  }

  void _handleNext() {
    context.pushNamed(RouteNames.homeTbcScreeningFormOne);
  }

  Future<void> _selectYear() async {
    final selectedValue = await _showOptionSheet<int>(
      title: 'Pilih Tahun',
      options: _yearOptions,
      currentValue: _selectedYear,
      labelBuilder: (value) => value.toString(),
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedYear = selectedValue;
      if (_selectedMonth != null &&
          _selectedDay != null &&
          !_dayOptions.contains(_selectedDay)) {
        _selectedDay = null;
      }
    });
  }

  Future<void> _selectMonth() async {
    final selectedValue = await _showOptionSheet<int>(
      title: 'Pilih Bulan',
      options: List<int>.generate(_monthOptions.length, (index) => index + 1),
      currentValue: _selectedMonth,
      labelBuilder: (value) => _monthOptions[value - 1],
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedMonth = selectedValue;
      if (_selectedDay != null && !_dayOptions.contains(_selectedDay)) {
        _selectedDay = null;
      }
    });
  }

  Future<void> _selectDay() async {
    final selectedValue = await _showOptionSheet<int>(
      title: 'Pilih Tanggal',
      options: _dayOptions,
      currentValue: _selectedDay,
      labelBuilder: (value) => value.toString(),
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedDay = selectedValue;
    });
  }

  Future<void> _selectOccupation() async {
    final selectedValue = await _showOptionSheet<String>(
      title: 'Pilih Pekerjaan',
      options: _occupationOptions,
      currentValue: _selectedOccupation,
      labelBuilder: (value) => value,
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedOccupation = selectedValue;
    });
  }

  Future<void> _selectCity() async {
    final selectedValue = await _showOptionSheet<String>(
      title: 'Pilih Kabupaten/Kota',
      options: _cityOptions,
      currentValue: _selectedCity,
      labelBuilder: (value) => value,
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedCity = selectedValue;
    });
  }

  Future<void> _selectDistrict() async {
    final selectedValue = await _showOptionSheet<String>(
      title: 'Pilih Kecamatan',
      options: _districtOptions,
      currentValue: _selectedDistrict,
      labelBuilder: (value) => value,
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedDistrict = selectedValue;
    });
  }

  Future<void> _selectVillage() async {
    final selectedValue = await _showOptionSheet<String>(
      title: 'Pilih Kelurahan/Desa',
      options: _villageOptions,
      currentValue: _selectedVillage,
      labelBuilder: (value) => value,
    );

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedVillage = selectedValue;
    });
  }

  Future<T?> _showOptionSheet<T>({
    required String title,
    required List<T> options,
    required T? currentValue,
    required String Function(T value) labelBuilder,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        final maxHeight = MediaQuery.sizeOf(context).height * 0.68;

        return SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 54,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD5D8DF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: options.map((option) {
                        final isSelected = option == currentValue;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            labelBuilder(option),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.welcomeAccent
                                  : AppColors.textPrimary,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: AppColors.welcomeAccent,
                                )
                              : null,
                          onTap: () => context.pop(option),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 36),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Formulir Identitas',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identitas Anda',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.welcomeAccent,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _ProfileField(
                      label: 'No. Telepon/HP',
                      hintText: 'Cth: 085678910111',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Tahun Lahir',
                      hintText: 'Pilih Tahun',
                      value: _selectedYear?.toString(),
                      onTap: _selectYear,
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Bulan Lahir',
                      hintText: 'Pilih Bulan',
                      value: _selectedMonth == null
                          ? null
                          : _monthOptions[_selectedMonth! - 1],
                      onTap: _selectMonth,
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Tanggal Lahir',
                      hintText: 'Pilih Tanggal',
                      value: _selectedDay?.toString(),
                      onTap: _selectDay,
                    ),
                    const SizedBox(height: 24),
                    _ReadOnlyProfileField(
                      label: 'Umur (Otomatis)',
                      value: '$_computedAge Tahun',
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _ProfileField(
                            label: 'Berat Badan (Kg)',
                            hintText: 'cth: 56',
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _ProfileField(
                            label: 'Tinggi Badan (Cm)',
                            hintText: 'cth: 160',
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _ProfileField(
                      label: 'Alamat Domisili',
                      hintText: 'Cth: Jl. Gubeng No. 12',
                      controller: _addressController,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Pekerjaan',
                      hintText: 'Pilih Pekerjaan',
                      value: _selectedOccupation,
                      onTap: _selectOccupation,
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Kabupaten/Kota',
                      hintText: 'Pilih Kabupaten/Kota',
                      value: _selectedCity,
                      onTap: _selectCity,
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Kecamatan',
                      hintText: 'Pilih Kecamatan',
                      value: _selectedDistrict,
                      onTap: _selectDistrict,
                    ),
                    const SizedBox(height: 24),
                    _DropdownProfileField(
                      label: 'Kelurahan/Desa',
                      hintText: 'Pilih Kelurahan/Desa',
                      value: _selectedVillage,
                      onTap: _selectVillage,
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: OutlinedButton(
                    onPressed: _handleBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.welcomeAccent,
                      side: const BorderSide(
                        color: AppColors.welcomeAccent,
                        width: 1.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Sebelumnya'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: FilledButton(
                    onPressed: _handleNext,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.welcomeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Selanjutnya'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF55585E),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFA9AAB0),
            ),
            filled: true,
            fillColor: const Color(0xFFF0F0F2),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 22,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(
                color: AppColors.welcomeAccent,
                width: 1.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownProfileField extends StatelessWidget {
  const _DropdownProfileField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String hintText;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 14),
        Material(
          color: const Color(0xFFF0F0F2),
          borderRadius: BorderRadius.circular(22),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value ?? hintText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: value == null
                            ? const Color(0xFFA9AAB0)
                            : const Color(0xFF55585E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Color(0xFF666870),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadOnlyProfileField extends StatelessWidget {
  const _ReadOnlyProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F2),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFA9AAB0),
            ),
          ),
        ),
      ],
    );
  }
}
