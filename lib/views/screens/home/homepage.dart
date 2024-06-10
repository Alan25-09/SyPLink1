import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syplink/controllers/login_provider.dart';
import 'package:syplink/views/common/app_bar.dart';
import 'package:syplink/views/common/drawer/drawer_widget.dart';
import 'package:syplink/views/common/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:syplink/views/common/heading_widget.dart';
import 'package:syplink/views/common/search.dart';
import 'package:syplink/views/screens/auth/profile_page.dart';
import 'package:syplink/views/screens/vacants/vacant_list_page.dart';
import 'package:syplink/views/screens/vacants/widgets/RecentList.dart';
import 'package:syplink/views/screens/vacants/widgets/popularVacants.dart';
import 'package:syplink/views/search/search_page.dart';
import 'package:provider/provider.dart';

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
    var loginNotifier = Provider.of<LoginNotifier>(context);
    loginNotifier.getPref();
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
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
                    style: appStyle(30, Color(kDark.value), FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SearchWidget(
                    onTap: () {
                      Get.to(() => const SearchPage());
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  HeadingWidget(
                    text: 'Vacantes populares',
                    onTap: () {
                      Get.to(() => const VacantListPage());
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      child: const PopularVacants()),
                  SizedBox(
                    height: 15.h,
                  ),
                  HeadingWidget(
                    text: 'Publicados recientemente',
                    onTap: () {
                      Get.to(() => const VacantListPage());
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const RecentVacants(),
                ],
              ),
            ),
          ),
        ));
  }
}
