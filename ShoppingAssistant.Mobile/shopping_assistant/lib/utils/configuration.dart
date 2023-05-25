import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = const Color(0xff416d6d);
List<BoxShadow> shadowList = [
  const BoxShadow(color: Color.fromRGBO(183, 181, 181, 1), blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Electronics', 'iconPath': 'assets/images/categories/electronics.png'},
  {'name': 'Fashion', 'iconPath': 'assets/images/categories/fashion.png'},
  {'name': 'Groceries', 'iconPath': 'assets/images/categories/food.png'},
  {'name': 'Beauty', 'iconPath': 'assets/images/categories/beauty.png'},
  {'name': 'Sports', 'iconPath': 'assets/images/categories/sports.png'}
];

List<Map> drawerItems=[
  {
    'icon': FontAwesomeIcons.paw,
    'title' : 'Adoption'
  },
  {
    'icon': Icons.mail,
    'title' : 'Donation'
  },
  {
    'icon': FontAwesomeIcons.plus,
    'title' : 'Add pet'
  },
  {
    'icon': Icons.favorite,
    'title' : 'Favorites'
  },
  {
    'icon': Icons.mail,
    'title' : 'Messages'
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title' : 'Profile'
  },
];