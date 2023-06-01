import 'dart:io';
import 'package:get/get.dart';
import 'package:ibikemo/consts/consts.dart';
import 'package:ibikemo/controllers/profile_controller.dart';
import 'package:ibikemo/wigets_common/bg_widget.dart';
import 'package:ibikemo/wigets_common/custom_textfield.dart';
import 'package:ibikemo/wigets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Obx(
              () => (Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                      ? Image.asset(imgProfile2,
                              width: 90, height: 90, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : data['imageUrl'] != '' &&
                              controller.profileImgPath.isEmpty
                          ? Image.network(
                              data['imageUrl'],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.file(
                              File(controller.profileImgPath.value),
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.heightBox,
                  ourButton(
                      color: blueBg,
                      onPress: () {
                        controller.changeImage(context);
                      },
                      textColor: whiteColor,
                      title: "Change"),
                  const Divider(),
                  20.heightBox,
                  customTextField(
                      controller: controller.nameController,
                      hint: hintName,
                      title: name,
                      isPass: false),
                  10.heightBox,
                  customTextField(
                      controller: controller.oldpassController,
                      hint: passwordHint,
                      title: oldpass,
                      isPass: true),
                  10.heightBox,
                  customTextField(
                      controller: controller.newpassController,
                      hint: passwordHint,
                      title: newpass,
                      isPass: true),
                  20.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(blueBg),
                        )
                      : SizedBox(
                          width: context.screenWidth - 60,
                          child: ourButton(
                              color: blueBg,
                              onPress: () async {
                                controller.isloading(true);

                                // if image is not selected
                                if (controller
                                    .profileImgPath.value.isNotEmpty) {
                                  await controller.uploadProfileImage();
                                } else {
                                  controller.profileImageLink = data['imgUrl'];
                                }
                                //if old password match on database
                                if (data['password'] ==
                                    controller.oldpassController.text) {
                                  await controller.changeAuthPassword(
                                      email: data['email'],
                                      password:
                                          controller.oldpassController.text,
                                      newpassword:
                                          controller.newpassController.text);

                                  await controller.updateProfile(
                                      imgUrl: controller.profileImageLink,
                                      name: controller.nameController.text,
                                      password:
                                          controller.newpassController.text);
                                  VxToast.show(context, msg: "Updated");
                                } else {
                                  VxToast.show(context,
                                      msg: "Icorrect Password");
                                  controller.isloading(false);
                                }
                              },
                              textColor: whiteColor,
                              title: "Save")),
                ],
              )
                  .box
                  .white
                  .shadowSm
                  .padding(const EdgeInsets.all(16))
                  .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                  .rounded
                  .make()),
            )));
  }
}
