import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/manage_profile/controllers/manage_interests_controller.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_arrow_button.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants/font_manager.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/controller/auth_notifier_controller.dart';
import '../widgets/add_interest_field_widget.dart';
import '../widgets/interest_tile.dart';
import '../widgets/profile_appbar.dart';
import '../widgets/removeable_interest_tile.dart';

class ManageInterestsScreen extends ConsumerStatefulWidget {
  const ManageInterestsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ManageInterestsScreen> createState() => _ManageInterestsScreenState();
}

class _ManageInterestsScreenState extends ConsumerState<ManageInterestsScreen> {
  final _interestCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  initialization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authNotifierProvider = ref.read(authNotifierCtr);
      final manageInterestsCtr  = ref.read(manageInterestsController);
      UserModel userModel = authNotifierProvider.userModel!;

      manageInterestsCtr.setInitialInterests(userModel.interests);
    });
  }


  @override
  void dispose() {
    super.dispose();
    _interestCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final manageInterestsCtr  = ref.watch(manageInterestsController);
        manageInterestsCtr.clearInterests();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),
              ProfileAppBar(
                subtitle: 'MY INTERESTS',
                onBackTap: (){
                  final manageInterestsCtr  = ref.watch(manageInterestsController);
                  manageInterestsCtr.clearInterests();
                  Navigator.pop(context);
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 37.w
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: 323.w
                      ),
                      child: Text(
                        'Select your interests & connect with similar people!',
                        style: getBoldStyle(
                            fontSize: MyFonts.size28,
                            color: MyColors.textColor
                        ),
                      ),
                    ),
                    SizedBox(height: 26.h,),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final manageInterCtr = ref.watch(manageInterestsController);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AddInterestsWidget(
                              controller: _interestCtr,
                              hintText: 'type it out',
                              onChanged: (val){},
                              onFieldSubmitted: (val){
                                manageInterCtr.addWriteByHandInterest(val);
                                _interestCtr.clear();
                              },
                              onArrowTapped: (){
                                if(_interestCtr.text.isNotEmpty){
                                  manageInterCtr.addWriteByHandInterest(_interestCtr.text);
                                  _interestCtr.clear();
                                }
                              },
                              obscure: false,
                              label: 'label',
                            ),
                            SizedBox(height: 26.h,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: List.generate(
                                  manageInterCtr.interests.length,
                                      (index){
                                    String interest = manageInterCtr.interests[index];
                                    return InterestTile(
                                      onTap: (){
                                        manageInterCtr.addSelectedInterest(interest);
                                      },
                                      interestName: interest,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: List.generate(
                                  manageInterCtr.writeByHandInterests.length,
                                      (index){
                                    String interest = manageInterCtr.writeByHandInterests[index];
                                    return RemoveableInterestTile(
                                      onTap: (){
                                        manageInterCtr.removeWriteByHandInterest(interest);
                                      },
                                      interestName: interest,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                return CustomArrowButton(
                                  isLoading: ref.watch(authControllerProvider),
                                  buttonText: 'save interests',
                                  onPressed: ()async {
                                    await onSaveInterests(ref, context);
                                  },
                                  buttonHeight: 70.h,
                                  backColor: MyColors.newPinkColor,
                                );
                              },
                            ),
                          ],
                        );
                      },

                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSaveInterests(WidgetRef ref, BuildContext context)async{
    final manageInterestsCtr  = ref.watch(manageInterestsController);
    final authNotifierProvider = ref.watch(authNotifierCtr);
    /// Combining all interests either written by Hand or just Selected!
    manageInterestsCtr.setCombinedInterests(
        normalInterests: manageInterestsCtr.selectedInterests,
        writeByHandInterests: manageInterestsCtr.writeByHandInterests,
    );

    if(manageInterestsCtr.combinedInterests.isNotEmpty && (manageInterestsCtr.combinedInterests.length >= 3)){
      UserModel userModel = authNotifierProvider.userModel!;
      final authCtr = ref.watch(authControllerProvider.notifier);
      await authCtr.updateCurrentUserInfo(
          context: context,
          interests: manageInterestsCtr.combinedInterests,
          instagramHandle: userModel.instagramHandle,
          userModel: userModel);

      ref.watch(fetchUserByIdProvider(authNotifierProvider.userModel!.uid)).when(
        data: (userModel){
          authNotifierProvider.setUserModelData(userModel);
        },
        error: (error, st){
          debugPrintStack(stackTrace: st);
          debugPrint(error.toString());
        },
        loading: (){},
      );

    }else{
      showToast(msg: 'please select at-least 3 interests!');
    }
  }
}
