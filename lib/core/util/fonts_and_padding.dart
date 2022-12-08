import 'package:flutter/cupertino.dart';

//Return screen pixel size so that we can set responsive
// fontsize/padding/margin etc
double pixelSize(BuildContext context) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);
  double textScaleFactor = 1;
  double myPixel;   //unit of scale for this device (is different for each
  // device since everything scales)- Name of Variable can be changed
  double screenWidth = _mediaQueryData.size.width;
  double screenHeight = _mediaQueryData.size.height;

  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    //portrait mode of device
    myPixel = screenWidth / 411;
    // width of Pixel 2 is 411 according to
    // chrome inspect mode. since all of you are optimizing design for the
    // Pixel 2 we use this as default screen width.
  } else {    //landscape mode of device
      myPixel = screenHeight / 411; //using height since: landscape height = portrait width
  }
  if(textScaleFactor != 0){    //sanity check since some devised midght not have this value in their Operating system
    myPixel = myPixel * textScaleFactor;   //using textScaleFactor so that andorid settinge effect scale all over the app
  }

  return myPixel;
}


double pad(BuildContext context) {
  double myPixel = pixelSize(context);
  return 10.0 * myPixel;
}


//Sized Box Height
double sbHeight(BuildContext context) {
  double myPixel = pixelSize(context);
  return 10.0 * myPixel;
}

// text sizes. Have to be checkt if they look good
double fontH1(BuildContext context) {
  double myPixel = pixelSize(context);
  return 30.0 * myPixel;
}

double fontH2(BuildContext context) {
  double myPixel = pixelSize(context);
  return 24.0 * myPixel;
}

double fontH3(BuildContext context) {
  double myPixel = pixelSize(context);
  return 18.0 * myPixel;
}

double fontH4(BuildContext context) {
  double myPixel = pixelSize(context);
  return 16.0 * myPixel;
}

double fontH5(BuildContext context) {
  double myPixel = pixelSize(context);
  return 14.0 * myPixel;
}

double fontH6(BuildContext context) {
  double myPixel = pixelSize(context);
  return 12.0 * myPixel;
}

double fontH7(BuildContext context) {
  double myPixel = pixelSize(context);
  return 10.0 * myPixel;
}