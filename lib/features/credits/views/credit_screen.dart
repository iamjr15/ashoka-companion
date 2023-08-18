import 'package:gojek_university_app/commons/common_functions/url_launch.dart';
import 'package:gojek_university_app/features/credits/widgets/credit_widget.dart';
import 'package:gojek_university_app/features/credits/widgets/thanks_widget.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

/// Credits Screen
class CreditScreen extends StatelessWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160.h,
            ),
            SizedBox(
              height: 37.h,
            ),
            Image.asset(
              AppAssets.smallShapesImages,
              width: 140.w,
              height: 60.h,
            ),
            SizedBox(
              height: 40.h,
            ),

            /// Credits Card Widget
            CreditWidget(
              imagePath: AppAssets.jigyansuImage,
              smallSubTitle: 'Ashoka Tech Consulting Initiative',
              title: 'Jigyansu Rout , UG24, Computer Science',
              subtitle: 'Flutter App Development + Interface Design',
              onTap: () {
                launchURL(Url: "https://www.linkedin.com/in/iamjr15/");
              },
            ),
            CreditWidget(
              smallSubTitle: 'Ashoka Tech Consulting Initiative',
              imagePath: AppAssets.tanishaImage,
              title: 'Tanisha Raghav , UG24, Psychology',
              subtitle: 'Interface Design + App Architecture',
              onTap: () {
                launchURL(
                    Url:
                        "https://www.linkedin.com/in/tanisha-raghav-0b3a3b1b4/");
              },
            ),
            CreditWidget(
              smallSubTitle: 'Ashoka Tech Consulting Initiative',
              imagePath: AppAssets.hazimImage,
              title: 'Hazim Bin Fayaz, UG24, Computer Science',
              subtitle: 'NLP Bot-Dev + GeoSpatial & Informatics',
              onTap: () {
                launchURL(Url: "https://www.linkedin.com/in/hazimbf/");
              },
            ),
            const ThanksWidget(),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
