import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsItem {
  final String itemTitle;
  final String itemMessage;
  final String imgPath;

  NewsItem(
      BuildContext context, this.itemTitle, this.itemMessage, this.imgPath);

  Widget createNewItem(BuildContext context) {
    return Column(
      children: [
        _buildTitle(context),
        _buildMessage(context),
        _buildImage(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
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

  Widget _buildMessage(BuildContext context) {
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

  Widget _buildImage(BuildContext context) {
    return Image.asset(
      imgPath,
    );
  }
}
