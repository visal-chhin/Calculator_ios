import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'calculator.dart'; // your calculator page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // function to open external link (safe version, no error throw)
  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    // app items with custom colors and updated links
    final List<Map<String, dynamic>> apps = [
      {
        "icon": Icons.facebook,
        "name": "Facebook",
        "link": "https://web.facebook.com/Imsal27",
        "color": Colors.blue
      },
      {
        "icon": Icons.video_library,
        "name": "YouTube",
        "link": "https://www.youtube.com/@salaugustt",
        "color": Colors.red
      },
      {
        "icon": Icons.code,
        "name": "GitHub",
        "link": "https://github.com/visal-chhin",
        "color": Colors.black
      },
      {
        "icon": Icons.camera_alt,
        "name": "Instagram",
        "link": "https://instagram.com",
        "color": Colors.purple
      },
      {
        "icon": Icons.alarm,
        "name": "Alarm",
        "link": "https://time.is/", // fallback instead of clock://
        "color": Colors.orange
      },
      {
        "icon": Icons.calculate,
        "name": "Calculator",
        "page": const Calculator(),
        "color": Colors.green
      },
      {
        "icon": Icons.send,
        "name": "Telegram",
        "link": "https://t.me/Imsal27",
        "color": Colors.lightBlue
      },
      {
        "icon": Icons.message,
        "name": "Messenger",
        "link": "https://messenger.com",
        "color": Colors.indigo
      },
      {
        "icon": Icons.account_balance,
        "name": "ABA",
        "link": "https://www.ababank.com",
        "color": Colors.blueAccent
      },
      {
        "icon": Icons.payment,
        "name": "Acleda",
        "link": "https://www.acledabank.com",
        "color": Colors.teal
      },
      {
        "icon": Icons.videogame_asset,
        "name": "MLBB",
        "link": "https://m.mobilelegends.com",
        "color": Colors.deepPurple
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.camera_outlined, size: 17, color: Colors.grey),
            Text(
              "11:49",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        actions: const [
          Row(
            children: [
              Icon(Icons.alarm, size: 17),
              SizedBox(width: 5),
              Icon(Icons.notifications_off, size: 17),
              SizedBox(width: 5),
              Icon(Icons.align_vertical_bottom_outlined, size: 15),
              SizedBox(width: 5),
              Icon(Icons.battery_3_bar_outlined, size: 17),
              SizedBox(width: 5),
            ],
          )
        ],
      ),
      body: Container(
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/img/sal.jpg"),
      fit: BoxFit.cover, // make it cover the screen
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: GridView.builder(
      itemCount: apps.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 per row
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final app = apps[index];
        return GestureDetector(
          onTap: () {
            if (app.containsKey("page")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => app["page"]),
              );
            } else if (app.containsKey("link")) {
              _openLink(app["link"]);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54, // add semi-transparent background for icons
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  app["icon"],
                  size: 40,
                  color: app["color"], // custom color
                ),
              ),
              const SizedBox(height: 5),
              Text(
                app["name"],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white, // text visible on background
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    ),
  ),
),

    );
  }
}
