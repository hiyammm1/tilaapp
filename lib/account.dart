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
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            CircleAvatar(
              radius: 60,
              backgroundImage: user.photoURL != null
                  ? NetworkImage(user.photoURL!) 
                  : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider<Object>,
            ),
            const SizedBox(height: 20),
           
            Text(
              user.displayName ?? 'No name available', 
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
           
            Text(
              user.email ?? 'No email available', 
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () async {
             
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
