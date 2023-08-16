import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/commons/common_providers/global_providers.dart';
import 'package:gojek_university_app/core/constants/firebase_constants.dart';
import '../../../../core/type_defs.dart';
import '../../../../models/user_model.dart';

// Provider definition for accessing ResourcesApis instance
final resourcesApisProvider = Provider<ResourcesApis>((ref) {
  final fireStore = ref.watch(firebaseDatabaseProvider);
  return ResourcesApis(firestore: fireStore);
});

// Interface defining the contract for ResourcesApis functions
abstract class IResourcesApis {
  Stream<QuerySnapshot<Map<String, dynamic>>> getSupportContactLink() ;
  Stream<QuerySnapshot<Map<String, dynamic>>> getCampusParkingChecklistUrl() ;
}

class ResourcesApis extends IResourcesApis {
  final FirebaseFirestore _firestore;

  // Constructor to inject dependencies
  ResourcesApis({required FirebaseFirestore firestore})
      : _firestore = firestore;


  Stream<QuerySnapshot<Map<String, dynamic>>> getSupportContactLink() {
    return _firestore.collection(FirebaseConstants.supportContact).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCampusParkingChecklistUrl() {
    return _firestore.collection(FirebaseConstants.campusPackingChecklist).snapshots();
  }
}
