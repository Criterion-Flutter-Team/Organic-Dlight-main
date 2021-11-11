import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/Drawer/Drawer.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/SearchListPattern.dart';
import 'package:organic_delight/Pages/Dashboard/search/SearchModal.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


  SearchModal modal=SearchModal();
  // final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  onPressDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }

  onPressedFilter(){
    print('ttttttttttttttttttttttt');
    modal.showFilterDialogue(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            pinned: false,
            //  snap: true,
            //  expandedHeight:  kToolbarHeight,
            forceElevated: false,
            floating: true,
            flexibleSpace: Column(
              children: [
                MyWidget().myAppBar(
                    context: context,
                    leadingIcon: CommonButtons().drawerButton(onPressDrawer),
                    action: [
                      CommonButtons().cartButton(context),
                    ]
                ),
                Expanded(child:   searchProducts())
              ],
            ),
            expandedHeight: 100,
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            pinned: true,
            //  snap: true,
            //  expandedHeight:  kToolbarHeight,
            forceElevated: false,
            floating: true,
            elevation: 0,
            flexibleSpace: Visibility(
                visible: false,
                child: LinearProgressIndicator(
                  valueColor:  AlwaysStoppedAnimation<Color>(AppColor.lightThemeColor),
                  backgroundColor: Colors.white,
                )),
            toolbarHeight:  4 ,
          ),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 16/16,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return SearchList().pattern(
                  context,
                  index: index
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: filterButton(),
    );
  }


  filterButton() {
    return  Row(
      children: [
        // Expanded(
        //   flex: 1,
        //   child: FlatButton(
        //     shape: RoundedRectangleBorder(side: BorderSide(
        //         color: AppColor.grey,
        //         width: 1,
        //         style: BorderStyle.solid
        //     ),),
        //     padding: EdgeInsets.all(0),
        //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.filter_list_alt,
        //         size: 20,),
        //         Text('Filter',
        //           style: TextStyle(
        //               fontWeight: FontWeight.bold
        //           ),
        //         ),
        //       ],
        //     ),
        //     onPressed: (){
        //       onPressedFilter();
        //     },
        //   ),
        // ),
        // Expanded(
        //   flex: 1,
        //   child: FlatButton(
        //     shape: RoundedRectangleBorder(side: BorderSide(
        //         color: AppColor.grey,
        //         width: 1,
        //         style: BorderStyle.solid
        //     ),),
        //     padding: EdgeInsets.all(0),
        //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.list_rounded,
        //           size: 20,),
        //         Text('Sort',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold
        //           ),),
        //       ],
        //     ),
        //     onPressed: (){
        //       modal.showSortDialogue(context);
        //     },
        //   ),
        // ),
      ],
    );
  }
  searchProducts(){
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        border: Border(
        //left: BorderSide( color: Colors.transparent),
       top: BorderSide( width: 2,color: AppColor.lightThemeColor),
       // right: BorderSide( color: Colors.lightBlue.shade900),
        bottom: BorderSide(width: 2,color: AppColor.lightThemeColor),
    ),
        ),
      child: SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search,
              color: AppColor.grey,),
            suffixIcon: IconButton(
              icon: Icon(Icons.mic,
                color: AppColor.grey,),
              onPressed: (){
              },
            ),
            contentPadding: EdgeInsets.all(0),
            hintText: 'Search for products',
            focusedBorder: new OutlineInputBorder(
              borderSide:  BorderSide(
                  color: Colors.transparent,
                  width: 2
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  color: Colors.transparent,
                  width: 2
              ),
            ),
          ),
        ),
      ),
    );
  }

}
