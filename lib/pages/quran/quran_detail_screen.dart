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

  static const primaryColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: primaryColor),
      home: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(nama),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withOpacity(0.85),
                          primaryColor.withOpacity(0.65),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        asma,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(
                        icon: Icons.translate,
                        title: "Arti",
                        value: arti,
                      ),
                      _buildInfoCard(
                        icon: Icons.format_list_numbered,
                        title: "Jumlah Ayat",
                        value: "$ayat ayat",
                      ),
                      _buildInfoCard(
                        icon: Icons.bookmark_border,
                        title: "Jenis",
                        value: type,
                      ),
                      _buildInfoCard(
                        icon: Icons.history,
                        title: "Urutan Pewahyuan",
                        value: urut.toString(),
                      ),
                      _buildInfoCard(
                        icon: Icons.filter_1,
                        title: "Nomor Surah",
                        value: nomor.toString(),
                      ),
                      _buildInfoCard(
                        icon: Icons.menu_book,
                        title: "Jumlah Rukuk",
                        value: rukuk.toString(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Keterangan:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        keterangan,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.15),
          foregroundColor: primaryColor,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
