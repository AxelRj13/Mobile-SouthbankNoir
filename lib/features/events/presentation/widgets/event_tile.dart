import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';

class EventTile extends StatelessWidget {
  final bool isTodayEvent;
  final String? headerLabel;
  final String? image;
  final String? artist;
  final String? timeStart;
  final String? storeName;
  final bool? isFullBook;

  const EventTile({
    super.key,
    required this.isTodayEvent,
    required this.headerLabel,
    required this.image,
    required this.artist,
    required this.timeStart,
    required this.storeName,
    required this.isFullBook,
  });

  Widget _buildHeader() {
    return isTodayEvent
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  headerLabel!,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          )
        : Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(headerLabel!),
                ],
              ),
            ),
          );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image != null
              ? NetworkImage(image!)
              : const AssetImage('assets/img/logo.png') as ImageProvider,
        ),
      ),
    );
  }

  Widget _buildInfo(IconData icon, String label) {
    return Wrap(
      children: [
        Icon(
          icon,
          size: 18.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(color: accentColor),
        )
      ],
    );
  }

  Widget _buildButton() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: accentColor,
        disabledBackgroundColor: Colors.grey,
        minimumSize: const Size.fromHeight(20.0),
      ),
      onPressed: !isFullBook! ? () {/* ... */} : null,
      child: Text(
        !isFullBook! ? 'Reserve' : 'Fully Booked',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _buildImage(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfo(Icons.person, artist!),
                        const SizedBox(height: 10.0),
                        _buildInfo(Icons.schedule, timeStart!),
                        const SizedBox(height: 10.0),
                        _buildInfo(Icons.location_on, storeName!),
                        const SizedBox(height: 10.0),
                        _buildButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
