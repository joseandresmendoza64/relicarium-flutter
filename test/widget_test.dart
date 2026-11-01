import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tech_catalog/main.dart';
import 'package:tech_catalog/providers/catalog_provider.dart';
import 'package:tech_catalog/providers/connection_provider.dart';
import 'test_dependencies.dart';

Future<void> openCatalog(
  WidgetTester tester, {
  required bool online,
}) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              ConnectionProvider(TestConnectivityService(online)),
        ),
        ChangeNotifierProvider(
          create: (_) => CatalogProvider(TestCatalogRepository()),
        ),
      ],
      child: const RelicariumApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Muestra el catalogo con la nueva marca', (tester) async {
    await openCatalog(tester, online: true);

    expect(find.text('RELICARIUM II'), findsOneWidget);
    expect(find.text('Teseracto'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Sin conexión'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Muestra el aviso offline y conserva el catalogo', (tester) async {
    await openCatalog(tester, online: false);

    expect(find.text('Sin conexión'), findsOneWidget);
    expect(find.text('Teseracto'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}