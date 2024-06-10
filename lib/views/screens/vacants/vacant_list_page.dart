import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/views/common/BackBtn.dart';
import 'package:syplink/views/common/app_bar.dart';
import 'package:syplink/views/screens/vacants/widgets/popular_vacants_list.dart';

class VacantListPage extends StatefulWidget {
  const VacantListPage({super.key});

  @override
  State<VacantListPage> createState() => _VacantListPageState();
}

class _VacantListPageState extends State<VacantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: const CustomAppBar(
            text: "Vacantes",
            child: BackBtn(),
          )),
      body: const PopularVacantsList(),
    );
  }
}
