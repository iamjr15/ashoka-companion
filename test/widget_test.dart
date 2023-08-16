import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojek_university_app/features/schedule/views/schedule_screen.dart';
import 'package:gojek_university_app/main.dart';

// EventStepperTile

void main() {
  testWidgets('This widget is showing events', (WidgetTester widgetTester)async {
    await widgetTester.pumpWidget(ProviderScope(child: const MyApp()));
    final textWidget = find.byType(MaterialApp);
    expect(textWidget, findsOneWidget);
  });
}