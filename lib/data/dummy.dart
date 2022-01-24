/*generate dummy data*/
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/model/BannerModel.dart';
import 'package:solar_kita/model/OnboardingModel.dart';
import 'package:solar_kita/res/my_colors.dart';


class Dummy {

  static Random random = new Random();
  static const List<String> wizard_title = [
    "Welcome to SolarKita App", "Monitoring System", "KoinKita Program", "SolarKita Media"
  ];
  static const List<String> wizard_brief = [
    "Nikmati berbagai layanan dan fitur dari SolarKita untuk PLTS Atap Anda.",
    "Pantau kinerja PLTS Atap Anda dimanapun dan kapanpun secara mudah dan langsung.",
    "Nikmati berbagai promo menarik dari program KoinKita.",
    "Dapatkan berbagai informasi terbaru seputar dunia ramah lingkungan.",
  ];
  static const List<String> wizard_image = [
    "assets/intro1.png",
    "assets/intro2.png",
    "assets/intro3.png",
    "assets/intro4.png",
  ];
  static const List<String> wizard_background = [
    "image_15.jpg", "image_10.jpg", "image_3.jpg", "image_12.jpg"
  ];
  static const List<Color> wizard_color = [
    MyColors.primary,
    Colors.blueGrey,
    Colors.purple,
    Colors.orange,
  ];


  static List<OnboardingModel> getWizard() {
    List<OnboardingModel> items = [];
    for (int i = 0; i < wizard_title.length; i++) {
      OnboardingModel obj = new OnboardingModel();
      obj.image = wizard_image[i];
      obj.background = wizard_background[i];
      obj.title = wizard_title[i];
      obj.brief = wizard_brief[i];
      obj.color = wizard_color[i];
      items.add(obj);
    }
    return items;
  }

  static List<BannerModel> getBanners() {
    List<BannerModel> items = [];
    for (int i = 0; i < wizard_title.length; i++) {
      BannerModel obj = new BannerModel();
      obj.image = wizard_image[i];
      obj.background = wizard_background[i];
      obj.title = wizard_title[i];
      obj.brief = wizard_brief[i];
      obj.color = wizard_color[i];
      items.add(obj);
    }
    return items;
  }
}
