import 'dart:convert';
import 'package:dev_dictionary/src/models/contriibutor_model.dart';
import 'package:dev_dictionary/src/services/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ContributorController extends GetxController {
  Future<List<Contributor>> getContributors() async {
    final contributionUrl = dotenv.env['CONTRIBUTOR_URL'];
    var response = await NetworkService.get(contributionUrl!);
    var data = json.decode(response.body);
    var contributors = <Contributor>[];
    for (var item in data) {
      contributors.add(Contributor.fromJson(item));
    }
    return contributors;
  }
}
