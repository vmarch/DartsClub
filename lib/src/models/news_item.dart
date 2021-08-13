import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsItem {
  String itemTitle = '';
  String itemMessage = '';
  String imgPath = '';
 late DocumentReference reference;

 NewsItem(this.itemTitle, this.itemMessage, this.imgPath, this.reference);

  factory NewsItem.fromSnapshot(DocumentSnapshot data) {
    return NewsItem(
        data['itemTitle'], data['itemMessage'], data['imgPath'], data.reference);
  }

  Widget createNewItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(),
          _buildMessage(),
          _buildImage(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.blueGrey[600],
      child: Text(
        itemTitle,
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
      color: Colors.blue[200],
      child: Text(
        itemMessage,
        style: TextStyle(
          fontSize: 12.0,
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
