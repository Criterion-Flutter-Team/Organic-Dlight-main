import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';


class NutritionDetails extends StatefulWidget {
  final String heroTag;

  const NutritionDetails({Key? key, required this.heroTag}) : super(key: key);
  @override
  _NutritionDetailsState createState() => _NutritionDetailsState();
}

class _NutritionDetailsState extends State<NutritionDetails> {

  MyTextTheme textStyleTheme=MyTextTheme();
  App app=App();

  List nutritionList=[
    {
      'title': 'Manganese',
      'amount': '0.46 (gm)',
      'val': '40.9%',
    },
    {
      'title': 'Potassium',
      'amount': '0.29 (gm)',
      'val': '0.56%',
    },
    {
      'title': 'Calcium',
      'amount': '0.23 (gm)',
      'val': '0.36%',
    },
    {
      'title': 'Magnesium',
      'amount': '0.57 (gm)',
      'val': '0.07%',
    },
    {
      'title': 'Fat',
      'amount': '0.88 (gm)',
      'val': '0.0%',
    },
    {
      'title': 'Carbs',
      'amount': '1.46 (gm)',
      'val': '0.0%',
    },
    {
      'title': 'Protien',
      'amount': '3.46 (gm)',
      'val': '0.0%',
    },
  ];




  List valueOfNutrient=[
    {
      'nutrient': 'Antimony',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Barium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Beryllium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Bismuth',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Cerium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Dybrosium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Erbium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Europium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
    {
      'nutrient': 'Gadolinium',
      'amount': '0.06 (gm)',
      'div': '0.06',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body:   CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                pinned: false,
                //  snap: true,
                //  expandedHeight:  kToolbarHeight,
                forceElevated: false,
                floating: true,
                flexibleSpace:  MyWidget().myAppBar(
                    context: context,
                    title: 'Food Nutrition Details'
                ),
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
              SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,15,0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,20,0,20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: AspectRatio(
                                        aspectRatio: 16/15,
                                        child: Hero(
                                          tag: widget.heroTag,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                                border: Border.all(color: Colors.grey.shade200,
                                                    width: 2),
                                                image: DecorationImage(
                                                    image: AssetImage('assets/exampleCake.png'),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5,),
                                          Text('Choclate Cake',
                                            style:textStyleTheme.largeC18B
                                          ),
                                          SizedBox(height: 5,),
                                          Text("The world's tallest Cake cone was over 9 feet tall. It was scooped in Italy. Most of the vanilla used to make ice cream comes from Madagascar & Indonesia. Chocolate syrup is the world's most popular ice cream topping.",
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style:textStyleTheme.smallC14B
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Amount Per Serving',
                                    style:textStyleTheme.smallC14B
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Calories 0.0',
                                    style:textStyleTheme.large18B
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    color: AppColor.lightThemeColor,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text('%Daily Value',
                                            style:textStyleTheme.smallW14B
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Column(
                                    children: List.generate(nutritionList.length, (index) =>
                                        Container(
                                          color: index==(nutritionList.length-3)? AppColor.lightThemeColorShade1:
                                          index==(nutritionList.length-2)? AppColor.lightThemeColorShade2:
                                          index==(nutritionList.length-1)? AppColor.lightThemeColorShade3
                                              :null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(nutritionList[index]['title'].toString(),
                                                      style:textStyleTheme.large15B
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(nutritionList[index]['amount'].toString(),
                                                      style:textStyleTheme.large15B
                                                    )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(nutritionList[index]['val'].toString(),
                                                      textAlign: TextAlign.end,
                                                      style:textStyleTheme.large15B
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text('Daily values are based on 2000 calories',
                                          textAlign: TextAlign.center,
                                          style:textStyleTheme.smallC14B
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    color: AppColor.lightThemeColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text('Nutrient',
                                                style:textStyleTheme.smallW14B
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text('Amount',
                                                style:textStyleTheme.smallW14B
                                                )),
                                          Expanded(
                                              flex: 1,
                                              child: Text('%Div',
                                                style:textStyleTheme.smallW14B
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(valueOfNutrient.length, (index) =>
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(valueOfNutrient[index]['nutrient'].toString(),
                                                    style:textStyleTheme.small14B
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(valueOfNutrient[index]['amount'].toString(),
                                                    style:textStyleTheme.small14B
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(valueOfNutrient[index]['div'].toString(),
                                                    style:textStyleTheme.small14B
                                                  )),
                                            ],
                                          ),
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                              SizedBox(height: 10,),
                              bottomButtons(),
                              SizedBox(height: 10,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ])),
            ],
          ),

          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton:  ,
        ),
      ),
    );
  }

  bottomButtons(){
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: SizedBox()),
          Expanded(
            flex: 3,
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
               minimumSize: Size(0, 0),
              ),
              onPressed: (){
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: AppColor.lightThemeColor,
                        width: 2)
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,8),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 15,
                        child: Image(
                          image: AssetImage('assets/nutrientButton.png'),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text('Nutrient',
                        style:textStyleTheme.smallC12B
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: TextButton(
              style: TextButton.styleFrom(

                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
               minimumSize: Size(0, 0),
              ),
              onPressed: (){
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.lightThemeColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: AppColor.lightThemeColor,
                        width: 2)
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,8),
                  child: Row(
                    children: [
                     SizedBox(
                       height: 15,
                       child: Image(
                         image: AssetImage('assets/pieChart.png'),
                       ),
                     ),
                      SizedBox(width: 5,),
                      Text('Chart',
                        style: textStyleTheme.smallW12B
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: SizedBox()),
        ],
      ),
    );
  }


}
