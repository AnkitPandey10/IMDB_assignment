import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment/ApiCall/post_api_service.dart';
import 'package:flutterassignment/CommonFiles/colorPicker.dart';
import 'package:flutterassignment/Model/moviesListModel.dart';
import 'package:provider/provider.dart';

class MoviesListPage extends StatefulWidget {
  MoviesListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectRolePageState createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<MoviesListPage> {
  TextEditingController searchController = new TextEditingController();
  ProgressDialog pr = new ProgressDialog();
  List<D> moviesListArray = new List<D>();
  List<D> searchListingArray = new List<D>();
  bool _isSearching = false;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3), () {
      this.callApi();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future callApi() async{
    pr.showProgressDialog(
      context,
      dismissAfter: Duration(seconds: 5),
      textToBeDisplayed:'Please Wait',
    );
    final response = await Provider.of<PostApiService>(context).getMoviesList("4fd4f74e3amsh9c2ad135f47d2c3p13f5dcjsnfe97250e74fb","imdb8.p.rapidapi.com","game of thrones");
    print(response.bodyString);
    if(response.statusCode == 200){
      final getMoviesList = getMoviesListFromJson(response.bodyString);
      setState(() {
        moviesListArray = getMoviesList.d;
      });
      pr.dismissProgressDialog(context);
    }
  }

  Future newList(String valueText) async{
    searchListingArray.clear();
    if (valueText.isEmpty) {
      setState(() {
        _isSearching = false;
      });
    }
    else {
      setState(() {
        _isSearching = true;
        for (var i = 0 ; i < moviesListArray.length; i++) {
          if(moviesListArray[i].l != null && moviesListArray[i].l != ''){
            String name = moviesListArray[i].l;
            if (name.toLowerCase().contains(valueText.toLowerCase())) {
              searchListingArray.add(moviesListArray[i]);
            }
          }
        }
      });
    }
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: new Column(
        children: <Widget>[

          SizedBox(height: 40.0,),

          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
            child: TextField(
              onChanged: (value) {
                print(value);
                newList(value);
              },
              controller: searchController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15.0,right: 15.0),
                  hintText: "Search",
                  hintStyle: TextStyle(color: blackBold, fontSize: 20, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3.0)))
              ),
            ),
          ),

          _isSearching == false
          ? new Expanded(
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: moviesListArray.length,
                itemBuilder: (context, index) {
                  D _model  = moviesListArray[index];
                  return Stack(
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.only(top: 40,left: 15.0,right: 15.0),
                        color: whiteBack,
                        child: new ListTile(
                          contentPadding: EdgeInsets.only(right: 10.0, top: 15.0, bottom: 15.0,left: deviceWidth*0.4),
                          title: Container(
                            width: deviceWidth*0.6,
                            child: new Text(
                              _model.l,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold, color: blackBold, fontSize: 20, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 15.0,),
                              new Text(
                                "Genre: "+_model.q,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[400], fontSize: 16, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                              ),
                              SizedBox(height: 10.0,),
                              new Row(
                                children: <Widget>[
                                  new Text(
                                    _model.rank.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 22, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                                  ),
                                  SizedBox(width: 5.0,),
                                  new Icon(Icons.star,color: orangeColor,),
                                  new Icon(Icons.star,color: orangeColor,),
                                  new Icon(Icons.star,color: orangeColor,),
                                  new Icon(Icons.star,color: shadow,),
                                  new Icon(Icons.star,color: shadow,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:deviceHeight*0.03,left: 35.0),
                        child: Material(
                          borderRadius: new BorderRadius.all(Radius.circular(5)),
                          elevation: 15.0,
                          child: Container(
                            height: 130,
                            width: 120,
                            decoration: new BoxDecoration(
                              color: Colors.blueGrey[200],
                              image: new DecorationImage(
                                image: NetworkImage(_model.i.imageUrl),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: new BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
          : new Expanded(
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: searchListingArray.length,
                itemBuilder: (context, index) {
                  D _model  = searchListingArray[index];
                  return Stack(
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.only(top: 40,left: 15.0,right: 15.0),
                        color: whiteBack,
                        child: new ListTile(
                          contentPadding: EdgeInsets.only(right: 10.0, top: 15.0, bottom: 15.0,left: deviceWidth*0.4),
                          title: Container(
                            width: deviceWidth*0.6,
                            child: new Text(
                              _model.l,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold, color: blackBold, fontSize: 20, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 15.0,),
                              new Text(
                                "Genre: "+_model.q,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[400], fontSize: 16, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                              ),
                              SizedBox(height: 10.0,),
                              new Row(
                                children: <Widget>[
                                  new Text(
                                    _model.rank.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 22, fontFamily: "SFProText-Regular", letterSpacing: 0.3),
                                  ),
                                  SizedBox(width: 5.0,),
                                  new Icon(Icons.star,color: orangeColor,),
                                  new Icon(Icons.star,color: orangeColor,),
                                  new Icon(Icons.star,color: orangeColor,),
                                  new Icon(Icons.star,color: shadow,),
                                  new Icon(Icons.star,color: shadow,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:deviceHeight*0.03,left: 35.0),
                        child: Material(
                          borderRadius: new BorderRadius.all(Radius.circular(5)),
                          elevation: 15.0,
                          child: Container(
                            height: 130,
                            width: 120,
                            decoration: new BoxDecoration(
                              color: Colors.blueGrey[200],
                              image: new DecorationImage(
                                image: NetworkImage(_model.i.imageUrl),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: new BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}