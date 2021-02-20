import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickmessage/controllers/settingController.dart';
import 'package:get/get.dart';
import 'package:quickmessage/widgets/myLoading.dart';
import 'package:quickmessage/widgets/myTextField.dart';

class Setting extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Me"),
      ),
      body: GetBuilder<SettingController>(
        init: SettingController(Get.arguments),
        builder: (_) => _.currentUser == null
            ? Container()
            : Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: _.image == null
                                    ? Image.network(
                                        _.currentUser.urlPicture,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        _.image,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  // print("selectImage");
                                  _.selectImage();
                                },
                                child: Container(
                                  width: 120,
                                  margin: EdgeInsets.only(top: 20),
                                  height: 30,
                                  color: Colors.black38,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Colors.white70,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsets.only(right: 32),
                            height: 90,
                            width: 260,
                            // color: Colors.red,
                            child: TextField(
                              controller: nameController,
                              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                              // cursorColor: Colors.,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: _.currentUser.name,
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                                isDense: true,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          settingItem(
                              content: "Dark Mode",
                              icon: Icons.brightness_2_sharp,
                              color: Colors.white30,
                              switchVal: true),
                          settingItem(content: "Switch Account", icon: Icons.switch_account, color: Colors.purple),
                          settingItem(content: "Message Requests", icon: Icons.message, color: Colors.blue),
                          settingItem(
                              content: "Log out", icon: Icons.logout, color: Colors.green, onPressed: () => _.logOut()),
                          myFlatButton(
                              onPressed: () {
                                _.updateData(nameController.text);
                              },
                              content: "Update"),
                        ],
                      ),
                    ),
                  ),
                  if (_.isUpDating == true) MyLoading(),
                ],
              ),
      ),
    );
  }

  Widget settingItem({String content, @required IconData icon, @required Color color, bool switchVal, onPressed}) {
    return FlatButton(
      padding: EdgeInsets.only(left: 16, right: 8, top: 9, bottom: 9),
      onPressed: onPressed,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null)
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(Icons.circle, color: color, size: 40),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          Padding(padding: EdgeInsets.only(left: 14)),
          Expanded(
            child: Text(
              content,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          if (switchVal != null)
            Switch(
              value: true,
              activeColor: Colors.white,
              // activeColor: Colors.blue,
              inactiveThumbColor: Colors.yellow,
              onChanged: (val) {},
            )
        ],
      ),
    );
  }
}
