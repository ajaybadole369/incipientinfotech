import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model_view/controller/user_controller.dart';
import '../model_view/services/database_helper.dart';
import '../res/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late UserController controller;

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController userName;
  late TextEditingController phone;
  late TextEditingController website;
  late TextEditingController address;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    userName = TextEditingController();
    phone = TextEditingController();
    website = TextEditingController();
    address = TextEditingController();
    controller = Get.put(UserController());
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    userName.dispose();
    phone.dispose();
    website.dispose();
    address.dispose();
  }

  void clearController() {
    name.clear();
    email.clear();
    userName.clear();
    phone.clear();
    website.clear();
    address.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  controller.userData();
                  setState(() {});
                },
                icon: const Icon(Icons.update)),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder(
              future: controller.getData(),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        var item = data[index];

                        return Card(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildText(item: item['id'].toString()),
                                      buildText(item: item['name'].toString()),
                                      buildText(item: item['email'].toString()),
                                      buildText(
                                          item: item['username'].toString()),
                                      buildText(item: item['phone'].toString()),
                                      buildText(
                                          item: item['website'].toString()),
                                      buildText(
                                          item: item['address'].toString()),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          buildShowEdit(item: item);
                                        },
                                        icon: const Icon(Icons.edit_outlined)),
                                    IconButton(
                                        onPressed: () async {
                                          await DBHelper.dbHelper
                                              .delete(item['id'].toInt());
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.delete_outline)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }

  buildText({String? item}) {
    return Text(item!);
  }

  buildShowEdit({required item}) {
    return Get.defaultDialog(
        title: 'Edit',
        content: SizedBox(
          child: Column(
            children: [
              buildTextField(ctrl: name, hintText: 'name'),
              buildTextField(ctrl: email, hintText: 'email'),
              buildTextField(ctrl: userName, hintText: 'username'),
              buildTextField(ctrl: phone, hintText: 'phone'),
              buildTextField(ctrl: website, hintText: 'website'),
              buildTextField(ctrl: address, hintText: 'address'),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> row = {
                      DBHelper.colId: item['id'],
                      DBHelper.colName: name.text,
                      DBHelper.colPhone: phone.text,
                      DBHelper.colEmail: email.text,
                      DBHelper.colUsername: userName.text,
                      DBHelper.colAdd: address.text,
                      DBHelper.colWebsite: website.text,
                    };
                    await DBHelper.dbHelper.update(row);
                    Get.back();
                    clearController();
                    setState(() {});
                  },
                  child: const Text('Update Dates'))
            ],
          ),
        ));
  }

  buildTextField(
      {required TextEditingController ctrl, required String hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
          controller: ctrl,
          decoration: InputDecoration(
              hintText: hintText,
              label: Text(hintText.toString()),
              hintStyle: TextStyle(color: AppColors.kGrey),
              labelStyle: TextStyle(color: AppColors.kBlack),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColors.kBlack),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: AppColors.kGrey)))),
    );
  }
}
