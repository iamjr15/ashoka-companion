import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_controller.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/my_colors.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';



class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  final String recieverName;
  const BottomChatField({
    required this.recieverName,
    required this.receiverUserId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

// State class for the BottomChatField widget
class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }


  // Function to send a text message
  void sendTextMessage() async {
    if (_messageController.text == '') {
      return;
    }
    UserModel userModel = ref.read(authNotifierCtr).userModel!;
    ref.read(chatControllerProvider).sendTextMessage(context,
        _messageController.text.trim(), widget.receiverUserId, userModel);
    setState(() {
      _messageController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
      child: TextFormField(
        focusNode: focusNode,
        controller: _messageController,
        onChanged: (val) {},
        style: getRegularStyle(
            fontSize: MyFonts.size13,
            color: MyColors.white,
            isMontserrat: true),
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.chatTextFieldColor,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: sendTextMessage,
                  icon: Image.asset(
                    AppAssets.sendIcon,
                    width: 20.w,
                    height: 20.w,
                  )),
              SizedBox(
                width: 10.h,
              ),
            ],
          ),
          hintStyle: getRegularStyle(
              fontSize: MyFonts.size13,
              color: MyColors.white.withOpacity(0.7),
              isMontserrat: true),
          hintText: 'type your message',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r)),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 22.h, horizontal: 20.w),
        ),
      ),
    );
  }
}
