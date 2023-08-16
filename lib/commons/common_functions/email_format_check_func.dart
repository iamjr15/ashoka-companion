bool isValidEmailFormat(String email) {
  // Check if the email ends with "@gmail.com"
  if (!email.endsWith("@gmail.com") || '.'.allMatches(email).length<2 ) {
    return false;
  }
  // Extract the part before "@gmail.com"
  String prefix = email.substring(0, email.indexOf("@gmail.com"));

  //split the prefix based on underscore to get required id format then we will check regex on it
  List<String> parts =prefix.split('.');
  String idPart=parts.last;

  // Check if the idPart matches the specified format
  RegExp regExp = RegExp(r'^[a-zA-Z]{1,4}\d{2}$');
  return regExp.hasMatch(idPart);
}