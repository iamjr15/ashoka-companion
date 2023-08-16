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
              imagePath: AppAssets.samuelImage,
              smallSubTitle: 'Computer Science',
              title: 'Jigyansu Rout , UG24, Computer Science',
              subtitle: 'App Development + Design',
              onTap: () {},
            ),
            CreditWidget(
              smallSubTitle: 'Psychology',
              imagePath: AppAssets.sophiaImage,
              title: 'Tanisha Raghav , UG24, Psychology',
              subtitle: 'Design + App Architecture',
              onTap: () {},
            ),
            CreditWidget(
              smallSubTitle: 'Computer Science',
              imagePath: AppAssets.albertoImage,
              title: 'Hazim Bin Fayaz, UG24, Computer Science',
              subtitle: 'Ashoka Assist + Resource Collation',
              onTap: () {},
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
