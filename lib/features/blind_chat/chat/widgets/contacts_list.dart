import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_controller.dart';
import 'package:gojek_university_app/features/blind_chat/chat/data/models/chat_contact.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';
import 'package:intl/intl.dart';

class ContactsList extends ConsumerWidget {
  final bool isWeb;
  const ContactsList({Key? key, required this.isWeb}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<UserModel>>(
                stream: ref.watch(chatControllerProvider).chatContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var usersContactData = snapshot.data![index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.blindChatChatScreen,
                                  arguments: {
                                    'userModel': usersContactData,
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(
                                  usersContactData.name,
                                  style: getMediumStyle(
                                      fontSize: 12.spMin,
                                      color: MyColors.titleColor),
                                ),

                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    usersContactData.profileImage,
                                  ),
                                  radius: 25.r,
                                ),
                              ),
                            ),
                          ),
                          Divider(color: MyColors.black.withOpacity(0.4), indent: 85),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
