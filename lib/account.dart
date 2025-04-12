import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: const Center(
          child: Text('No user logged in. Please log in first.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE1BEE7), Color(0xFFF3E5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                    IconButton(
      icon: const Icon(Icons.arrow_back, size: 24),
      onPressed: () {
        Navigator.pop(context); // Takes the user back to the previous screen
      },
    ),
                  const SizedBox(width: 12),
                  const Text(
                    'Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              user.displayName ?? 'No name available',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              user.email ?? 'No email available',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Profile account section
            sectionTitle('Profile Account'),
            customButton(
              icon: Icons.lock_outline,
              title: 'Account',
              subtitle: 'Change your password/Gmail for security, friend',
              onTap: () {},
            ),
            customButton(
              icon: Icons.edit_note,
              title: 'Change Password & Gmail',
              subtitle: 'Change your name and phone number',
              onTap: () {},
            ),
            customButton(
              icon: Icons.notifications_none,
              title: 'Notification',
              subtitle: 'Help you with your activities',
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Help Center section
            sectionTitle('Help Center'),
            customButton(
              icon: Icons.contact_support,
              title: 'Contact Us',
              subtitle: 'Have questions? Just contact us',
              onTap: () {},
              backgroundColor: Colors.pink.shade100,
            ),
            customButton(
              icon: Icons.question_answer_outlined,
              title: 'FAQ',
              subtitle: 'Find frequently asked questions',
              onTap: () {},
            ),

            const SizedBox(height: 40),

            // Logout Button
            Center(
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.logout, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Logout',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          // Add navigation actions if needed
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: '',
          ),
        ],
      ),
    );
  }

  // Reusable Section Title Widget
  Widget sectionTitle(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Reusable Custom Button Widget
  Widget customButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? backgroundColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFFE1BEE7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
