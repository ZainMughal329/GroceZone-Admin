import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/profile_input_textField.dart';
import 'package:groce_zone_admin/components/round_button.dart';
import 'package:groce_zone_admin/components/snackbar_widget.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
import 'package:groce_zone_admin/models/item_model.dart';
import 'package:groce_zone_admin/pages/inventory/addInventory/controller.dart';

class AddItemView extends GetView<AddItemController> {
  AddItemView({Key? key}) : super(key: key);

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
          _buildCategoryWidget(),
          _buildSubCategoryWidget(),
          Obx(() {
            return Container(
              child: controller.state.loading.value == false
                  ? RoundButton(
                      title: 'Add Product',
                      onPress: () {
                        if (controller.imageUrl != '' &&
                            controller.state.titleController.text != '' &&
                            controller.state.descriptionController.text != '' &&
                            controller.state.stockController.text != '' &&
                            controller.state.priceController.text != '' &&
                            controller.state.discountController.text != '' &&
                            controller.state.priceQtyValue.value != 'Select' &&
                            controller.state.categoryValue.value != 'Select' &&
                            controller.state.subCategoryValue.value !=
                                'Select') {
                          ItemModel item = ItemModel(
                            title: controller.state.titleController.text
                                .trim()
                                .toString(),
                            description: controller.state.titleController.text
                                .trim()
                                .toString(),
                            price: int.parse(controller
                                .state.priceController.text
                                .trim()
                                .toString()),
                            priceQty:
                                controller.state.priceQtyValue.value.toString(),
                            stock: int.parse(controller
                                .state.stockController.text
                                .trim()
                                .toString()),
                            category:
                                controller.state.categoryValue.value.toString(),
                            subCategory: controller.state.subCategoryValue.value
                                .toString(),
                            discount: int.parse(controller
                                .state.discountController.text
                                .trim()
                                .toString()),
                            imageUrl: controller.imageUrl.value,
                          );
                          controller.addItem(item);
                        } else {
                          Snackbar.showSnackBar('Error', 'Enter All Fields');
                        }
                      })
                  : Container(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: Colors.green,
                    ))),
            );
          })
        ],
      ),
    );
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

  Widget _buildCategoryWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: 'Category',
            textColor: Colors.grey,
          ),
          Obx(() {
            return DropdownButton(
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              hint: TextWidget(
                title: controller.state.categoryValue.value,
                fontSize: 14,
              ),
              items: [
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Kitchen',
                    fontSize: 14,
                  ),
                  value: 'Kitchen',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Bathroom',
                    fontSize: 14,
                  ),
                  value: 'Bathroom',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Grocery',
                    fontSize: 14,
                  ),
                  value: 'Grocery',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'HouseHold',
                    fontSize: 14,
                  ),
                  value: 'HouseHold',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Clothing',
                    fontSize: 14,
                  ),
                  value: 'Clothing',
                )
              ],
              onChanged: (value) {
                controller.state.categoryValue.value = value!;
                controller.state.subCategoryValue.value = 'Select';
                // print(DateTime.now().day);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubCategoryWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: 'Sub-Category',
            textColor: Colors.grey,
          ),
          Obx(() {
            return DropdownButton(
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              hint: TextWidget(
                title: controller.state.subCategoryValue.value,
                fontSize: 14,
              ),
              items:
                  controller.subCatList(controller.state.categoryValue.value),
              onChanged: (value) {
                controller.state.subCategoryValue.value = value!;
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
          child: GetBuilder<AddItemController>(
            builder: (con) => Column(
              children: [
                Obx(
                  () => con.imageUrl != ''
                      ? Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Colors.green.withOpacity(0.1),
                          ),
                          child: Image.network(
                            con.imageUrl.value.toString(),
                            width: 200,
                            height: 200,
                          ))
                      : Center(
                          child: Container(
                            child: Icon(
                              Icons.image,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 3,
                ),
                // controller.Image!=null ? InkWell(
                //   onTap: (){
                //     controller.pickImageFromGallery();
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       TextWidget(title: 'EditImage',fontSize: 14,),
                //       Icon(Icons.edit,size: 18,color: Colors.green,)
                //     ],
                //   ),
                // ) :
                InkWell(
                  onTap: () {
                    controller.uploadImageToStorage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        title: 'AddImage',
                        fontSize: 14,
                      ),
                      Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Inventory"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: _buildForm(),
          ),
        )),
      ),
    );
  }
}
