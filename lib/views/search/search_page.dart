import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/models/response/vacants/vacants_response.dart';
import 'package:syplink/services/helpers/vacants_helper.dart';
import 'package:syplink/views/common/loader.dart';
import 'package:syplink/views/screens/vacants/widgets/VacantsVerticalTile.dart';
import 'package:syplink/views/search/widget/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          child: CustomField(
            controller: controller,
            onTap: () {
              setState(() {});
            },
          ),
        ),
      ),
      body: controller.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
              child: FutureBuilder<List<VacantsResponse>>(
                  future: VacantsHelper.searchVacants(controller.text),
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
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var vacant = vacants[index];
                          return VacantsVerticalTile(
                            vacant: vacant,
                          );
                        },
                      );
                    }
                  }))
          : const NoSearchResults(text: 'Comienza a buscar...'),
    );
  }
}
