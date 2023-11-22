import 'package:flutter/material.dart';
import 'package:labfinal/profile/portfolio.dart';

import 'about.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Personal Portfolio'),
            backgroundColor: Colors.teal,
            centerTitle: true,
            bottom: const TabBar(isScrollable: true, tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'About',
              ),
              Tab(
                icon: Icon(Icons.photo_library),
                text: 'Portfolio',
              ),
            ]),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const UserAccountsDrawerHeader(
                  accountName:
                  Text('Yasin Mia Palash'), // Replace with your name
                  accountEmail: Text(
                      'yasin15-3615@diu.edu.bd'), // Replace with your email
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://scontent.fdac24-4.fna.fbcdn.net/v/t39.30808-6/277527095_3251077045115106_6333351956922904215_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=1b51e3&_nc_eui2=AeGLLWoOCbo5sYUOQ2vEQhWgkPwQP2Ledu-Q_BA_Yt527-gQQ9JOjW1XDeVxCWFwD9YgODOPdM5OC-aLA7yrsf0-&_nc_ohc=7Uiqshc3KMQAX8YUivq&_nc_ht=scontent.fdac24-4.fna&oh=00_AfB_WcmXzNRrZb_W4uphiytpkXE92cgY5TuEWx_ocU4aWA&oe=651C2F28'), // Replace with your profile image asset
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AboutPage())); // Close the drawer
                  },
                ),

                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Portfolio'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PortfolioPage())); // Close the drawer
                  },
                ),
                // Add more drawer items for other sections/pages
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AboutPage(),
              PortfolioPage()
            ],
          ),
        ));
  }
}
