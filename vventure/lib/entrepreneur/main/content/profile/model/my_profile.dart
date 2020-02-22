import 'package:vventure/entrepreneur/main/common_models/highlight.dart';
import 'package:vventure/entrepreneur/main/common_models/info.dart';
import 'package:vventure/entrepreneur/main/common_models/timeline.dart';
import 'package:vventure/entrepreneur/main/common_models/work_image.dart';

class MyProfile {
  String name;
  String last;
  String organization;
  String image;
  String video;
  String stage;
  String stake;
  String stakeInfo;
  String problem;
  String solution;
  List<Highlight> highlight = new List();
  List<Info> info = new List();
  List<UserTimeline> timeline = new List();
  List<WorkImage> images = new List();

  MyProfile(
      this.name,
      this.last,
      this.organization,
      this.image,
      this.video,
      this.stage,
      this.stake,
      this.stakeInfo,
      this.problem,
      this.solution,
      this.highlight,
      this.info,
      this.images,
      this.timeline);
}
