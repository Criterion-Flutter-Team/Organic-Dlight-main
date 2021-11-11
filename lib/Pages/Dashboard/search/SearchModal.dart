import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';


class SearchModal {

  var filterList=[
    {
      'title': 'Brand',
      'child': [
        {
          'title': 'Organic Delight',
          'isSelected': false,
        },
        {
          'title': 'Cherry Farm',
          'isSelected': false,
        },
      ],
    },
    {
      'title': 'Discount',
      'child': [
        {
          'title': '15% - 25%',
          'isSelected': false,
        },
        {
          'title': 'More than 25%',
          'isSelected': false,
        },
      ],
    },
    {
      'title': 'Pack Size',
      'child': [
        {
          'title': '1kg',
          'isSelected': false,
        },
        {
          'title': '2kg',
          'isSelected': false,
        },
      ],
    },
    {
      'title': 'Price',
      'child': [
        {
          'title': '100-200',
          'isSelected': false,
        },
        {
          'title': 'More than 500',
          'isSelected': false,
        },
      ],
    },
  ];



  var selectedSort=1;
  var sortList=[
    {
      'title': 'Recommended',
      'val': 1,
    },
    {
      'title': 'New',
      'val': 2,
    },
    {
      'title': 'Price: Low to High',
      'val': 3,
    },
    {
      'title': 'Price: High to Low',
      'val': 4,
    },
  ];




  showFilterDialogue(context){
    return showGeneralDialog(
             barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (context, a1, a2, widget) {
                return StatefulBuilder(
                    builder: (context,setState)
                    {
                      return Transform.scale(
                        scale: a1.value,
                        child: Opacity(
                          opacity: a1.value,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Container(
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(40,0,40,0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.lightThemeColor,
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text('Filter',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),),
                                                      ),
                                                      IconButton(
                                                          splashRadius: 5,
                                                          icon: Icon(Icons.clear,
                                                            color: Colors.white,
                                                            size: 20,),
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          })
                                                    ],
                                                  ),
                                                )),
                                            Column(
                                              children: List.generate(filterList.length, (index) {
                                                List childList=filterList[index]['child'] as List;
                                                return   ListTileTheme(
                                                  dense: true,
                                                  child: ExpansionTile(
                                                    backgroundColor:  Colors.grey.shade200,
                                                    title: Row(
                                                      children: [
                                                        Container(
                                                          child: Expanded(
                                                            child: Text(
                                                              filterList[index]['title'].toString(),
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: List.generate(childList.length, (index2) =>
                                                            GestureDetector(
                                                              onTap: (){
                                                                childList[index2]['isSelected']=!childList[index2]['isSelected'];
                                                                setState((){

                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(20,5,20,5),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(childList[index2]['title'].toString(),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 12
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    SizedBox(
                                                                      height: 20,
                                                                      width: 20,
                                                                      child: Checkbox(
                                                                          splashRadius: 5,
                                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                                                                          value: childList[index2]['isSelected'],
                                                                          activeColor: AppColor.lightThemeColor,
                                                                          onChanged: (val){
                                                                            childList[index2]['isSelected']=!childList[index2]['isSelected'];
                                                                            setState((){
                                                                            });
                                                                          }),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }

                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 200),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {
               return Container();
              });
  }



  showSortDialogue(context){
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),

        transitionBuilder: (context, a1, a2, widget){
          return StatefulBuilder(
              builder: (context,setState)
              {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40,0,40,0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.lightThemeColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('Sort',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),),
                                                ),
                                                IconButton(
                                                    splashRadius: 5,
                                                    icon: Icon(Icons.clear,
                                                      color: Colors.white,
                                                      size: 20,),
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                        child: Column(
                                          children: List.generate(sortList.length, (index) {
                                            return    GestureDetector(
                                              onTap: (){
                                                selectedSort=sortList[index]['val'] as int;
                                                setState((){

                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(20,5,20,5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(sortList[index]['title'].toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12
                                                        ),),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: Radio(
                                                          splashRadius: 5,
                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                          groupValue: selectedSort,
                                                          value: sortList[index]['val'] as int,
                                                          activeColor: AppColor.lightThemeColor,
                                                          onChanged: (val){
                                                            selectedSort=sortList[index]['val'] as int;
                                                            setState((){

                                                            });
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }

                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }




}