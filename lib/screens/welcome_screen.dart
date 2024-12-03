import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background dengan gradasi lembut
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6A9EC3),
                    Color(0xFF3A6FA5),
                  ],
                ),
              ),
            ),

            // Konten utama
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ilustrasi SVG (gunakan placeholder jika belum ada SVG)
                  SvgPicture.asset(
                    'assets/productivity_illustration.svg',
                    width: 250,
                    height: 250,
                    // Jika SVG belum tersedia, gunakan placeholder:
                    // placeholderBuilder: (context) => Icon(Icons.image, size: 250),
                  ),

                  SizedBox(height: 30),

                  // Judul dengan gaya Google Fonts
                  Text(
                    'Focus & Achieve',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Kelola tugas Anda dengan timer cerdas dan fokus penuh. Selesaikan tugas lebih efisien.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Tombol Mulai
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman utama/daftar tugas
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Mulai Sekarang',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF3A6FA5),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
