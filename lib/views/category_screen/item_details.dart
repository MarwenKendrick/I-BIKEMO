import 'package:get/get.dart';
import 'package:ibikemo/consts/consts.dart';
import 'package:ibikemo/consts/list.dart';
import 'package:ibikemo/controllers/product_controller.dart';
import 'package:ibikemo/wigets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    // print(Colors.red.value);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //swiper section
                  VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      itemCount: data['p_imgs'].length,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemBuilder: ((context, index) {
                        return Image.network(
                          data["p_imgs"][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      })),
                  10.heightBox,
                  //title & details section
                  title!.text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  "${data['p_price']}"
                      .numCurrency
                      .text
                      .color(blueBg)
                      .fontFamily(bold)
                      .size(18)
                      .make(),

                  10.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.message_rounded,
                          color: darkFontGrey,
                        ),
                      ),
                    ],
                  )
                      .box
                      .height(60)
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .color(textfieldGrey)
                      .make(),

                  //color section
                  20.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color: ".text.color(darkFontGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                data['p_colors'].length,
                                (index) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index])
                                            .withOpacity(1.0))
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .make()
                                        .onTap(() {
                                      controller.changeColorIndex(index);
                                    }),
                                    Visibility(
                                      visible:
                                          index == controller.colorIndex.value,
                                      child: const Icon(Icons.done,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                        //quantity row
                        Obx(
                          () => Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: "
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(data['p_price']));
                                  },
                                  icon: const Icon(Icons.remove)),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                  onPressed: () {
                                    controller.increaseQuantity(
                                        int.parse(data['p_quantity']));
                                    controller.calculateTotalPrice(
                                        int.parse(data['p_price']));
                                  },
                                  icon: const Icon(Icons.add)),
                              10.widthBox,
                              "(${data['p_quantity']} Avilable)"
                                  .text
                                  .color(textfieldGrey)
                                  .make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ),
                        //total row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Total: ".text.color(darkFontGrey).make(),
                            ),
                            "${controller.totalPrice.value}"
                                .numCurrency
                                .text
                                .fontFamily(bold)
                                .size(16)
                                .color(blueBg)
                                .make(),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),
                  ),
                  //description section

                  "Description"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  "${data['p_desc']}".text.color(darkFontGrey).make(),
                  //button section
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      itemDetailButtonsList.length,
                      (index) => ListTile(
                        title: itemDetailButtonsList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                  20.heightBox,
                  //products you may like
                  productsyoumaylike.text
                      .fontFamily(bold)
                      .size(16)
                      .color(darkFontGrey)
                      .make(),
                  10.heightBox,
                  //i copied this widget from home screen featured products
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          6,
                          ((index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  "Laptop 4gb/64gb"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "\$15000"
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
                                  .padding(const EdgeInsets.all(8))
                                  .make())),
                    ),
                  ),
                ],
              ),
            ),
          )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
                color: blueBg,
                onPress: () {
                  if (controller.quantity.value == 0) {
                    VxToast.show(context,
                        msg: "Choose at-least one product to add to cart");
                  } else {
                    controller.addToCart(
                        context: context,
                        color: data['p_colors'][controller.colorIndex.value],
                        img: data['p_img'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value);
                    VxToast.show(context, msg: "Added to cart");
                  }
                },
                textColor: whiteColor,
                title: "Add to Cart"),
          )
        ],
      ),
    );
  }
}
