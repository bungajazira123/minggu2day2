import 'package:flutter/material.dart';
import 'package:statemanagement/pages/quran/quran_detail_screen.dart';
import 'package:statemanagement/models/quran_model.dart';
import 'package:statemanagement/services/quran_services.dart';

class QuranListScreen extends StatelessWidget {
  const QuranListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Daftar Surah')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber[50],
          child: FutureBuilder<List<QuranModel>>(
            future: QuranServices.fetchQuran(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final surahs = snapshot.data ?? [];
              return ListView.builder(
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  final data = surahs[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green[100],
                        child: Text(data.nomor.toString()),
                      ),
                      title: Text(data.nama),
                      subtitle: Text('${data.arti} • ${data.ayat} Ayat'),
                      trailing: const Icon(Icons.arrow_forward_ios),
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
