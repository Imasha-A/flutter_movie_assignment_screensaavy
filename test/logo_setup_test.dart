import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  //testing if my logo setup returns a image widget with the correct image property, fit, height and width
  testWidgets('Logo setup returns correct image widget',
      (WidgetTester tester) async {
    //Arrange
    const String imageName = 'your_image_name.png';
    final expectedImage = Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: 250,
      height: 250,
    );

    //Act
    final result = logoSetup(imageName);

    //Assert
    expect(result, isA<Image>());
    final resultImage = result as Image;
    expect(resultImage.image, expectedImage.image);
    expect(resultImage.fit, BoxFit.fitWidth);
    expect(resultImage.width, 250);
    expect(resultImage.height, 250);
  });
}
