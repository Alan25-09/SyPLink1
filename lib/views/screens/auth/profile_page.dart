import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/response/auth/profile_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/screens/auth/non_user.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:jobhubv2_0/views/screens/auth/widgets/skills.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:jobhubv2_0/views/screens/vacants/add_vacant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileRes?> userProfile;
  String username = '';

  @override
  void initState() {
    super.initState();
    userProfile = getProfile();
    getName();
  }

  Future<ProfileRes?> getProfile() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    if (loginNotifier.loggedIn) {
      return AuthHelper.getProfile();
    } else {
      return null;
    }
  }

  Future<void> getName() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (loginNotifier.loggedIn) {
      setState(() {
        username = prefs.getString('username') ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Perfil',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: widget.drawer == false
                ? const BackBtn()
                : DrawerWidget(
                    color: Color(kDark.value),
                  ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: userProfile,
        builder: (context, AsyncSnapshot<ProfileRes?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PageLoader();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.data == null) {
            return const NonUser();
          } else {
            var profile = snapshot.data!;
            return buildStyleContainer(
              context,
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Color(kVerde.value),
                      borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircularPicture(
                              image: profile.profile,
                              w: 50,
                              h: 50,
                            ),
                            const WidthSpacer(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: profile.username,
                                    style: appStyle(16, Color(kLight.value),
                                        FontWeight.w400)),
                                ReusableText(
                                    text: profile.email,
                                    style: appStyle(14, Color(kLight.value),
                                        FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Feather.edit,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HeightSpacer(size: 20),
                  const SkillWidget(),
                  const HeightSpacer(size: 20),
                  profile.isAgent
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: 'Panel de prestatario',
                                style: appStyle(
                                    15, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 20),
                            CustomOutlineBtn(
                              width: MediaQuery.of(context).size.width,
                              height: 40.h,
                              text: 'Publicar vacante',
                              color: Color(kVerde.value),
                              onTap: () {
                                Get.to(() => const AddVacant());
                              },
                            ),
                            const HeightSpacer(size: 20),
                            CustomOutlineBtn(
                              width: MediaQuery.of(context).size.width,
                              height: 40.h,
                              text: 'Actualizar información',
                              color: Color(kVerde.value),
                              onTap: () {},
                            ),
                          ],
                        )
                      : CustomOutlineBtn(
                          width: MediaQuery.of(context).size.width,
                          height: 40.h,
                          text: 'Aplicar para ser prestatario',
                          color: Color(kVerde.value),
                          onTap: () {},
                        ),
                  const HeightSpacer(size: 20),
                  CustomOutlineBtn(
                    width: MediaQuery.of(context).size.width,
                    height: 40.h,
                    text: 'Cerrar sesión',
                    color: Color(kVerde.value),
                    onTap: () {
                      zoomNotifier.currentIndex = 0;
                      loginNotifier.logout();
                      setState(() {
                        userProfile = getProfile();
                      });
                      Get.to(() => const Mainscreen());
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class CircularPicture extends StatelessWidget {
  const CircularPicture(
      {super.key, required this.image, required this.w, required this.h});
  final String image;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(99.w)),
      child: CachedNetworkImage(
        imageUrl: image,
        width: w,
        height: h,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
