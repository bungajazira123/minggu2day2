import 'package:flutter/material.dart';

class QuranDetailScreen extends StatelessWidget {
  final String arti;
  final String asma;
  final int ayat;
  final String nama;
  final String type;
  final int urut;
  final String audio;
  final int nomor;
  final int rukuk;
  final String keterangan;

  const QuranDetailScreen({
    super.key,
    required this.arti,
    required this.asma,
    required this.ayat,
    required this.nama,
    required this.type,
    required this.urut,
    required this.audio,
    required this.nomor,
    required this.rukuk,
    required this.keterangan,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail Surah $nama'),
          backgroundColor: Colors.green[700],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    asma,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    nama,
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                InfoTile(title: "Arti", value: arti),
                InfoTile(title: "Jumlah Ayat", value: "$ayat ayat"),
                InfoTile(title: "Jenis", value: type),
                InfoTile(title: "Urutan Pewahyuan", value: urut.toString()),
                InfoTile(title: "Nomor Surah", value: nomor.toString()),
                InfoTile(title: "Jumlah Rukuk", value: rukuk.toString()),
                const SizedBox(height: 20),
                const Text(
                  "Keterangan:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  keterangan,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
