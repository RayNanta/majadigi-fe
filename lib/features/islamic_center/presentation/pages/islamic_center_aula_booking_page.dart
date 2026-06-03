import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/features/islamic_center/services/islamic_center_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';



class IslamicCenterBookingPage extends StatefulWidget {
  const IslamicCenterBookingPage({
    super.key,
    required this.roomId,
  });

  final int roomId;

  @override
  State<IslamicCenterBookingPage> createState() =>
      _IslamicCenterBookingPageState();
}

class _IslamicCenterBookingPageState
    extends State<IslamicCenterBookingPage> {

  final IslamicCenterService _service =
  IslamicCenterService();

  Map<String, dynamic>? room;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRoom();
  }

  Future<void> loadRoom() async {
    try {
      final result = await _service.getRoomDetail(
        widget.roomId,
      );

      setState(() {
        room = result;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  final _fullNameController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedSession;
  final Set<int> _selectedFacilities = {};

  static const _sessions = ['Pagi', 'Siang', 'Sore', 'Full Day'];

  bool get _canSubmit =>
      _fullNameController.text.trim().isNotEmpty &&
      _selectedDate != null &&
      _selectedSession != null;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeIslamicCenterAulaRooms);
  }

  Future<void> _handleSubmit() async {
    try {
      final response = await _service.createBooking({
        'full_name': _fullNameController.text.trim(),
        'facility_room_id': widget.roomId,
        'booking_date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
        'session': _selectedSession,
        'facilities': _selectedFacilities.toList(),
      });

      final roomName = room?['name'] ?? 'Ruangan';

      final facilities = room!['facilities'] as List<dynamic>;
      final selectedFacilityNames = facilities
          .where((facility) =>
          _selectedFacilities.contains(facility['id']))
          .map((facility) => facility['name'].toString())
          .toList();

      final fasilitasText = selectedFacilityNames.join(', ');
      final message = '''
    Assalamu'alaikum Admin Islamic Center
    
Saya telah melakukan booking ruangan dengan detail berikut:
    
 📍 Nama Ruangan : $roomName
    
 👤 Nama Pemesan : ${_fullNameController.text}
 📅 Tanggal Booking : ${DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate!)}
 🕒 Sesi : $_selectedSession
    
 🏢 Fasilitas :
 ${fasilitasText.isEmpty ? '-' : fasilitasText}
    
    Terima kasih.
    ''';

      const phone = '6281267783531';

      final waUrl = Uri.parse(
        'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
      );

      await launchUrl(
        waUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking berhasil dibuat'),
        ),
      );
      
      print(response);

        } catch (e) {
          debugPrint(e.toString());
        }
      }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (room == null) {
      return const Scaffold(
        body: Center(
          child: Text('Room tidak ditemukan'),
        ),
      );
    }
    final facilities =
    room!['facilities'] as List<dynamic>;
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
                    onPressed: () => _handleBack(context),
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
                      'Booking Aula',
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
                      'Data Pemesanan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2E35),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Pastikan Anda mengisi data pemesanan dengan benar',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 34),
                    const _FieldLabel('Nama Lengkap'),
                    const SizedBox(height: 14),
                    _BookingTextField(
                      controller: _fullNameController,
                      hintText: 'Masukkan nama lengkap',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Tanggal'),
                    const SizedBox(height: 14),

                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2035),
                        );

                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 22,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F4),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? 'Pilih tanggal'
                              : DateFormat('dd MMMM yyyy').format(_selectedDate!),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            color: _selectedDate == null
                                ? const Color(0xFF8F949C)
                                : const Color(0xFF2A2E35),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Sesi'),
                    const SizedBox(height: 14),
                    _BookingDropdownField(
                      value: _selectedSession,
                      hintText: 'Pilih sesi',
                      items: _sessions,
                      onChanged: (value) => setState(() {
                        _selectedSession = value;
                      }),
                    ),
                    const SizedBox(height: 30),
                    const _FieldLabel('Fasilitas'),
                    const SizedBox(height: 18),

                    Wrap(
                      spacing: 18,
                      runSpacing: 18,
                      children: facilities.map((facility) {
                        final facilityId = facility['id'];
                        final facilityName = facility['name'];

                        final isSelected =
                        _selectedFacilities.contains(
                          facilityId,
                        );

                        return _FacilityOptionTile(
                          label: facilityName,
                          isSelected: isSelected,
                          isWide: false,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedFacilities.remove(facilityId);
                              } else {
                                _selectedFacilities.add(facilityId);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 22),
          child: SizedBox(
            height: 64,
            child: FilledButton(
              onPressed: _canSubmit ? _handleSubmit : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                disabledBackgroundColor: const Color(0xFFBFD4FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Pesan'),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF2A2E35),
      ),
    );
  }
}

class _BookingTextField extends StatelessWidget {
  const _BookingTextField({
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF2A2E35),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF8F949C),
        ),
        filled: true,
        fillColor: const Color(0xFFF1F1F4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: AppColors.welcomeAccent,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _BookingDropdownField extends StatelessWidget {
  const _BookingDropdownField({
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  final String? value;
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 32,
        color: Color(0xFF5F6368),
      ),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF2A2E35),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF8F949C),
        ),
        filled: true,
        fillColor: const Color(0xFFF1F1F4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: AppColors.welcomeAccent,
            width: 1.5,
          ),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(value: item, child: Text(item)),
          )
          .toList(),
    );
  }
}

class _FacilityOptionTile extends StatelessWidget {
  const _FacilityOptionTile({
    required this.label,
    required this.isSelected,
    required this.isWide,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isWide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = isWide
        ? double.infinity
        : (MediaQuery.of(context).size.width - 66) / 2;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFEAF2FF)
                : const Color(0xFFF1F1F4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? AppColors.welcomeAccent : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.welcomeAccent
                        : const Color(0xFF979AA1),
                    width: 2,
                  ),
                  color: isSelected
                      ? AppColors.welcomeAccent
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 24,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4E535A),
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
