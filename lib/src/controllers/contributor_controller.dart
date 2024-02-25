import 'dart:convert';
import 'package:dev_dictionary/src/config/config.dart';
import 'package:dev_dictionary/src/models/contriibutor_model.dart';
import 'package:dev_dictionary/src/services/network_service.dart';
import 'package:flutter/material.dart';
 

class ContributorController extends ChangeNotifier {
  Future<List<Contributor>> getContributors() async {
    
    var response = await NetworkService.get(Config.CONTRIBUTOR_URL);
    var data = json.decode(response.body);
    var contributors = <Contributor>[];
    for (var item in data) {
      contributors.add(Contributor.fromJson(item));
    }
    return contributors;
  }
}
