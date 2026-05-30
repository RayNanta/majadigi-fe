import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/app/router/route_names.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../services/sinaker_service.dart';

class MyTraining {
  final int id;
  final String status;
  final String trainingName;
  final String centerName;

  MyTraining({
    required this.id,
    required this.status,
    required this.trainingName,
    required this.centerName,
  });

  factory MyTraining.fromJson(Map<String, dynamic> json) {
    return MyTraining(
      id: json['id'],
      status: json['status'] ?? '',
      trainingName: json['training']['nama_pelatihan'] ?? '',
      centerName: json['training']['center']['nama'] ?? '',
    );
  }
}

class SinakerTrainingRegistrationListPage extends StatefulWidget {
  const SinakerTrainingRegistrationListPage({super.key});

  @override
  State<SinakerTrainingRegistrationListPage> createState() =>
      _SinakerTrainingRegistrationListPageState();
}

class _SinakerTrainingRegistrationListPageState
    extends State<SinakerTrainingRegistrationListPage> {
  final _service = SinakerService();

  bool _loading = true;
  List<MyTraining> _trainings = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await _service.getMyTrainings();

      setState(() {
        _trainings = data;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'diterima':
        return Colors.green;

      case 'ditolak':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'diterima':
        return 'Diterima';

      case 'ditolak':
        return 'Ditolak';

      default:
        return 'Menunggu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      appBar: AppBar(
        backgroundColor: AppColors.welcomeAccent,
        foregroundColor: Colors.white,
        title: Text(
          'Pendaftaran Saya',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _trainings.isEmpty
          ? Center(
        child: Text(
          'Belum ada pendaftaran pelatihan',
          style: GoogleFonts.plusJakartaSans(),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _trainings.length,
        itemBuilder: (context, index) {
          final item = _trainings[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(
                      item.status,
                    ).withValues(alpha: 0.12),
                    borderRadius:
                    BorderRadius.circular(100),
                  ),
                  child: Text(
                    _statusLabel(item.status),
                    style: GoogleFonts.plusJakartaSans(
                      color:
                      _statusColor(item.status),
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  item.trainingName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.centerName,
                      style:
                      GoogleFonts.plusJakartaSans(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.pushNamed(
                        RouteNames.homeSinakerTrainingRegistrationCheck,
                        extra: item.id,
                      );
                    },
                    child: const Text(
                      'Lihat Detail',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}