import 'package:flutter/material.dart';
import 'package:major_project/screens/about.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              child: Text(
                "Stable Diffusion",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: Colors.red,
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'About',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AboutPg();
                  },
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
