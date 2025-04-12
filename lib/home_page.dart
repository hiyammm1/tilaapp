import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'report_incident.dart';
import 'emergency_screen.dart';
import 'view_incident.dart';
import 'current_location.dart';
import 'account.dart';
import 'forum.dart';
import 'know_the_condition.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Banner with Gradient and Back Button
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/fakecall.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.purple.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'Hello ${user?.displayName ?? "User"}, feeling unsafe?\nChoose a menu below',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 22, 21, 21),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Horizontal scroll section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _scrollCard(
                      context,
                      'Emergency call',
                      'assets/images/emergency_call.jpg',
                      const EmergencyScreen(),
                    ),
                    const SizedBox(width: 16),
                    _scrollCard(
                      context,
                      'Record incident',
                      'assets/images/record.jpg',
                      const ReportIncident(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Other features',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Other features in 2-column layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _featureBox(context, Icons.phone, 'Contact', const EmergencyScreen()),
                    _featureBox(context, Icons.location_on, 'Current location', const CurrentLocationScreen()),
                    _featureBox(context, Icons.directions_walk, 'Safest route', const CurrentLocationScreen()),
                    _featureBox(context, Icons.lightbulb, 'Know the condition', const KnowTheConditionPage()),
                    _featureBox(context, Icons.forum, 'Forum', const ForumPage()),
                    _featureBox(context, Icons.account_circle, 'Account', const AccountPage()),
                    _featureBox(context, Icons.visibility, 'View incidents', const ViewIncidentsScreen()),
                    _featureBox(context, Icons.report, 'Report incident', const ReportIncident()),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // Logout button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Horizontal scroll card
  Widget _scrollCard(BuildContext context, String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        width: 160,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(8),
        child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Animated feature box
  Widget _featureBox(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 1.0, end: 1.0),
        builder: (context, scale, child) => AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          child: child,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 2 - 24,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 3),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.purple),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
