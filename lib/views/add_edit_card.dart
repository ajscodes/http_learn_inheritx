import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:networking_learn/models/api_model.dart';

class AddEditCard extends StatefulWidget {
  final ApiModel? editCard;

  const AddEditCard({super.key, this.editCard});

  @override
  State<AddEditCard> createState() => _AddEditCardState();
}

class _AddEditCardState extends State<AddEditCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isEdit;

  late TextEditingController _userIdController;
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  void _checkValidate() {
    if (_formKey.currentState!.validate()) {
      final updatedCard = ApiModel(
          userId: int.parse(_userIdController.text.trim()),
          title: _titleController.text.trim(),
          body: _bodyController.text.trim()
      );

      Navigator.pop(context, updatedCard);
    }
  }

  @override
  void initState() {
    super.initState();
    _isEdit = widget.editCard != null;

    _userIdController = TextEditingController(
      text: _isEdit ? widget.editCard!.userId.toString() : '',
    );
    _titleController = TextEditingController(
      text: _isEdit ? widget.editCard!.title : '',
    );
    _bodyController = TextEditingController(
      text: _isEdit ? widget.editCard!.body : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Update Data' : 'Add Data',
          style: TextStyle(color: Colors.white),
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'UserId',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2),
              TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Please Enter User Id';
                  }
                  if (value
                      .trim()
                      .length > 5) {
                    return 'Max 5 characters allowed';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2),
              TextFormField(controller: _titleController,
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Please Enter Title';
                  }
                  if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                    return 'Only characters are allowed';
                  }
                  if (value
                      .trim()
                      .length > 15) {
                    return 'Max 15 characters allowed';
                  }
                  if (value
                      .trim()
                      .length < 3) {
                    return 'Min 3 characters required';
                  }
                  return null;
                },),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Body',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2),
              TextFormField(
                controller: _bodyController,
                minLines: 1,
                maxLines: 8,
                maxLength: 500,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)
                    ),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _checkValidate();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)
                    ),
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
