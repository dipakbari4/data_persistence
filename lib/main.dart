import 'package:data_persistence/models/page_model.dart';
import 'package:flutter/material.dart';
import 'package:data_persistence/examples/shared_prefs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<PageModel> _items = <PageModel>[];

  initState() {
    _items.add(PageModel(
        title: "Shared Preferences",
        subtitle:
            "Shared Preference demonstration for data persistence using key value pair",
        route: SharedPrefsExample()));

    super.initState();
  }

  Widget _buildTile(PageModel pageModel) {
    return ListTile(
        title: Text(pageModel.title != null
            ? pageModel.title
            : "Please pass data for this item"),
        subtitle: Text(pageModel.subtitle != null
            ? pageModel.subtitle
            : "Please pass data for this item"),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pageModel.route)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Persistence"),
        ),
        body: SafeArea(
          child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _items.length,
              itemBuilder: (context, pos) {
                return _buildTile(_items[pos]);
              }),
        ));
  }
}
