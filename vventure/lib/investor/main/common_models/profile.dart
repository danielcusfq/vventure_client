import 'package:vventure/investor/main/common_models/highlight.dart';
import 'package:vventure/investor/main/common_models/info.dart';
import 'package:vventure/investor/main/common_models/timeline.dart';
import 'package:vventure/investor/main/common_models/work_image.dart';

//model that represents user profile

class Profile {
  String name;
  String last;
  String organization;
  String image;
  String video;
  String stage;
  String stake;
  String exchange;
  String problem;
  String solution;
  List<Highlight> highlight = new List();
  List<Info> info = new List();
  List<UserTimeline> timeline = new List();
  List<WorkImage> images = new List();
  bool inFavorites;

  Profile(
      this.name,
      this.last,
      this.organization,
      this.image,
      this.video,
      this.stage,
      this.stake,
      this.exchange,
      this.problem,
      this.solution,
      this.highlight,
      this.info,
      this.images,
      this.timeline,
      this.inFavorites);
}
