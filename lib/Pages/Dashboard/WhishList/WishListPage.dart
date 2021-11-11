

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/Drawer/Drawer.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/WhishListPattern.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WhishListModal.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WishListController.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {

  MyTextTheme textStyleTheme=MyTextTheme();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  WishListModal modal = WishListModal();

  WishListController controller=Get.put(WishListController());

  LocalStorage storage = LocalStorage();
  LocalStorage storedData = Get.put(LocalStorage());
  CartModal modalCart = CartModal();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    print('Hello from wishList');
    get();
  }

  get() async {
    await getMyWishList();
  }

  onPressDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  late Map data;

  getMyWishList() async {
    data = await modal.getWishLists(context);
    print(data);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: GetBuilder<WishListController>(
        init: WishListController(),

        builder: (_) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                pinned: false,
                //  snap: true,
                //  expandedHeight:  kToolbarHeight,
                forceElevated: false,
                floating: true,
                flexibleSpace: MyWidget().myAppBar(
                    context: context,
                    leadingIcon: CommonButtons().drawerButton(onPressDrawer),
                    action: [
                      CommonButtons().cartButton(context),
                    ]),
              ),
              controller.getWishList.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My WishList',
                              style:textStyleTheme.smallC14B

                            ),

                            SizedBox(
                              height: 10,
                            ),
                            WishList()
                                .pattern(setState,context: context, listOfData: controller.getWishList),
                            // FlatButton(
                            //     onPressed: () {
                            //       print(myWishList[0]['productName']);
                            //     },
                            //     child: Container())

                          ],
                        ),
                      ),
                    ]
                      ))

                  : SliverList(
                      delegate: SliverChildListDelegate([
                      Container(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 200.0, horizontal: 5.0),
                            child: Text('Wishlist is Empty',
                            style:textStyleTheme.smallL
                            )),
                      ),
                    ])),
            ],
          );
        }
      ),
    );
  }
}
