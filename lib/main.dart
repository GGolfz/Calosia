import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calosia',
      theme: ThemeData(
          primaryColor: Color(0xFFFFF9F6),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFFF7F51),
            focusColor: Color(0xFFFF7F51),
            splashColor: Color(0xFFFF7F51),
            hoverColor: Color(0xFFFF7F51),
            elevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
          )),
      home: MainScreen(),
      routes: {
        '/food': (ctx) => DetailScreen(),
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/app_logo.png'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Text("${args['detail']}"),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/app_logo.png'),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          color: Color(0xFFFFF9F6),
          child: Column(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    onEditingComplete: () {
                      Navigator.of(context).pushNamed('/food',
                          arguments: {'detail': _text.text});
                      _text.text = '';
                      FocusScope.of(context).unfocus();
                    },
                    controller: _text,
                    autofocus: false,
                    style: TextStyle(fontSize: 20.0, color: Color(0xFF8B8B8B)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF8B8B8B),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                )),
            Container(
                height: 600,
                child: ListView.separated(
                    itemBuilder: (ctx, index) => ListTile(
                          leading: Container(
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/e/e8/Tom_yam_kung_maenam.jpg',
                              fit: BoxFit.cover,
                            ),
                            width: 50,
                            clipBehavior: Clip.hardEdge,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          ),
                          title: Text("Food $index"),
                          subtitle: Text("300 kcals"),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            print(index);
                            Navigator.of(context).pushNamed('/food',
                                arguments: {'detail': "$index"});
                          },
                        ),
                    separatorBuilder: (ctx, index) => Divider(),
                    itemCount: 10))
          ]),
          height: MediaQuery.of(context).size.height * 0.8,
        ),
        Container(
          color: Color(0xFFFFFFFF),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
