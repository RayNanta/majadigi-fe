import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class TbcPersonalIdentityPage extends StatefulWidget {

  final Map<String, dynamic> formData;

  const TbcPersonalIdentityPage({
    super.key,
    required this.formData,
  });

  @override
  State<TbcPersonalIdentityPage> createState() =>
      _TbcPersonalIdentityPageState();
}

class _TbcPersonalIdentityPageState
    extends State<TbcPersonalIdentityPage> {

  late final TextEditingController _phoneController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  late final TextEditingController _ageController;
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
  ];

  static const _districtOptions = [
    'Klojen',
    'Lowokwaru',
    'Blimbing',
  ];

  static const _villageOptions = [
    'Bareng',
    'Dinoyo',
    'Mulyorejo',
  ];

  @override
  void initState() {
    super.initState();

    _phoneController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _ageController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  List<int> get _dayOptions {

    if (_selectedYear == null ||
        _selectedMonth == null) {

      return List.generate(31, (i) => i + 1);
    }

    final days = DateTime(
      _selectedYear!,
      _selectedMonth! + 1,
      0,
    ).day;

    return List.generate(days, (i) => i + 1);
  }

  int get _computedAge {

    if (_selectedYear == null ||
        _selectedMonth == null ||
        _selectedDay == null) {

      return 0;
    }

    final now = DateTime.now();

    final birthDate = DateTime(
      _selectedYear!,
      _selectedMonth!,
      _selectedDay!,
    );

    int age = now.year - birthDate.year;

    final hasBirthday =
        now.month > birthDate.month ||
            (now.month == birthDate.month &&
                now.day >= birthDate.day);

    if (!hasBirthday) {
      age--;
    }

    return age;
  }

  void _handleBack() {
    context.pop();
  }

  void _handleNext() {

    final fullData = {

      ...widget.formData,

      "no_telp":
      _phoneController.text,

      "tahun_lahir":
      _selectedYear,

      "bulan_lahir":
      _selectedMonth,

      "tanggal_lahir":
      _selectedDay,

      "umur":
      _ageController.text,

      "berat_badan":
      _weightController.text,

      "tinggi_badan":
      _heightController.text,

      "alamat":
      _addressController.text,

      "pekerjaan":
      _selectedOccupation,

      "kabupaten":
      _selectedCity,

      "kecamatan":
      _selectedDistrict,

      "kelurahan":
      _selectedVillage,
    };

    context.pushNamed(
      RouteNames.homeTbcScreeningFormOne,
      extra: fullData,
    );
  }

  Future<void> _selectYear() async {

    final result =
    await _showOptionSheet<int>(
      title: 'Pilih Tahun',
      options: _yearOptions,
      currentValue: _selectedYear,
      labelBuilder: (v) => v.toString(),
    );

    if (result == null) return;

    setState(() {
      _selectedYear = result;
    });
  }

  Future<void> _selectMonth() async {

    final result =
    await _showOptionSheet<int>(
      title: 'Pilih Bulan',
      options: List.generate(
        _monthOptions.length,
            (i) => i + 1,
      ),
      currentValue: _selectedMonth,
      labelBuilder:
          (v) => _monthOptions[v - 1],
    );

    if (result == null) return;

    setState(() {
      _selectedMonth = result;
    });
  }

  Future<void> _selectDay() async {

    final result =
    await _showOptionSheet<int>(
      title: 'Pilih Tanggal',
      options: _dayOptions,
      currentValue: _selectedDay,
      labelBuilder: (v) => v.toString(),
    );

    if (result == null) return;

    setState(() {
      _selectedDay = result;
    });
  }

  Future<void> _selectOccupation() async {

    final result =
    await _showOptionSheet<String>(
      title: 'Pilih Pekerjaan',
      options: _occupationOptions,
      currentValue: _selectedOccupation,
      labelBuilder: (v) => v,
    );

    if (result == null) return;

    setState(() {
      _selectedOccupation = result;
    });
  }

  Future<void> _selectCity() async {

    final result =
    await _showOptionSheet<String>(
      title: 'Pilih Kabupaten/Kota',
      options: _cityOptions,
      currentValue: _selectedCity,
      labelBuilder: (v) => v,
    );

    if (result == null) return;

    setState(() {
      _selectedCity = result;
    });
  }

  Future<void> _selectDistrict() async {

    final result =
    await _showOptionSheet<String>(
      title: 'Pilih Kecamatan',
      options: _districtOptions,
      currentValue: _selectedDistrict,
      labelBuilder: (v) => v,
    );

    if (result == null) return;

    setState(() {
      _selectedDistrict = result;
    });
  }

  Future<void> _selectVillage() async {

    final result =
    await _showOptionSheet<String>(
      title: 'Pilih Kelurahan',
      options: _villageOptions,
      currentValue: _selectedVillage,
      labelBuilder: (v) => v,
    );

    if (result == null) return;

    setState(() {
      _selectedVillage = result;
    });
  }

  Future<T?> _showOptionSheet<T>({
    required String title,
    required List<T> options,
    required T? currentValue,
    required String Function(T value)
    labelBuilder,
  }) async {

    return showModalBottomSheet<T>(
      context: context,

      backgroundColor: Colors.white,

      shape:
      const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),

      builder: (context) {

        return SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.all(24),

            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style:
                  GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                Flexible(
                  child: ListView(
                    shrinkWrap: true,

                    children:
                    options.map((e) {

                      final selected =
                          e == currentValue;

                      return ListTile(
                        title: Text(
                          labelBuilder(e),
                        ),

                        trailing:
                        selected
                            ? const Icon(
                          Icons.check,
                          color: AppColors
                              .welcomeAccent,
                        )
                            : null,

                        onTap: () {
                          context.pop(e);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(0xFFF7F9FF),

      appBar: AppBar(
        backgroundColor:
        AppColors.welcomeAccent,

        title: const Text(
          'Formulir Identitas',
        ),
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            _ProfileField(
              label: 'No Telepon',
              hintText: '08xxxxxxxxxx',
              controller: _phoneController,
              keyboardType:
              TextInputType.phone,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Tahun Lahir',
              value:
              _selectedYear?.toString(),
              hintText: 'Pilih Tahun',
              onTap: _selectYear,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Bulan Lahir',
              value:
              _selectedMonth == null
                  ? null
                  : _monthOptions[
              _selectedMonth! - 1
              ],
              hintText: 'Pilih Bulan',
              onTap: _selectMonth,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Tanggal Lahir',
              value:
              _selectedDay?.toString(),
              hintText: 'Pilih Tanggal',
              onTap: _selectDay,
            ),

            const SizedBox(height: 20),

            _ProfileField(
              label: 'Umur',
              hintText: 'Masukkan umur',
              controller: _ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _ProfileField(
                    label: 'Berat Badan',
                    hintText: '56',
                    controller:
                    _weightController,
                    keyboardType:
                    TextInputType.number,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _ProfileField(
                    label: 'Tinggi Badan',
                    hintText: '160',
                    controller:
                    _heightController,
                    keyboardType:
                    TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _ProfileField(
              label: 'Alamat',
              hintText: 'Masukkan alamat',
              controller:
              _addressController,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Pekerjaan',
              value:
              _selectedOccupation,
              hintText:
              'Pilih pekerjaan',
              onTap:
              _selectOccupation,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Kabupaten/Kota',
              value:
              _selectedCity,
              hintText:
              'Pilih kota',
              onTap: _selectCity,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Kecamatan',
              value:
              _selectedDistrict,
              hintText:
              'Pilih kecamatan',
              onTap:
              _selectDistrict,
            ),

            const SizedBox(height: 20),

            _DropdownField(
              label: 'Kelurahan',
              value:
              _selectedVillage,
              hintText:
              'Pilih kelurahan',
              onTap:
              _selectVillage,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 60,

              child: FilledButton(
                onPressed: _handleNext,

                style:
                FilledButton.styleFrom(
                  backgroundColor:
                  AppColors
                      .welcomeAccent,
                ),

                child: const Text(
                  'Selanjutnya',
                ),
              ),
            ),
          ],
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
    this.inputFormatters
  });

  final List<TextInputFormatter>? inputFormatters;
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(label),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          keyboardType:
          keyboardType,

          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor:
            const Color(0xFFF0F0F2),

            border:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(16),
              borderSide:
              BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {

  const _DropdownField({
    required this.label,
    required this.value,
    required this.hintText,
    required this.onTap,
  });

  final String label;
  final String? value;
  final String hintText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(label),

        const SizedBox(height: 8),

        InkWell(
          onTap: onTap,

          child: Container(
            width: double.infinity,

            padding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),

            decoration: BoxDecoration(
              color:
              const Color(0xFFF0F0F2),

              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Text(
              value ?? hintText,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadOnlyField extends StatelessWidget {

  const _ReadOnlyField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(label),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,

          padding:
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),

          decoration: BoxDecoration(
            color:
            const Color(0xFFF0F0F2),

            borderRadius:
            BorderRadius.circular(16),
          ),

          child: Text(value),
        ),
      ],
    );
  }
}