
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_catalog/main.dart';

void main() {
  testWidgets('Relicarium muestra su catalogo', (tester) async {
    await tester.pumpWidget(const RelicariumApp());

    expect(find.text('RELICARIUM'), findsOneWidget);
    expect(find.text('Teseracto'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}
