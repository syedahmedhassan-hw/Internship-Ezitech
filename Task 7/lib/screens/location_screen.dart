import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/location_provider.dart';
import '../widgets/dummy_map_widget.dart';
import '../widgets/glass_card.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProv = Provider.of<LocationProvider>(context);
    final currentLoc = locationProv.currentLocation;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GeoSense Spatial Hub"),
        actions: [
          IconButton(
            icon: Icon(locationProv.isLiveTracking ? Icons.gps_fixed : Icons.gps_not_fixed),
            color: locationProv.isLiveTracking ? const Color(0xFF00E676) : Colors.grey,
            onPressed: () => locationProv.toggleLiveTracking(),
            tooltip: "Toggle Live GPS Stream",
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              final text =
                  "📍 My Current Location:\nLat: ${currentLoc.latitude}, Lng: ${currentLoc.longitude}\nAddress: ${currentLoc.formattedAddress}\nhttps://maps.google.com/?q=${currentLoc.latitude},${currentLoc.longitude}";
              Share.share(text);
            },
            tooltip: "Share Location",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          children: [
            // Spatial Interactive Map Container
            Container(
              height: 280,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SpatialRadarMapWidget(
                  latitude: currentLoc.latitude,
                  longitude: currentLoc.longitude,
                ),
              ),
            ),

            // Location Telemetry Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "CURRENT SPATIAL POSITION",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 16),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: currentLoc.formattedAddress));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Address copied to clipboard!")),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          currentLoc.formattedAddress,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GlassCard(
                          child: _buildTelemetryBlock(
                            "LATITUDE",
                            currentLoc.latitude.toStringAsFixed(5),
                            Icons.explore_outlined,
                            const Color(0xFF00E5FF),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GlassCard(
                          child: _buildTelemetryBlock(
                            "LONGITUDE",
                            currentLoc.longitude.toStringAsFixed(5),
                            Icons.explore_outlined,
                            const Color(0xFF7C4DFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GlassCard(
                          child: _buildTelemetryBlock(
                            "ALTITUDE",
                            "${currentLoc.altitude.toStringAsFixed(1)} m",
                            Icons.terrain,
                            const Color(0xFF00E676),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GlassCard(
                          child: _buildTelemetryBlock(
                            "SPEED",
                            "${(currentLoc.speed * 3.6).toStringAsFixed(1)} km/h",
                            Icons.speed,
                            const Color(0xFFFFAB00),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bookmark Location Button & Bookmarks Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Saved Bookmarks",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showAddBookmarkModal(context, locationProv),
                        icon: const Icon(Icons.bookmark_add, size: 18),
                        label: const Text("Save Current"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (locationProv.bookmarks.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("No saved location bookmarks yet.", style: TextStyle(color: Colors.grey)),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: locationProv.bookmarks.length,
                      itemBuilder: (context, index) {
                        final item = locationProv.bookmarks[index];
                        final dist = locationProv.calculateDistanceTo(item.latitude, item.longitude);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.08)),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.pin_drop, color: primary, size: 20),
                            ),
                            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("${item.latitude.toStringAsFixed(4)}, ${item.longitude.toStringAsFixed(4)} • ${dist.toStringAsFixed(1)} km away"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                              onPressed: () => locationProv.removeBookmark(item.id),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryBlock(String label, String value, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showAddBookmarkModal(BuildContext context, LocationProvider prov) {
    final titleCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bookmark Current Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: "Location Name / Label",
                hintText: "e.g. Office, Field Base, Home",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  prov.addBookmark(titleCtrl.text, "General");
                  Navigator.pop(ctx);
                },
                child: const Text("Save Bookmark"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
