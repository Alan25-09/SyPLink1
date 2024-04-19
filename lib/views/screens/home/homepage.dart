import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/common/heading_widget.dart';
import 'package:jobhubv2_0/views/common/search.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:jobhubv2_0/views/screens/vacants/widgets/popularVacants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/* Clase donde se construye la página principal de la app */
class _HomePageState extends State<HomePage> {
  String imagenUrl =
      "https://img.freepik.com/vector-premium/perfil-avatar-hombre-icono-redondo_24640-14044.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const ProfileScreen(drawer: false));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          height: 25.w,
                          width: 25.w,
                          imageUrl: imagenUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
                child: Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: DrawerWidget(color: Color(kDark.value)),
                ))),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Busca,\nencuentra y aplica",
                    style: appStyle(38, Color(kDark.value), FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SearchWidget(
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const HeadingWidget(text: 'Vacantes populares'),
                  SizedBox(
                    height: 15.h,
                  ),
                  const PopularVacant(),
                  SizedBox(
                    height: 15.h,
                  ),
                  const HeadingWidget(text: 'Publicados recientemente'),
                ],
              ),
            ),
          ),
        ));
  }
}
