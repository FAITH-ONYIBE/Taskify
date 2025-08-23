import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/theme/themeprovider.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Color(0xFF0A174E),
        color: Theme.of(context).scaffoldBackgroundColor,
        //  color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Profile picture with border
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.purple],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withValues(alpha: 0.6),
                        spreadRadius: 0.6,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/pfp.jpeg'),
                  ),
                ),

                // Back/close button
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.onPrimary, 
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              'Faith',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Theme.of(context).iconTheme.color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Perpetual",
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.bookmark_border,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Templates",
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.grid_view,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Categories",
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.analytics,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Analytics",
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.settings, color:  Theme.of(context).iconTheme.color),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),

            Spacer(),
            IconButton(
              icon: Icon(
                Provider.of<Themeprovider>(context).themeData.brightness ==
                        Brightness.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                Provider.of<Themeprovider>(
                  context,
                  listen: false,
                ).toggleTheme();
              },
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.logout_sharp,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
