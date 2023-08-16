import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:photo_view/photo_view.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../widgets/inner_screens_appbar.dart';

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InnerScreensAppBar(
            title: 'campus map',
            onBackTap: () {
              Navigator.pop(context);
            },
            verticalPadding:60.h,
          ),
          SizedBox(height: 60.h,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200.h,
            child: PhotoView(
              basePosition: Alignment.center,
              initialScale: 0.2,
              imageProvider: const AssetImage(AppAssets.campusMapImage,),
            ),
          ),
        ],
      ),
    );
  }
}
