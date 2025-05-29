// lib/widgets/responsive_scaffold.dart

import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final String title;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.title,
  });

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  bool isRailExtended = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;

        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: isRailExtended,
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: widget.onDestinationSelected,
                  leading: IconButton(
                    icon: Icon(
                      isRailExtended ? Icons.arrow_back_ios : Icons.menu,
                    ),
                    onPressed: () {
                      setState(() {
                        isRailExtended = !isRailExtended;
                      });
                    },
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.upload_file),
                      label: Text('Input'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.history),
                      label: Text('History'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: widget.body),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            drawer: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(child: Text("Phila Tracker")),
                  ListTile(
                    title: const Text("Home"),
                    onTap: () => widget.onDestinationSelected(0),
                  ),
                  ListTile(
                    title: const Text("Input"),
                    onTap: () => widget.onDestinationSelected(1),
                  ),
                  ListTile(
                    title: const Text("History"),
                    onTap: () => widget.onDestinationSelected(2),
                  ),
                ],
              ),
            ),
            body: widget.body,
          );
        }
      },
    );
  }
}
