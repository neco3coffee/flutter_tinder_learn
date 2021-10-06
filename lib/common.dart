// devtool
import 'dart:developer' as dev;

devlog(String description) {
  dev.log("${description}\n${StackTrace.current.toString().split("#")[2]}");
}
