import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './datail.dart';
Dio dio = new Dio();

class MovieList extends StatefulWidget {
MovieList({Key key,@required this.mt}) : super(key:key);

final String mt;
  @override
  _MovieListState createState(){
    return new _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {

  int page = 1;
  int pagesize = 10;

  var mlist =[];
  var total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       itemCount: mlist.length,
       itemBuilder: (BuildContext ctx,int i){
         var mitem = mlist[i];
         return GestureDetector(
           onTap: (){
             Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext ctx){
              return  MovieDetail(
                id:mitem['id'],
                title: mitem['title'],
                );
              }));
           },
           child:Row(children: <Widget>[
           Image.network(mitem['images']['small'],width: 130,height: 180,fit: BoxFit.cover,),
           Container(
             padding: EdgeInsets.only(left:10),
             height:200,
             child:Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children:<Widget>[
             
               Text('电影名称 ${mitem['title']}'),
               Text('上映年份 ${mitem['year']}'),
               Text('电影类型 ${mitem['genres'].join('')}'),
               Text('电影评分 ${mitem['rating']['average']}'),
               Text('主要研远 ${mitem['title']}'),
           ],)
           ),
         ],),
         );
       },

    );
  }

  getMovieList() async {

    int offset = (page-1)* pagesize ;

    var response = await dio.get('http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pagesize');
    
    var result= response.data;

    // print(result);
    
    setState(() {
      mlist = result['subjects'];
      total = result['total'];
    });
  }
}

