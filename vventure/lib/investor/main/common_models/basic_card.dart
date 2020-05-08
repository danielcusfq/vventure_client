//model that contains basic card user information

class BasicCardInfo {
  String id;
  String organization;
  String stage;
  String image;
  String inspection;

  BasicCardInfo(this.id, this.organization, this.stage, this.image);

  BasicCardInfo.inspection(
      this.id, this.organization, this.stage, this.image, this.inspection);
}
