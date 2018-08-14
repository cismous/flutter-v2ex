import 'package:flutter/material.dart';
import 'package:v2ex/widget/common-snake-bar.dart';
import 'package:v2ex/pages/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Builder(
        builder: (BuildContext context) {
          return new Drawer(
            child: new ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: const Text('cismous'),
                  accountEmail: const Text('热爱互联网!'),
                  margin: EdgeInsets.zero,
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.subject),
                  title: const Text('节点'),
                  onTap: () {
                    Navigator.pop(context);
                    CommonSnakeBar.buildSnakeBar(context, 'TODO');
                  },
                ),
                new ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text('收藏'),
                  onTap: () {
                    Navigator.pop(context);
                    CommonSnakeBar.buildSnakeBar(context, 'TODO');
                  },
                ),
                new ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('设置'),
                  onTap: () {
                    Navigator.pop(context);
                    CommonSnakeBar.buildSnakeBar(context, 'TODO');
                  },
                ),
                new ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('反馈'),
                  onTap: () {
                    Navigator.pop(context);
                    CommonSnakeBar.buildSnakeBar(context, 'TODO');
                  },
                ),
              ],
            ),
          );
        },
      ),
      appBar: AppBar(
        title: new Padding(
          child: new Text('V2EX', style: TextStyle(fontSize: 18.0)),
          padding: const EdgeInsets.only(),
        ),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            const Tab(text: '热门'),
            const Tab(text: '最新'),
          ],
        ),
      ),
      body: new TabBarView(controller: _controller, children: <Widget>[
        new HotPageView(),
        new LatestPageView(),
      ]),
    );
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'V2EX',
      theme: ThemeData(
        primaryColor: Color(0xFF303030),
      ),
      home: new HomePage(),
    );
  }
}
