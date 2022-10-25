#include <iostream>
#include <ctime>

using namespace std;

int main() {
  time_t now = time(0);

  // save time in string form
  char *dt = ctime(&now);

  cout << "Local date and time : " << dt << endl;

  // convert to UTC tm struct
  tm *gmtm = gmtime(&now);
  dt = asctime(gmtm);
  cout << "The UTC date and time is: " << dt << endl;

  // Format time
  cout << "seconds since January 1, 1970 is: " << now << endl;

  tm *ltm = localtime(&now);

  cout << "Year: " << 1900 + ltm->tm_year << endl;
  cout << "Month: " << 1 + ltm->tm_mon << endl;
  cout << "Day: " << ltm->tm_mday << endl;
  /* cout << "Time: " << 5+ltm->tm_hour << ":"; */
  /* cout << 30+ltm->tm_min << ":"; */
  cout << "Time: " << ltm->tm_hour << ":";
  cout << ltm->tm_min << ":";
  cout << ltm->tm_sec << endl;
  return 0;
}
