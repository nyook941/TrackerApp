import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Poop Properties",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ));
  }
}

class Property extends StatelessWidget {
  const Property({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFBFACB5).withOpacity(.5),
      ),
    );
  }
}
