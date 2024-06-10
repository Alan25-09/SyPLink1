import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syplink/views/common/custom_outline_btn.dart';
import 'package:syplink/views/common/exports.dart';
import 'package:syplink/views/common/height_spacer.dart';
import 'package:syplink/views/common/styled_container.dart';
import 'package:syplink/views/screens/auth/login.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://img.freepik.com/vector-premium/perfil-avatar-hombre-icono-redondo_24640-14044.jpg';

    return Center(
      child: buildStyleContainer(
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(99.w)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: 70.w,
                  height: 70.w,
                ),
              ),
              const HeightSpacer(size: 20),
              ReusableText(
                  text: 'Para acceder al contenido, inicia sesión.',
                  style:
                      appStyle(16, Color(kDarkGris.value), FontWeight.normal)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.w,
                ),
                child: CustomOutlineBtn(
                  width: width,
                  height: 40.h,
                  text: 'Iniciar sesión',
                  color: Color(kVerde.value),
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                ),
              )
            ],
          )),
    );
  }
}
