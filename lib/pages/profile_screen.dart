import 'package:flutter/material.dart';
import 'package:statemanagement/services/auth_services.dart';
import 'package:statemanagement/pages/auth/login_screen.dart';

const kPrimaryColor = Color(0xFF6C63FF);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final user = await AuthService().getProfile();
    await Future.delayed(const Duration(milliseconds: 500)); // animasi delay
    setState(() => _user = user);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        ),
      );
    }

    final name = _user?['name'] ?? '-';
    final email = _user?['email'] ?? '-';
    final createdAt = (_user?['created_at'] ?? '').toString();
    final tanggalDaftar = createdAt.isNotEmpty && createdAt.length >= 10
        ? createdAt.substring(0, 10)
        : '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor.withOpacity(0.05), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Foto profil dengan efek bayangan
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: kPrimaryColor.withOpacity(0.1),
                  child:
                      const Icon(Icons.person, size: 70, color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              Text(email, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 25),

              // Kartu informasi profil
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 6,
                shadowColor: kPrimaryColor.withOpacity(0.15),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Column(
                    children: [
                      _infoTile(Icons.email, "Email", email),
                      const Divider(),
                      _infoTile(Icons.calendar_today, "Tanggal Daftar",
                          tanggalDaftar),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol logout full width
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await AuthService().logout();
                    if (mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: kPrimaryColor, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        ),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
