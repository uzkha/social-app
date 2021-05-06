import 'package:flutter/material.dart';
import 'package:social_app/components/custom_drawer.dart';
import 'package:social_app/models/Post.dart';
import 'package:social_app/screens/comments.dart';
import 'package:social_app/service/placeholder_service.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  final PlaceholderService _placeholderService = PlaceholderService();
  List<Post> _posts = List<Post>();

  @override
  void initState() {
    super.initState();
    _placeholderService.getPosts().then((resp){
      setState(() {
        _posts = resp;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Feed'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Container(
        color: Colors.white12,
        child: FutureBuilder<List<Post>>(
          future: _placeholderService.getPosts(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _posts.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              Comments(snapshot.data[index].id),
                          ));
                    },
                    child:    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${snapshot.data[index].title}',
                                style: TextStyle(fontSize: 25),),
                            ),
                            Text('${snapshot.data[index].body}',
                              style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if(snapshot.hasError){
                return Text('erro');
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
    );
  }
}


