import 'package:flutter/material.dart';
import 'package:networking_learn/models/api_model.dart';
import 'package:networking_learn/views/add_edit_card.dart';

class UserCard extends StatelessWidget {
  final ApiModel apiData;
  final VoidCallback onDelete;

  const UserCard({super.key, required this.apiData, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditCard(editCard: apiData),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text('User ID: ${apiData.userId}'),
                    backgroundColor: Colors.blue.withValues(alpha: 0.1),
                  ),
                  Chip(
                    label: Text('Post ID: ${apiData.id}'),
                    backgroundColor: Colors.amber.withValues(alpha: 0.1),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                apiData.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                apiData.body,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
