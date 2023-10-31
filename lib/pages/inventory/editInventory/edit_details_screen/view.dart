import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/profile_input_textField.dart';
import 'package:groce_zone_admin/components/round_button.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
import 'package:groce_zone_admin/pages/inventory/editInventory/edit_details_screen/controller.dart';


class EditScreenView extends GetView<EditScreenController> {
  String id;
  EditScreenView({Key? key, required this.id}) : super(key: key);
  final controller = Get.put<EditScreenController>(EditScreenController());

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildItemImageWidget(),
          ProfileInputTextField(
            contr: controller.state.titleController,
            descrip: 'Title',
            obsecure: false,
            icon: Icons.drive_file_rename_outline,
            labelText: 'Title',
            readOnly: false,
          ),
          ProfileInputTextField(
            contr: controller.state.descriptionController,
            descrip: 'Description',
            obsecure: false,
            icon: Icons.insert_drive_file_outlined,
            labelText: 'Description',
            readOnly: false,
          ),
          ProfileInputTextField(
            contr: controller.state.stockController,
            descrip: 'Stock',
            obsecure: false,
            icon: Icons.inventory_rounded,
            labelText: 'Stock',
            readOnly: false,
            keyboardType: TextInputType.number,
          ),
          ProfileInputTextField(
            contr: controller.state.priceController,
            descrip: 'Price',
            obsecure: false,
            icon: Icons.price_check,
            labelText: 'Price',
            readOnly: false,
            keyboardType: TextInputType.number,
          ),
          ProfileInputTextField(
            contr: controller.state.discountController,
            descrip: 'Discount %',
            obsecure: false,
            icon: Icons.percent,
            labelText: 'Discount %',
            readOnly: false,
            keyboardType: TextInputType.number,
          ),
          _buildPriceQtyWidget(),
          Obx(() {
            return controller.state.loading == true
                ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ))
                : _buildUpdateButton();
          })
        ],
      ),
    );
  }

  Widget _buildUpdateButton() {
    return RoundButton(
        title: 'Update',
        onPress: () {
          controller.updateData(id);
        });
  }

  Widget _buildPriceQtyWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: 'Price Quantity',
            textColor: Colors.grey,
          ),
          Obx(() {
            return DropdownButton(
              hint: TextWidget(
                title: controller.state.priceQtyValue.value,
                fontSize: 14,
              ),
              items: [
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Item',
                    fontSize: 14,
                  ),
                  value: 'Item',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Kg',
                    fontSize: 14,
                  ),
                  value: 'Kg',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Dozen',
                    fontSize: 14,
                  ),
                  value: 'Dozen',
                )
              ],
              onChanged: (value) {
                controller.state.priceQtyValue.value = value!;
                // print(DateTime.now().day);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildItemImageWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 1),
          child: GetBuilder<EditScreenController>(
            builder: (EditScreenController) => Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.orange.withOpacity(0.1),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.pickImageFromGallery();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.orange.withOpacity(0.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: controller.Image == null
                              ? Image(
                            image:
                            NetworkImage(controller.state.imageUrl),
                          )
                              : Image.file(
                            File(controller.Image!.path),
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                controller.state.imageUrl != ''
                    ? InkWell(
                  onTap: () {
                    controller.pickImageFromGallery();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        title: 'EditImage',
                        fontSize: 14,
                      ),
                      Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.orange,
                      )
                    ],
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        ),

        // Container(
        //   child: TextButton(
        //     onPressed: () {
        //       controller.pickImageFromGallery();
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         TextWidget(
        //           title: 'Add Image',
        //           fontSize: 14,
        //         ),
        //         Icon(
        //           Icons.add,
        //           color: LightAppColor.btnColor,
        //           size: 18,
        //         )
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchItem(id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Item Detail',style: TextStyle(color: Colors.white,fontSize: 30),),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.state.loaded.value == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildForm();
          }
        }),
      ),
    );
  }
}
