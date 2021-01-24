import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrefsExample();
  }
}

class PrefsExample extends StatefulWidget {
  @override
  _PrefsExampleState createState() => _PrefsExampleState();
}

class _PrefsExampleState extends State<PrefsExample> {
  TextEditingController _nameController;
  String _data; // String data to pass on Text Widget

  @override
  void initState() {
    _nameController = TextEditingController();
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void getData() async {
    // Getting the instance of Shared Preference
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    setState(() {
      // Getting data from shared preference
      _data =
          _preferences.getString("name") ?? "Required key doesn't has value";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter you name here",
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: getData,
                    child: Text("Show Data"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      print("clear");
                      _nameController.clear();
                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      _preferences.clear();
                      setState(() {
                        _data = null;
                      });
                    },
                    child: Text("Clear"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var _nameCtrlTxt = _nameController.text;
                      if (_nameCtrlTxt != null && _nameCtrlTxt.isNotEmpty) {
                        // Getting the instance of Shared Preference
                        SharedPreferences _preferences =
                            await SharedPreferences.getInstance();

                        // Saving key/value pair data
                        await _preferences.setString("name", _nameCtrlTxt);

                        setState(() {
                          _data = _nameCtrlTxt;
                        });
                        print("Name saved");
                      } else {
                        setState(() {
                          _data = "Please enter some data";
                        });
                      }
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                _data == null
                    ? "No data"
                    : (_data.isEmpty ? "Data is emtpy" : _data),
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
