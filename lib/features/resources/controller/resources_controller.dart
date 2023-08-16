import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/schedule/data/apis/schedule_apis.dart';
import 'package:gojek_university_app/features/schedule/data/models/schedule_model.dart';

import '../data/api/resources_apis.dart';
import '../data/models/resources_common_model.dart';

final scheduleStateController = StateNotifierProvider<ResourcesStateController, bool>((ref) {
  final resourcesApis = ref.watch(resourcesApisProvider);
  return ResourcesStateController(resourcesApis: resourcesApis);
});

final getCampusParkingChecklistUrlProvider = StreamProvider((ref) {
  final scheduleCtr = ref.watch(scheduleStateController.notifier);
  return scheduleCtr.getCampusParkingChecklistUrl();
});

final getSupportContactLinkProvider = StreamProvider((ref) {
  final scheduleCtr = ref.watch(scheduleStateController.notifier);
  return scheduleCtr.getSupportContactLink();
});


class ResourcesStateController extends StateNotifier<bool> {
  ResourcesApis _resourcesApis;

  ResourcesStateController({required ResourcesApis resourcesApis})
      : _resourcesApis = resourcesApis,
        super(false);
  

  Stream<ResourcesCommonModel> getSupportContactLink(){
    return _resourcesApis.getSupportContactLink().map((items){
      List<ResourcesCommonModel> modelList = [];
      items.docs.forEach((item) {
        ResourcesCommonModel model = ResourcesCommonModel.fromMap(item.data() as Map<String, dynamic>);
        modelList.add(model);
      });

      return modelList.first;
    });
  }

  Stream<ResourcesCommonModel> getCampusParkingChecklistUrl(){
    return _resourcesApis.getCampusParkingChecklistUrl().map((items){
      List<ResourcesCommonModel> modelList = [];
      items.docs.forEach((item) {
        ResourcesCommonModel model = ResourcesCommonModel.fromMap(item.data() as Map<String, dynamic>);
        modelList.add(model);
      });

      return modelList.first;
    });
  }
}