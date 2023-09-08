// String returnIdFromEmail(String email) {
//   // Extract the part before "@gmail.com"
//   String prefix = email.substring(0, email.indexOf("@gmail.com"));
//
//   //split the prefix based on underscore to get required id format
//   List<String> parts =prefix.split('.');
//   String idPart=parts.last;
//   return idPart;
// }

String returnIdFromEmail(String email) {
  int atSymbolIndex = email.indexOf('@');
  int startIndex = atSymbolIndex - 4;
  if (startIndex < 0) {
    startIndex = 0;
  }
  return email.substring(startIndex, atSymbolIndex);
}