import 'package:gojek_university_app/features/blind_chat/widgets/single_create_interest_widget.dart';
import 'package:gojek_university_app/features/blind_chat/widgets/single_interest_widget.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/common_outline_border_button.dart';
import '../../../utils/constants/assets_manager.dart';

Future<List<String>> createInterestAddon(BuildContext context) async {
  List<String> interests = [];
  interests = await showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    useRootNavigator: true,
    isScrollControlled: true,
    isDismissible: false,
    barrierColor: Colors.black45.withOpacity(0.8),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        )),
    builder: (context) {
      return const SellerCreateAddOnPage();
    },
  );


  return interests;
  //Navigator.pop(context);
}

class SellerCreateAddOnPage extends StatefulWidget {
  const SellerCreateAddOnPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SellerCreateAddOnPage> createState() => _SellerCreateAddOnPageState();
}

class _SellerCreateAddOnPageState extends State<SellerCreateAddOnPage> {
  final TextEditingController _titleCtr = TextEditingController();
  GlobalKey<FormState> addOnKey = GlobalKey<FormState>();
  List<String> interests = [

  ];


  @override
  void dispose() {
    _titleCtr.dispose();
    super.dispose();
  }

  add() {
    if (!(_titleCtr.text.isEmpty)) {
      final newInterests = _titleCtr.text.trim();
      interests.add(newInterests);
      _titleCtr.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.52,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Create Interest Tile',
                                style: getSemiBoldStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size16)),
                            IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.all(4.h),
                              icon: ImageIcon(
                                const AssetImage(AppAssets.closeIconImage),
                                size: 18.h,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.pop(context,interests);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //Category dropdown
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text('interests',
                                  style: getMediumStyle(
                                      color: MyColors.textColor,
                                      fontSize: MyFonts.size14)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Wrap(
                            children: List.generate( interests.length, (index) => InterestWidget(
                              interestName: interests[index],
                            )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CreateSingleTitlePriceWidget(
                            titleCtr: _titleCtr,
                            formKey: addOnKey,
                            onPress: add,
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 90.w,
                  child: CommonOutlineBorderButton(
                  onTap: () {
                    Navigator.pop(context, interests);
                    },
                  buttonText: 'Submit',
                  height: 30.h,
                  width: 90.w,
                  fontSize: 12.sp,
                  borderWidth: 1,
                  ),
              ),
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
