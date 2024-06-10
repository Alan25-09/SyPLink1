import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/controllers/agents_provider.dart';
import 'package:syplink/models/response/vacants/vacants_response.dart';
import 'package:syplink/views/common/pages_loader.dart';
import 'package:syplink/views/screens/vacants/widgets/uploaded_tile.dart';
import 'package:provider/provider.dart';

class AgentVacants extends StatefulWidget {
  const AgentVacants({super.key});

  @override
  State<AgentVacants> createState() => _AgentVacantsState();
}

class _AgentVacantsState extends State<AgentVacants> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AgentNotifier>(
      builder: (context, agentNotifier, child) {
        agentNotifier.getAgentVacants(agentNotifier.agent!.uid);
        return FutureBuilder<List<VacantsResponse>>(
            future: agentNotifier.agentVacants,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const PageLoader();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var vacants = snapshot.data;
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
                  child: ListView.builder(
                    itemCount: vacants!.length,
                    itemBuilder: (context, index) {
                      var vacant = vacants[index];
                      return UploadedTile(vacant: vacant, text: 'agent');
                    },
                  ),
                );
              }
            });
      },
    );
  }
}
