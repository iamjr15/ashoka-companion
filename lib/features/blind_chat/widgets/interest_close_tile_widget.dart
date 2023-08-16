import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/common_outline_border_button.dart';

class InterestCloseTileWidget extends StatelessWidget {
  final Function() onClose;
  final Function() onAdd;
  final String title;
  const InterestCloseTileWidget({
    super.key, required this.onClose, required this.onAdd, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getLightStyle(
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Row(
            children: [
              CommonOutlineBorderButton(
                onTap: onClose,
                buttonText: 'Clear',
                height: 30.h,
                width: 45.w,
                fontSize: 12.sp,
                borderWidth: 1,
              ),
              SizedBox(width: 10.w,),
              CommonOutlineBorderButton(
                onTap: onAdd,
                buttonText: 'Add',
                height: 30.h,
                width: 45.w,
                borderWidth: 1,
                fontSize: 12.sp,
              ),
            ],
          ),

        ],
      ),
    );
  }
}