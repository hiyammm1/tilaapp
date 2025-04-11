import 'package:flutter/material.dart';

class KnowTheConditionPage extends StatelessWidget {
  const KnowTheConditionPage({Key? key}) : super(key: key);

  Widget buildCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Colors.black87),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf6f7),
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Know the condition"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("What to do",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800])),
          ),
          buildCard(
            icon: Icons.directions_walk,
            title: "Tips & Tricks When Walking Outside",
            description:
                "Provides tips & tricks for walking outside to stay safe while engaging in activities",
            color: Colors.lightBlueAccent,
          ),
          buildCard(
            icon: Icons.security,
            title: "Self-Defense Training",
            description:
                "Provides online security and self-defense training that can be accessed by users through the app",
            color: Colors.purpleAccent,
          ),
          buildCard(
            icon: Icons.sos,
            title: "Emergency Handling Guide",
            description:
                "Provides a step-by-step guide on what to do in emergency situations",
            color: Colors.tealAccent,
          ),
          buildCard(
            icon: Icons.contact_phone,
            title: "Emergency Contact Information",
            description:
                "Provides emergency contact information, including emergency phone numbers",
            color: Colors.amberAccent,
          ),
          buildCard(
            icon: Icons.balance,
            title: "Legal Resources",
            description:
                "Provides information about women’s legal rights, legal steps that can be taken, and how to report to the police or relevant authorities",
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }
}
