import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isloading = false;
  List users = [];
  Future <void> fatchUsers() async {
    setState(() {
      isloading = true;
    });
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    setState(() {
      isloading = false;
    });
    print(response.body);


    if(response.statusCode==200){
      users = jsonDecode(response.body);
    }else{
    throw Exception("Something wrong");
  }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fatchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User list'),
        backgroundColor: Colors.cyan,
      ),


      body:isloading? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemBuilder: (context,index){
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(user['name'][0],style: TextStyle(
                  color: Colors.white,fontSize: 25,
                ),),
              ),
              title: Text(user['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username:${user['username']}",style: TextStyle(color: Colors.grey),),
                  Text("Email:${user['email']}",style: TextStyle(color: Colors.grey),),
                  Text("Phone:${user['phone']}",style: TextStyle(color: Colors.grey),),
                  Text("Website:${user['website']}",style: TextStyle(color: Colors.grey),),
                  Text("Address:${user['address']['street']},"
                      "${user['address']['city']}",

                    style: TextStyle(color: Colors.grey),),
                ],
              ),
            );
          }),
    );
  }
}
