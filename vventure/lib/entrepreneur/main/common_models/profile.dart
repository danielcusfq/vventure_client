import 'package:vventure/entrepreneur/main/common_models/highlight.dart';
import 'package:vventure/entrepreneur/main/common_models/info.dart';
import 'package:vventure/entrepreneur/main/common_models/timeline.dart';
import 'package:vventure/entrepreneur/main/common_models/work_image.dart';

class Profile {
  String name;
  String last;
  String organization;
  String image;
  String video;
  String interest;
  String background;
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
      this.interest,
      this.background,
      this.highlight,
      this.info,
      this.images,
      this.timeline,
      this.inFavorites);
}
