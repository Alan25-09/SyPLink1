import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/views/common/loader.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/vacants/widgets/VacantsHorizontalTile.dart';
import 'package:provider/provider.dart';

class PopularVacant extends StatelessWidget {
  const PopularVacant({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, JobsNotifier, child) {
        JobsNotifier.getVacants();
        return SizedBox(
          height: height * 0.28,
          child: FutureBuilder<List<VacantsResponse>>(
              future: JobsNotifier.vacantsList,
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
                          onTap: () {},
                        );
                      });
                }
              }),
        );
      },
    );
  }
}
