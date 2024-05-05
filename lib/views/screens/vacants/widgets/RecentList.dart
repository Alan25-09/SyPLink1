import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/vacants_provider.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/views/screens/vacants/widgets/VacantsVerticalTile.dart';
import 'package:provider/provider.dart';

class RecentVacants extends StatelessWidget {
  const RecentVacants({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VacantsNotifier>(
      builder: (context, vacantsNotifier, child) {
        vacantsNotifier.getRecent();
        return SizedBox(
          height: height * 0.27,
          child: FutureBuilder<List<VacantsResponse>>(
              future: vacantsNotifier.recentVacants,
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
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var vacant = vacants[index];
                        return VacantsVerticalTile(vacant: vacant);
                      });
                }
              }),
        );
      },
    );
  }
}
