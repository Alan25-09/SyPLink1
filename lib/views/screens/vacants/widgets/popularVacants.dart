import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/controllers/vacants_provider.dart';
import 'package:syplink/models/response/vacants/vacants_response.dart';
import 'package:syplink/views/screens/vacants/vacant_details_page.dart';
import 'package:syplink/views/screens/vacants/widgets/VacantsHorizontalTile.dart';
import 'package:provider/provider.dart';

class PopularVacants extends StatelessWidget {
  const PopularVacants({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VacantsNotifier>(
      builder: (context, vacantsNotifier, child) {
        vacantsNotifier.getVacants();
        return SizedBox(
          height: height * 0.25,
          child: FutureBuilder<List<VacantsResponse>>(
              future: vacantsNotifier.vacantsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return const Text("Vacantes no encontradas");
                } else {
                  final vacants = snapshot.data;

                  return ListView.builder(
                      itemCount: vacants!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var vacant = vacants[index];
                        return VacantHorizontalTile(
                          vacant: vacant,
                          onTap: () {
                            Get.to(() => VacantDetails(
                                  id: vacant.id,
                                  title: vacant.title,
                                  responsibleName: vacant.responsibleName,
                                ));
                          },
                        );
                      });
                }
              }),
        );
      },
    );
  }
}
