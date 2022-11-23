import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Center(
                child: Image.asset("logo.png"),
              ),
              Row(
                children: [
                  Column(
                    children: const [
                      Text("40"),
                      Text("Total Task"),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("20"),
                      Text("Complete"),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("20"),
                      Text("Ongoing"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
