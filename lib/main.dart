import 'package:flutter/material.dart';
import 'package:profiles/user_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profiles"),
      ),
      body: _listWidget(context),
    );
  }

  _listWidget(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: userProvider.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffe8e8e8),
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.network(snapshot.data[index].thumbnailUrl),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                  ),
                );
              });
        } else {
          return Container(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
