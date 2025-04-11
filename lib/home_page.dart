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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Greeting & Header
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/fakecall.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.purple.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Hello ${user?.displayName ?? "User"}, feeling unsafe?\nChoose a menu below',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

           
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Other features',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

            
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _iconFeature(context, Icons.phone, 'Contact', const EmergencyScreen()),
                    _iconFeature(context, Icons.location_on, 'Current location', const CurrentLocationScreen()),
                    _iconFeature(context, Icons.directions_walk, 'Safest route', const CurrentLocationScreen()),
                    _iconFeature(context, Icons.lightbulb, 'Know the condition', const KnowTheConditionPage()),
                    _iconFeature(context, Icons.forum, 'Forum', const ForumPage()),
                    _iconFeature(context, Icons.account_circle, 'Account', const AccountPage()),
                    _iconFeature(context, Icons.visibility, 'View incidents', const ViewIncidentsScreen()),
                    _iconFeature(context, Icons.report, 'Report incident', const ReportIncident()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _iconFeature(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.purple),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
