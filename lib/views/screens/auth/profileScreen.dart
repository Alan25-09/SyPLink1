import 'package:flutter/material.dart';
import 'package:jobhubv2_0/views/common/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ReusableText(
        text: "Perfil",
        style: appStyle(30, Color(kDark.value), FontWeight.bold),
      ),
    ));
  }
}
