import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';


/// Handle for Manage Interests Controller Class
final manageInterestsController = ChangeNotifierProvider((ref) => ManageInterestsController());

class ManageInterestsController extends ChangeNotifier {
  /// List of interests for users to select
  List<String> interests = [
    'photography',
    'football',
    'basketball',
    'badminton',
    'computer science',
    'art',
    'music',
    'reading',
    'cooking and baking',
    'outdoor adventures',
    'gym',
    'travel',
    'fashion',
    'volunteering',
    'gaming',
    'movie buff',
    'dance',

    'writing and poetry',
    'performing arts',
    'sustainability',
    'books',
    'entrepreneurship',
    'psychology',
    'astronomy',
    'graphic design',
    'anime',
    'hiking',
    'history',
    'meditation and wellness',
    'political debates',
    'language learning',
    'health',
    'automobiles',
    'fashion design',
    'social justice activism',
    'board game nights',
    'culinary adventures',
    'theatre',
    'design',
  ];


  List<String> _selectedInterests = [];
  List<String> get selectedInterests => _selectedInterests;
  addSelectedInterest(String val){
    String lowerCaseValue = val.toLowerCase();
    if(!_selectedInterests.contains(lowerCaseValue)){
      _selectedInterests.add(lowerCaseValue);
    }else{
      _selectedInterests.removeWhere((element) => element == lowerCaseValue);
    }
    notifyListeners();
  }

  addInitialSelectedInterests(String val){
    String lowerCaseValue = val.toLowerCase();
    if(!_selectedInterests.contains(lowerCaseValue)){
      _selectedInterests.add(lowerCaseValue);
    }
    notifyListeners();
  }

  removeInterestFromList(String val){
    _selectedInterests.removeWhere((element) => element == val.toLowerCase());
    notifyListeners();
  }


  List<String> _writeByHandInterests = [];
  List<String> get writeByHandInterests => _writeByHandInterests;
  addWriteByHandInterest(String val){
    String lowerCaseValue = val.toLowerCase();
    if(!_writeByHandInterests.contains(lowerCaseValue)){
      _writeByHandInterests.add(lowerCaseValue);
    }
    notifyListeners();
  }

  removeWriteByHandInterest(String val){
    _writeByHandInterests.removeWhere((element) => element == val.toLowerCase());
    notifyListeners();
  }


  setInitialInterests(List<String> initialInterests){
    initialInterests.forEach((interest) {
      if(interests.contains(interest)){
        addInitialSelectedInterests(interest);
      }else{
        addWriteByHandInterest(interest);
      }
    });
  }


  List<String> _combinedInterests = [];
  List<String> get combinedInterests => _combinedInterests;
  setCombinedInterests({required List<String> normalInterests,required List<String> writeByHandInterests, }){
    _combinedInterests = normalInterests + writeByHandInterests;
    notifyListeners();
  }


  clearInterests(){
    _selectedInterests.clear();
    _writeByHandInterests.clear();
    notifyListeners();
  }
}
