import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsItem {
  String itemTitle = '';
  String itemMessage = '';
  String imgPath = '';

  NewsItem(this.itemTitle, this.itemMessage, this.imgPath);

  NewsItem.dummyNewsItem() {
    itemTitle = 'Unser Team ist super!';
    itemMessage = '''Lorem ipsum dolor sit amet, 
consetetur sadipscing elitr, sed diam nonumy eirmod tempor
 invidunt ut labore et dolore magna aliquyam erat, sed diam 
 voluptua. At vero eos et accusam et''';
    imgPath = 'drawer_header.jpg';
  }

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
      color: Colors.amber[100],
      child: Text(
        itemMessage,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      imgPath,
    );
  }
}
