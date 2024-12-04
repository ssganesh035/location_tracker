import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttendanceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> members = [
    {
      "name": "Selva",
      "id": "WSL0003",
      "timeIn": "09:30 am",
      "timeOut": null,
      "status": "WORKING",
      "imageUrl": "lib/images/1689953440932.jpg",
    },
    {
      "name": "Anirudh",
      "id": "WSL0034",
      "timeIn": "09:30 am",
      "timeOut": "06:40 pm",
      "status": null,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Ritika",
      "id": "WSL0054",
      "timeIn": "09:15 am",
      "timeOut": "05:45 pm",
      "status": null,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Naveen",
      "id": "WSL0100",
      "timeIn": "09:15 am",
      "timeOut": null,
      "status": "WORKING",
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Karan",
      "id": "WSL0035",
      "timeIn": null,
      "timeOut": null,
      "status": "NOT LOGGED-IN YET",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Meera",
      "id": "WSL0036",
      "timeIn": "10:00 am",
      "timeOut": "06:00 pm",
      "status": null,
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Priya",
      "id": "WSL0037",
      "timeIn": "09:45 am",
      "timeOut": null,
      "status": "WORKING",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Rohan",
      "id": "WSL0038",
      "timeIn": "09:20 am",
      "timeOut": "06:10 pm",
      "status": null,
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Simran",
      "id": "WSL0039",
      "timeIn": "09:35 am",
      "timeOut": "05:50 pm",
      "status": null,
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Arjun",
      "id": "WSL0040",
      "timeIn": "10:15 am",
      "timeOut": "06:20 pm",
      "status": null,
      "imageUrl": "https://via.placeholder.com/150"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("ATTENDANCE",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(width: 8), // Add spacing between text and logo
            SvgPicture.asset(
              'lib/images/logo-dark.svg', // Path to the logo
              height: 24, // Adjust size as needed
              width: 24,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Handle menu actions if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildMemberList(context)),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String currentDate = DateFormat('EEE, MMM d yyyy').format(DateTime.now());
    return Container(
      color: Colors.purple[100],
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.group, color: Colors.purple),
              SizedBox(width: 8),
              Text(
                "All Members",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
          Row(
            children: [
              Text(currentDate, style: TextStyle(color: Colors.black)),
              SizedBox(width: 8),
              Icon(Icons.calendar_today, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberList(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: _getImageProvider(member["imageUrl"]),
          ),
          title: Text("${member["name"]} (${member["id"]})"),
          subtitle: Row(
            children: [
              if (member["timeIn"] != null)
                _buildTimeInfo(member["timeIn"], Colors.green),
              if (member["timeOut"] != null)
                _buildTimeInfo(member["timeOut"], Colors.red),
              if (member["status"] != null) _buildStatusTag(member["status"]!),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.timeline, color: Colors.purple),
                onPressed: () {
                  // Handle timeline action
                },
              ),
              IconButton(
                icon: Icon(Icons.location_on, color: Colors.purple),
                onPressed: () {
                  // Navigate to the MapScreen with hardcoded data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        memberName: member["name"],
                        currentLocation:
                            LatLng(37.7749, -122.4194), // Hardcoded location
                        route: [
                          LatLng(37.7749, -122.4194),
                          LatLng(37.7849, -122.4294),
                          LatLng(37.7649, -122.4094),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      // If the image URL starts with "http", it's a network image
      return NetworkImage(imageUrl);
    } else {
      // Otherwise, it's an asset image
      return AssetImage(imageUrl);
    }
  }

  Widget _buildTimeInfo(String time, Color color) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 16, color: color),
          SizedBox(width: 4),
          Text(
            time,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    Color bgColor;
    if (status == "WORKING") {
      bgColor = Colors.green[100]!;
    } else if (status == "NOT LOGGED-IN YET") {
      bgColor = Colors.grey[300]!;
    } else {
      bgColor = Colors.red[100]!;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Show Map view",
          style: TextStyle(
            color: Colors.purple,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
