import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({Key? key}) : super(key: key);

  Widget buildPost({
    required String name,
    required String date,
    required String message,
    List<Map<String, String>>? replies,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, size: 20),
              const SizedBox(width: 8),
              Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(message),
          const SizedBox(height: 4),
          if (replies != null)
            ...replies.map((reply) => Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xfff0f0f0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, size: 16),
                          const SizedBox(width: 6),
                          Text(reply['name'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                          const Spacer(),
                          Text(reply['date'] ?? '',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(reply['message'] ?? '',
                          style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf6f7),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xfffbd1dc), Color(0xfffceae6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.forum, color: Colors.white, size: 24),
                        SizedBox(width: 8),
                        Text("Forum",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("Share your experience",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for User',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildPost(
                  name: 'Dibora Shibeshi Tekle',
                  date: '12 Oktober 2020',
                  message:
                      "Sis, do you have any experience walking alone? Tell me about it, it's my first time working. I’m scared to go home alone at night huhuhu",
                  replies: [
                    {
                      'name': 'Selina Nanami Putri',
                      'date': '12 Oktober 2020',
                      'message':
                          'Wow, good luck with your work! I used to get catcalled by people while walking, but I didn’t react, just kept walking. Don’t put on a scared face, stay calm Sis'
                    },
                    {
                      'name': 'Cecilio Nicho Putri',
                      'date': '12 Oktober 2020',
                      'message':
                          'At that time, the road on my way home was quite dark, with very little lighting and a damaged road all along the way. I always prayed, stayed focused, and kept my phone on... even though my mind wasn’t calm because I was scared of muggers, hehe'
                    },
                    {
                      'name': 'Lia Maliadevas',
                      'date': '12 Oktober 2020',
                      'message':
                          'Hey Bun! Back in college, I was really into organizing stuff. I had to go home late, and suddenly someone started stalking me. I was scared, so I pretended to call a friend, then stopped by a food stall, and the seller calmed me down...'
                    },
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              icon: const Icon(Icons.edit),
              label: const Text("Write Your Story"),
              onPressed: () {
                // TODO: Navigate to story writing screen
              },
            ),
          )
        ],
      ),
    );
  }
}
