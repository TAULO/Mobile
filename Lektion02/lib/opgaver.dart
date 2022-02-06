// opgave 1-2
double calculateArea(double width, double heigth, bool isTrinangle) {
  if (isTrinangle) return width * heigth / 2;
  return width * heigth;
}

// hello
String reverse(String old) {
  String temp = "";
  for (int i = old.length; i >= 0; i--) {
    temp += old.substring(i - 1, i);
  }
  return temp;
}

// opgave 3
bool isPaladrome(String candidate) {
  return reverse(candidate) == candidate;
}
