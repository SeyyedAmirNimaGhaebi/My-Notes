import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_notes/controllers/settings_controller.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

final settingsController = Get.find<SettingsController>();

class _FAQScreenState extends State<FAQScreen> {
  // ignore: unused_field
  bool _tabNotes = false;
  // ignore: unused_field
  bool _tabTodos = false;
  // ignore: unused_field
  bool _tabFavorites = false;
  // ignore: unused_field
  bool _tabSettings = false;
  // ignore: unused_field
  bool _tabQuestion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingsController.backgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            CupertinoIcons.back,
            size: 30,
            color: settingsController.isDark ? Colors.white : Colors.black,
          ),
        ),
        foregroundColor: settingsController.isDark ? Colors.white : Colors.black,
        title: Text(
          'FQA',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: settingsController.isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsController.backgroundColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  leading: const Icon(Iconsax.note),
                  textColor: settingsController.themeColor,
                  iconColor: settingsController.themeColor,
                  collapsedBackgroundColor: settingsController.primaryColor,
                  backgroundColor: settingsController.primaryColor,
                  title: const Text(
                    'Notes',
                    style: TextStyle(fontSize: 20),
                  ),
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque. In egestas erat imperdiet sed euismod nisi porta lorem mollis. Morbi tristique senectus et netus. Mattis pellentesque id nibh tortor id aliquet lectus proin. Sapien faucibus et molestie ac feugiat sed lectus vestibulum. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget. Dictum varius duis at consectetur lorem. Nisi vitae suscipit tellus mauris a diam maecenas sed enim. Velit ut tortor pretium viverra suspendisse potenti nullam. Et molestie ac feugiat sed lectus. Non nisi est sit amet facilisis magna. Dignissim diam quis enim lobortis scelerisque fermentum. Odio ut enim blandit volutpat maecenas volutpat. Ornare lectus sit amet est placerat in egestas erat. Nisi vitae suscipit tellus mauris a diam maecenas sed. Placerat duis ultricies lacus sed turpis tincidunt id aliquet. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque. In egestas erat imperdiet sed euismod nisi porta lorem mollis. Morbi tristique senectus et netus. Mattis pellentesque id nibh tortor id aliquet lectus proin. Sapien faucibus et molestie ac feugiat sed lectus vestibulum. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget. Dictum varius duis at consectetur lorem. Nisi vitae suscipit tellus mauris a diam maecenas sed enim. Velit ut tortor pretium viverra suspendisse potenti nullam. Et molestie ac feugiat sed lectus. Non nisi est sit amet facilisis magna. Dignissim diam quis enim lobortis scelerisque fermentum. Odio ut enim blandit volutpat maecenas volutpat. Ornare lectus sit amet est placerat in egestas erat. Nisi vitae suscipit tellus mauris a diam maecenas sed. Placerat duis ultricies lacus sed turpis tincidunt id aliquet.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _tabNotes = expanded);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  leading: const Icon(Icons.check),
                  textColor: settingsController.themeColor,
                  iconColor: settingsController.themeColor,
                  collapsedBackgroundColor: settingsController.primaryColor,
                  backgroundColor: settingsController.primaryColor,
                  title: const Text(
                    'To Dos',
                    style: TextStyle(fontSize: 20),
                  ),
                  children: const <Widget>[
                    Text('sdsfdregrryy ytnt unt juy  iyi nrt u ryu ty utnyt '),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _tabTodos = expanded);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  leading: const Icon(HeroIcons.star),
                  textColor: settingsController.themeColor,
                  iconColor: settingsController.themeColor,
                  collapsedBackgroundColor: settingsController.primaryColor,
                  backgroundColor: settingsController.primaryColor,
                  title: const Text(
                    'Favorites',
                    style: TextStyle(fontSize: 20),
                  ),
                  children: const <Widget>[
                    Text('sdsfdregrryy ytnt unt juy  iyi nrt u ryu ty utnyt '),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _tabFavorites = expanded);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  leading: const Icon(Icons.settings),
                  textColor: settingsController.themeColor,
                  iconColor: settingsController.themeColor,
                  collapsedBackgroundColor: settingsController.primaryColor,
                  backgroundColor: settingsController.primaryColor,
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 20),
                  ),
                  children: const <Widget>[
                    Text('sdsfdregrryy ytnt unt juy  iyi nrt u ryu ty utnyt '),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _tabSettings = expanded);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  leading: const Icon(Icons.info),
                  textColor: settingsController.themeColor,
                  iconColor: settingsController.themeColor,
                  collapsedBackgroundColor: settingsController.primaryColor,
                  backgroundColor: settingsController.primaryColor,
                  title: const Text(
                    'Question',
                    style: TextStyle(fontSize: 20),
                  ),
                  children: const <Widget>[
                    Text('sdsfdregrryy ytnt unt juy  iyi nrt u ryu ty utnyt '),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _tabQuestion = expanded);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
