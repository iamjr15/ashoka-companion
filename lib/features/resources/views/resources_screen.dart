import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/resources/controller/resources_controller.dart';
import 'package:gojek_university_app/features/resources/widgets/resource_widget.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:intl/intl.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../navigation_menu/controller/navigation_controller.dart';

class ResourcesScreen extends ConsumerStatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends ConsumerState<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 183.h,
            ),
            Text(
              'welcome',
              style: getBoldStyle(fontSize: MyFonts.size28),
            ),
            Text(
              'class of',
              style: getBoldStyle(fontSize: MyFonts.size28),
            ),
            Text(
              '${DateFormat('yyyy').format(DateTime.now())} !',
              style: getBoldStyle(fontSize: MyFonts.size28),
            ),
            SizedBox(
              height: 74.h,
            ),
            SizedBox(
              height: 750.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: ResourcesWidget(
                      imagePath: AppAssets.resourcePinkBox,
                      imageColor: MyColors.newPinkColor,
                      title: 'find my pal',
                      onTap: () {
                        final navCtr = ref.watch(navigationController);
                        navCtr.setIndex(2);
                      },
                      index: 0,
                    ),
                  ),
                  Positioned(
                    top: 110,
                    child: ResourcesWidget(
                      imagePath: AppAssets.resourcePinkBox,
                      imageColor: MyColors.newBlueColor,
                      title: 'my profile',
                      onTap: () {
                        final navCtr = ref.watch(navigationController);
                        navCtr.setIndex(0);
                      },
                      index: 1,
                    ),
                  ),
                  Positioned(
                    top: 220,
                    child: ResourcesWidget(
                      imagePath: AppAssets.resourcePinkBox,
                      imageColor: MyColors.newYellowColor,
                      title: 'ashoka assist',
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.resourceChatBotScreen);
                      },
                      index: 2,
                    ),
                  ),
                  Positioned(
                    top: 330,
                    child: ResourcesWidget(
                      imagePath: AppAssets.resourcePinkBox,
                      imageColor: MyColors.newPinkResourceBoxColor,
                      title: 'campus map',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.campusMapScreen);
                      },
                      index: 3,
                    ),
                  ),
                  Positioned(
                    top: 440,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return ResourcesWidget(
                          imagePath: AppAssets.resourcePinkBox,
                          imageColor: MyColors.newGreenColor,
                          title: 'support contacts',
                          onTap: () {
                            ref.watch(getSupportContactLinkProvider).when(
                                data: (url) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.webViewScreen,
                                      arguments: {
                                        'newUrl': url.url,
                                        'pageTitle': 'support contacts',
                                      });
                                },
                                error: (error, st) {},
                                loading: () {});
                          },
                          index: 4,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
