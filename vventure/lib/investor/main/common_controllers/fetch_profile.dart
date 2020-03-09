import 'package:vventure/investor/main/common_models/profile.dart';

class FetchProfile {
  static Future<Profile> fetchProfile(String id, String token) async {
    Profile profile = new Profile(null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null);

    return profile;
  }
}
