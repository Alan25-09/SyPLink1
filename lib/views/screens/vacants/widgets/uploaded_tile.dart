import 'package:flutter/material.dart';
import 'package:jobhubv2_0/models/response/vacants/get_vacant.dart';

class UploadedTile extends StatefulWidget {
  const UploadedTile({super.key, required this.vacant});

  final GetVacantRes vacant;

  @override
  State<UploadedTile> createState() => _UploadedTileState();
}

class _UploadedTileState extends State<UploadedTile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
