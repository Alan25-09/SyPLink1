import 'package:flutter/material.dart';
import 'package:jobhubv2_0/models/request/agents/agents.dart';
import 'package:jobhubv2_0/models/response/agent/getAgent.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/services/helpers/agents_helper.dart';

class AgentNotifier extends ChangeNotifier {
  late List<Agents> allAgents;
  late Future<List<VacantsResponse>> agentVacants;
  late Map<String, dynamic> chat;
  Agents? agent;

  Future<List<Agents>> getAgents() {
    var agents = AgentsHelper.getAgents();
    return agents;
  }

  Future<GetAgent> getAgentInfo(String uid) {
    var getAgent = AgentsHelper.getAgentInfo(uid);
    return getAgent;
  }

  Future<List<VacantsResponse>> getAgentVacants(String uid) {
    agentVacants = AgentsHelper.getAgentVacants(uid);
    return agentVacants;
  }
}
