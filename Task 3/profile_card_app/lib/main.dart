import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),

      // SafeArea keeps the content away from Android system buttons
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            100,
          ),

          child: Column(
            children: [

              // =========================
              // PROFILE SECTION
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  children: [

                    // Profile Picture
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue,

                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Name
                    const Text(
                      'Syed Ahmed Hassan',

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Profession
                    const Text(
                      'Flutter Developer & Student',

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // ABOUT SECTION
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      'About Me',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'I am a student learning Flutter development. '
                      'I enjoy creating mobile applications and learning '
                      'new programming skills.',

                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // CONTACT SECTION
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Contact Information',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Email
                    Row(
                      children: const [

                        Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'syed@example.com',

                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Phone
                    Row(
                      children: const [

                        Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          '+92 300 1234567',

                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Location
                    Row(
                      children: const [

                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Pakistan',

                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // ACTION BUTTONS
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  ElevatedButton(
                    onPressed: () {
                      // Functionality will be added later
                    },

                    child: const Text('Connect'),
                  ),

                  const SizedBox(width: 15),

                  OutlinedButton(
                    onPressed: () {
                      // Functionality will be added later
                    },

                    child: const Text('Message'),
                  ),
                ],
              ),

              // Extra bottom space
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}