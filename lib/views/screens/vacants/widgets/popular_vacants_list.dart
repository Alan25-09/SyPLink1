import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/vacants_provider.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:provider/provider.dart';

class PopularVacantsList extends StatefulWidget {
  const PopularVacantsList({super.key});

  @override
  State<PopularVacantsList> createState() => _PopularVacantsListState();
}

class _PopularVacantsListState extends State<PopularVacantsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VacantsNotifier>(
        builder: (context, vacantsNotifier, child) {
      vacantsNotifier.getVacants();
      return FutureBuilder<List<VacantsResponse>>(
          future: vacantsNotifier.vacantsList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const PageLoader();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.data!.isEmpty) {
              return const Text("Vacantes no encontradas");
            } else {
              final vacants = snapshot.data;

              return ListView.builder(
                  itemCount: vacants!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var vacant = vacants[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        height: 90,
                        color: Colors.amber,
                      ),
                    );
                  });
            }
          });
    });
  }
}
