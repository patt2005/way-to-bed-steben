import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route.dart';
import 'package:way_to_bed_steben/pages/route_details_page.dart';

class RouteCard extends StatelessWidget {
  final MapRoute mapRoute;

  const RouteCard({super.key, required this.mapRoute});

  @override
  Widget build(BuildContext context) {
    bool isRouteCompleted =
        mapRoute.routePoints.every((point) => point.isCompleted);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mapRoute.routePoints.first.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mapRoute.notes,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Route Points:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            for (var point in mapRoute.routePoints)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: point.isCompleted ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      point.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: point.isCompleted ? Colors.green : Colors.red,
                        decoration: point.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            if (mapRoute.imageFilePaths.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Images:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mapRoute.imageFilePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(mapRoute.imageFilePaths[index]),
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor:
                          isRouteCompleted ? Colors.green : Colors.red,
                    ),
                    const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.orange,
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) =>
                            RouteDetailsPage(mapRoute: mapRoute),
                      ),
                    );
                  },
                  child: const Text('View Route Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
