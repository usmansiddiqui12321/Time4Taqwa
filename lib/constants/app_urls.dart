class AppUrls {
  static const String initialurl = "https://creepy-elk-gown.cyclic.app/";
  static const String userloginurl = "${initialurl}api/users/login";
  static const String adminloginurl = "${initialurl}api/caretaker/login";
  static const String signupurl = "${initialurl}api/users/signup";
  static const String allmasjids = "${initialurl}api/mosques";
  static const String updateNamazTime =
      "${initialurl}api/caretaker/update/"; // ID HERE
  static const String createpost = "${initialurl}api/donation";
  static const String getalldonationurl = "${initialurl}api/donation";
  static const String deletedonationurl =
      "${initialurl}api/donation/"; //donation id
  static const String getdonationurl =
      "${initialurl}api/donation/?email="; //email 
      static String viewdonationurl(username){
return '$initialurl/api/users/$username/donations/view';
      }
      
      
}
