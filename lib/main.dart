import 'package:flutter/material.dart';
import './movie/list.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './SearchBarDemo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '男神专用',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  List<String> imgs=[
    'http://www.liulongbin.top:3005/images/bg1.jpg',
    'http://www.liulongbin.top:3005/images/bg1.jpg',
    'http://www.liulongbin.top:3005/images/bg1.jpg',
    'http://www.liulongbin.top:3005/images/bg1.jpg'
     ];
void choosePic(source) async {
  // 得到选取的照片
  var image = await ImagePicker.pickImage(source: source);
  // 如果选取的照片为空，则不执行后续人脸检测的业务逻辑
  if (image == null) {
    return;
  }
}
 Widget buildTextField(context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon:Icon(Icons.search),
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
//            borderSide: BorderSide(color: Colors.red, width: 3.0, style: BorderStyle.solid)//没什么卵效果
          )),
            onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) ){
              return  SearchBarDemo();
              });
              //  showSearch(context: context, delegate: searchBarDelegate());
          },
    );
  }

  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                new Icon(icon, color: Colors.blue),
                new Text(text),
            ],
        )
    );
}

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return DefaultTabController( 
      length: 3,
      child: Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
                icon: Container(
                  padding: EdgeInsets.all(3.0),
                  child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                       'https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316'),
                  ),
                ),
              onPressed: () { 
                 Scaffold.of(context).openDrawer();
                //_scaffoldKey.currentState.openDrawer();
               },
            );
          }
          ),
        title: Container(
          padding: EdgeInsets.all(0),
          height:30,
          width: 120,
          child:buildTextField(context)
        ),
        // centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
            ),
            new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                this.SelectView(Icons.message, '发起群聊', 'A'),
                this.SelectView(Icons.group_add, '添加服务', 'B'),
                this.SelectView(Icons.cast_connected, '扫一扫码', 'C'),
            ],
            onSelected: (String action) {
                // 点击选项的时候
                switch (action) {
                    case 'A': break;
                    case 'B': break;
                    case 'C': break;
                }
            },)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('1027690173@qq.com'),
              accountName: Text('张三'), 
              currentAccountPicture: CircleAvatar(
                backgroundImage:NetworkImage(
                'https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316'),//头像
              ),
              decoration:BoxDecoration(
                image: DecorationImage(
                  fit:BoxFit.cover,
                  image:NetworkImage(
                'http://www.liulongbin.top:3005/images/bg1.jpg' ))),
              ),//背景图片
              ListTile(title:Text('用户反馈'),trailing: Icon(Icons.feedback),),
              ListTile(title:Text('系统设置'),trailing: Icon(Icons.settings),),
              ListTile(title:Text('我要发布'),trailing: Icon(Icons.send),),
              ListTile(title:Text('注销'),trailing: Icon(Icons.exit_to_app),)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:Colors.black
        ),
        height: 55,
        child: TabBar(
          labelStyle: TextStyle(height:0,fontSize: 10),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.movie_filter),
              text: '热映',
              ),
            Tab(
            icon: Icon(Icons.movie_creation),
            text: '即将上映',
            ),
            Tab(
            icon: Icon(Icons.local_movies),
            text: '前排',
            ),
          ]
        ),
        ),
        body:SlidingUpPanel(
        panel: Center(
          child: Text("这里是抽屉区"),
        ),
        body:ListView(
    children:<Widget>[
      Container(
      height:250,
      child:new Swiper(
          itemBuilder: (BuildContext context,int index){
          return new Image.network(imgs[index],fit: BoxFit.cover,);
          },
      itemCount: imgs.length,
      pagination: new SwiperPagination(),//如果不填则不显示指示点
      control: new SwiperControl(),//如果不填则不显示左右按钮
      loop: true,
      autoplay: true,
      ),
      ),
        Slidable(
            actionPane: SlidableScrollActionPane(),//滑出选项的面板 动画
            actionExtentRatio: 0.25,
            child: ListTile(
              leading: new Icon(Icons.cake),
              title: new Text('标题'),
              subtitle: Text('data'),
              trailing: new Icon(Icons.save),
              ),
            actions: <Widget>[//左侧按钮列表
                IconSlideAction(
                    caption: 'Archive',
                    color: Colors.blue,
                    icon: Icons.archive,
                    onTap:() {},
                ),
                IconSlideAction(
                    caption: 'Share',
                    color: Colors.indigo,
                    icon: Icons.share,
                    onTap:() {},
                ),
            ],
            secondaryActions: <Widget>[//右侧按钮列表
                IconSlideAction(
                    caption: '更多',
                    color: Colors.black45,
                    icon: Icons.more_horiz,
                    onTap:() {},
                ),
                IconSlideAction(
                    caption: '删除',
                    color: Colors.red,
                    icon: Icons.delete,
                    closeOnTap: false,
                    // onTap: (){_showSnackBar('Delete');},
                    onTap:() {},
                ),
            ],
          ),
        new CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: 0.8,
                header: new Text("Icon header"),
                center: new Icon(
                  Icons.person_pin,
                  size: 50.0,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
      ],
     ),
        
      ),
      floatingActionButton: ButtonBar(
          // alignment 属性用来指定子元素如何在横轴上进行排列
          // MainAxisAlignment.spaceAround 表示分散对齐,浮动按钮默认是靠右侧堆叠
          alignment: MainAxisAlignment.spaceAround,
          // 子元素
          children: <Widget>[
                // 第一个浮动按钮
                FloatingActionButton(
                  onPressed: () {
                    choosePic(ImageSource.camera);
                  },
                  tooltip: 'takephoto',
                  child: Icon(Icons.photo_camera),
                ),
                // 第二个浮动按钮
                FloatingActionButton(
                  onPressed: () {
                    choosePic(ImageSource.gallery);
                  },
                  tooltip: 'takepicture',
                  child: Icon(Icons.photo_library),
                )
           ],
        ),
        // body: TabBarView(
        //   children: <Widget>[
        //     MovieList(mt:'in_theaters'),
        //     MovieList(mt:'coming_soon'),
        //     MovieList(mt:'top250'),
        //   ]
        //   ),
       
    )
     
    );
  }
}      

const searchList = [
  "jiejie-大长腿",
  "jiejie-水蛇腰",
  "gege1-帅气欧巴",
  "gege2-小鲜肉"
];

const recentSuggest = [
  "推荐-1",
  "推荐-2"
];
class searchBarDelegate extends SearchDelegate<String>{
  //初始化加载
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: ()=>query="",
      )
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: ()=>close(context, null),
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index) => ListTile(
        title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              children:[
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ]
            )
        ),
      ),
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

