import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/resources/controller/resources_controller.dart';
import 'package:gojek_university_app/features/resources/widgets/resource_widget.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 183.h,
            ),
            Text(
              'We’ve got you covered with our resources!',
              style: getBoldStyle(fontSize: MyFonts.size28),
            ),
            SizedBox(
              height: 74.h,
            ),
            SizedBox(
              height: 650.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return ResourcesWidget(
                          imagePath: AppAssets.resourcePinkBox,
                          imageColor: MyColors.newPinkColor,
                          title: 'campus packing \nchecklist',
                          onTap: () {
                            ref
                                .watch(getCampusParkingChecklistUrlProvider)
                                .when(
                                    data: (url) {
                                      Navigator.pushNamed(
                                          context, AppRoutes.webViewScreen,
                                          arguments: {
                                            'newUrl': url.url,
                                            'pageTitle':
                                                'campus packing checklist',
                                          });
                                    },
                                    error: (error, st) {},
                                    loading: () {});
                          },
                          index: 0,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 110,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return ResourcesWidget(
                          imagePath: AppAssets.resourcePinkBox,
                          imageColor: MyColors.newBlueColor,
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
                          index: 1,
                        );
                      },
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
