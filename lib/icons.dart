// lib/icons.dart

// A central place to access all SVG icon assets in the app.
// Import this file using:
//   import 'package:gozic_mobile/icons.dart' as icons;
// Then reference an icon path, e.g. icons.GzIcons.navHome
class GzIcons {
  static const String _base = 'assets/icons/';

  // Bottom-navigation icons
  static const String navHome = '${_base}menu_bar/nav_home.svg';
  static const String navHomeActive = '${_base}menu_bar/nav_home_active.svg';

  static const String navBook = '${_base}menu_bar/nav_book.svg';
  static const String navBookActive = '${_base}menu_bar/nav_book_active.svg';

  static const String navPlus = '${_base}menu_bar/nav_plus.svg';
  static const String navPlusActive = '${_base}menu_bar/nav_plus_active.svg';

  static const String navBell = '${_base}menu_bar/nav_bell.svg';
  static const String navBellActive = '${_base}menu_bar/nav_bell_active.svg';

  static const String navGarden = '${_base}menu_bar/nav_garden.svg';
  static const String navGardenActive =
      '${_base}menu_bar/nav_garden_active.svg';

  // General icons (extend here as needed)
  static const String iconEx = '${_base}Iconex.svg';
  static const String logo = '${_base}logo.svg';

  // Post action icons
  static const String postHeart = '${_base}post_menu/post_heart.svg';
  static const String postHeartLiked = '${_base}post_menu/post_heart_liked.svg';
  static const String postComment = '${_base}post_menu/post_comment.svg';
  static const String postShare = '${_base}post_menu/post_share.svg';
  static const String postBookmark = '${_base}post_menu/post_bookmark.svg';
  static const String postBookmarkSaved =
      '${_base}post_menu/post_bookmark_saved.svg';
}
