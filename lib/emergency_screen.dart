import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'contact.dart';  // Import your Contact model file (Ensure this is created in your project)

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  late Box<Contact> contactsBox;  // Hive box for local storage

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  // Initialize Hive
  Future<void> _initializeHive() async {
    contactsBox = await Hive.openBox<Contact>('emergency_contacts');
  }

  Future<void> _addContact() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) return;

    // Add to Firebase
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('emergency_contacts')
        .add({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Add to Hive for local storage
    final contact = Contact(
      nickname: _nameController.text,
      phone: _phoneController.text,
      photoUrl: '',  // Can add photoUrl handling later if needed
    );
    await contactsBox.add(contact);

    _nameController.clear();
    _phoneController.clear();
  }

  Future<void> _deleteContact(String contactId) async {
    // Delete from Firebase
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('emergency_contacts')
        .doc(contactId)
        .delete();

    // Optionally delete from Hive as well if needed
    // contactsBox.delete(contactId);  // Requires additional ID handling in Hive
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Banner
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fakecall.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
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
                const Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    'Emergency Call',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.local_police),
                  label: const Text('Police'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 3,
                  ),
                  onPressed: () {},
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.local_hospital),
                  label: const Text('Ambulance'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    elevation: 3,
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Add Contact Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '+ Add Emergency Contact',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nickname',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Telephone',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _addContact,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Save Contact'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Contact List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser?.uid)
                    .collection('emergency_contacts')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final contacts = snapshot.data?.docs ?? [];

                  if (contacts.isEmpty) {
                    return const Center(child: Text("No emergency contacts yet."));
                  }

                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final data = contacts[index];
                      final name = data['name'];
                      final phone = data['phone'];
                      final id = data.id;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Card(
                          color: Colors.purple.shade100,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: const Icon(Icons.phone, color: Colors.black),
                            title: Text(name),
                            subtitle: Text(phone),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _deleteContact(id),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
