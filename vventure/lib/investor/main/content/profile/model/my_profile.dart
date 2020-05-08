import 'package:vventure/investor/main/common_models/highlight.dart';
import 'package:vventure/investor/main/common_models/info.dart';
import 'package:vventure/investor/main/common_models/timeline.dart';
import 'package:vventure/investor/main/common_models/work_image.dart';

//model that represents user profile

class MyProfile {
  String name;
  String last;
  String organization;
  String image;
  String video;
  String interests;
  String background;
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
      this.interests,
      this.background,
      this.highlight,
      this.info,
      this.images,
      this.timeline);
}
