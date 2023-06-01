import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ibikemo/consts/consts.dart';
import 'package:ibikemo/controllers/product_controller.dart';
import 'package:ibikemo/services/firestore_services.dart';
import 'package:ibikemo/views/category_screen/item_details.dart';
import 'package:ibikemo/wigets_common/bg_widget.dart';

import '../../wigets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No Products Found".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              controller.subcat.length,
                              (index) => "${controller.subcat[index]}"
                                  .text
                                  .color(darkFontGrey)
                                  .size(12)
                                  .fontFamily(semibold)
                                  .makeCentered()
                                  .box
                                  .rounded
                                  .white
                                  .size(120, 50)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make())),
                    ),

                    //Items Container
                    20.heightBox,
                    Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
                                    .numCurrency
                                    .text
                                    .fontFamily(bold)
                                    .color(blueBg)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .white
                                .roundedSM
                                .outerShadowSm
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                  title: "${data[index]['p_name']}",
                                  data: data[index]));
                            });
                          }),
                    )
                  ],
                ),
              );
            }
          }),
    ));
  }
}
