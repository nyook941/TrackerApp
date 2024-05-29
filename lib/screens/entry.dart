import 'package:flutter/material.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF444554),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            const Text(
              "Save",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle))
          ]),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "I must know about your poop",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 16,
              ),
              Properties()
            ],
          ),
        ),
      ),
    );
  }
}

class Properties extends StatefulWidget {
  const Properties({super.key});

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF62606B),
        ),
        width: double.maxFinite,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Poop Properties",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      Property(
                        title: "bloody",
                        selected: false,
                      ),
                      Property(
                        title: "diharrea",
                        selected: false,
                      ),
                      Property(
                        title: "hard",
                        selected: false,
                      ),
                      Property(
                        title: "painful",
                        selected: false,
                      ),
                    ])
                  ])),
        ));
  }
}

class Property extends StatelessWidget {
  final String title;
  final bool selected;

  const Property({required this.title, required this.selected, super.key});

  static const Map<String, IconData> iconMap = {
    'bloody': Icons.water_drop,
    'diharrea': Icons.warning,
    'hard': Icons.hardware,
    'painful': Icons.personal_injury_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: selected
              ? const Color(0xFFBFACB5)
              : const Color(0xFFBFACB5).withOpacity(.5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: Row(
            children: [
              Icon(iconMap[title] ?? Icons.help,
                  size: 18,
                  color:
                      selected ? Colors.white : Colors.white.withOpacity(0.5)),
              const SizedBox(
                width: 2,
              ),
              Text(title,
                  style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)))
            ],
          ),
        ),
      ),
    );
  }
}
