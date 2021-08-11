import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecordNews {
  String newsTitle ;
  String newsText ;
  String imgPath ;
  late DocumentReference reference;

  RecordNews(this.newsTitle, this.newsText, this.imgPath, this.reference);

  factory RecordNews.fromSnapshot(DocumentSnapshot data) {
    return RecordNews(
        data['newsTitle'], data['newsText'], data['imgPath'], data.reference);
  }

//   RecordNews.dummyNewsItem() {
//     newsTitle = 'Unser Team ist super!';
//     newsText = '''Lorem ipsum dolor sit amet, 
// consetetur sadipscing elitr, sed diam nonumy eirmod tempor
//  invidunt ut labore et dolore magna aliquyam erat, sed diam 
//  voluptua. At vero eos et accusam et''';
//     imgPath = 'drawer_header.jpg';
//   }


  Widget createNewItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(),
        _buildMessage(),
        _buildImage(),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.amber[600],
      child: Text(
        newsTitle,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.amber[100],
      child: Text(
        newsText,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      'assets/$imgPath',
      
   
    );
  }

}
