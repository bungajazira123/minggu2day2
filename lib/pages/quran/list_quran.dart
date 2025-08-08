import 'package:flutter/material.dart';
import 'package:statemanagement/pages/quran/quran_detail_screen.dart';
import 'package:statemanagement/models/quran_model.dart';
import 'package:statemanagement/services/quran_services.dart';

class QuranListScreen extends StatelessWidget {
  const QuranListScreen({super.key});

  static const primaryColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Surah'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.deepPurple.shade50,
          child: FutureBuilder<List<QuranModel>>(
            future: QuranServices.fetchQuran(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final surahs = snapshot.data ?? [];

              if (surahs.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada data surah',
                    style: TextStyle(color: primaryColor, fontSize: 16),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  final data = surahs[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuranDetailScreen(
                            arti: data.arti,
                            asma: data.asma,
                            ayat: data.ayat,
                            nama: data.nama,
                            type: data.type,
                            urut: data.urut,
                            audio: data.audio,
                            nomor: data.nomor,
                            rukuk: data.rukuk,
                            keterangan: data.keterangan,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.85),
                            primaryColor.withOpacity(0.65),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryColor,
                          radius: 24,
                          child: Text(
                            data.nomor.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        title: Text(
                          data.nama,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          '${data.arti} • ${data.ayat} Ayat',
                          style: Colors.white70 != null
                              ? const TextStyle(color: Colors.white70)
                              : null,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
