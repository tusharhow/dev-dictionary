import 'dart:convert';
import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/models/contriibutor_model.dart';
import 'package:dev_dictionary/src/services/network_service.dart';
import 'package:get/get.dart';

class ContributorController extends GetxController {
  Future<List<Contributor>> getContributors() async {
    var response = await NetworkService.get(CONTRIBUTOR_URL);
    var data = json.decode(response.body);
    var contributors = <Contributor>[];
    for (var item in data) {
      contributors.add(Contributor.fromJson(item));
    }
    return contributors;
  }
}
