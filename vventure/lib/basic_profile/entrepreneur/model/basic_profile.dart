import 'dart:io';
import 'package:vventure/auth/info.dart';

class BasicProfileEntrepreneur {
  UserInfo userInfo;
  File profilePicture;
  String stage;
  String percentage;
  String exchange;
  String problem;
  String solution;

  BasicProfileEntrepreneur(this.userInfo, this.profilePicture, this.stage,
      this.percentage, this.exchange, this.problem, this.solution);
}
