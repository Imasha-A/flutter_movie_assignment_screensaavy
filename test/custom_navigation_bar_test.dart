import 'package:flutter_movie_assignment_screensaavy/screens/home_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watched_list.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movie_assignment_screensaavy/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  //testing if my navigation bar constructs and displays correctly
  testWidgets('My custom navigation bar renders correctly',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MyNavigationBar(),
        ),
      ),
    );

    //Assert
    //checks if container is rendered
    expect(find.byType(Container), findsOneWidget);
    //checks if there are 3 icons in a row
    expect(find.byType(Icon), findsNWidgets(3));
  });

  //testing if my navigation bar row alignment is correct
  testWidgets('My custom navigation bar aligns properly in a row',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MyNavigationBar(),
        ),
      ),
    );

    //Act
    final rowFinder = find.byType(Row);
    final mainAxisAlignment =
        (tester.widget(rowFinder) as Row).mainAxisAlignment;
    //Assert
    //verifies that the alignment is as intended
    expect(mainAxisAlignment, MainAxisAlignment.spaceAround);
  });

  //testing if my navigation bar icons navigate to the correct screens
  testWidgets('My navigation bar icons navigate to the correct screens',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: const Scaffold(
          body: MyNavigationBar(),
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/watchedList': (context) => const WatchedList(),
          '/watchlist': (context) => const Watchlist(),
        },
      ),
    );

    //Act &Assert
    //Checking if tapping the first icon navigates to the HomeScreen
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);

    //Checking if tapping the second icon navigates to the Watched List Screen
    await tester.tap(find.byIcon(Icons.check_box));
    await tester.pumpAndSettle();
    expect(find.byType(WatchedList), findsOneWidget);

    //Checking if tapping the thrid icon navigates to the Watchlist Screen
    await tester.tap(find.byIcon(Icons.bookmark));
    await tester.pumpAndSettle();
    expect(find.byType(Watchlist), findsOneWidget);
  });

  //testing if my navigation bar icons have the corerct size
  testWidgets('My custom navigation bar icons have the correct size',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MyNavigationBar(),
        ),
      ),
    );

    //Assert
    //checks if the icon sizes are as expected
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.home).evaluate().single.size, const Size(35, 35));

    expect(find.byIcon(Icons.check_box), findsOneWidget);
    expect(find.byIcon(Icons.check_box).evaluate().single.size,
        const Size(35, 35));

    expect(find.byIcon(Icons.bookmark), findsOneWidget);
    expect(
        find.byIcon(Icons.bookmark).evaluate().single.size, const Size(35, 35));
  });
}
