import 'package:flutter/material.dart';
import 'package:networking_learn/models/api_model.dart';
import 'package:networking_learn/services/api_services.dart';
import 'package:networking_learn/views/widgets/user_card.dart';

class FetchWithHttp extends StatefulWidget {
  const FetchWithHttp({super.key});

  @override
  State<FetchWithHttp> createState() => _FetchWithHttpState();
}

class _FetchWithHttpState extends State<FetchWithHttp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _findByIdController = TextEditingController();
  final ApiServices apiServices = ApiServices();
  List<ApiModel> apiDataList = [];

  late bool isLoading;

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  void dispose() {
    _findByIdController.dispose();
    super.dispose();
  }

  void _checkValidate() {
    if (_formKey.currentState!.validate()) {
      final int id = int.parse(_findByIdController.text.trim());
      fetchById(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data', style: TextStyle(color: Colors.white)),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _findByIdController,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter ID',
                        suffixIcon: _findByIdController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _findByIdController.clear();
                                  setState(() {});
                                },
                                icon: Icon(Icons.close, color: Colors.black),
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter ID';
                        } else if (!RegExp(r'^[0-9]+$')
                            .hasMatch(value.trim())) {
                          return 'Please enter valid ID';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  _findByIdController.text.isNotEmpty ? ElevatedButton(
                    onPressed: () {
                      _checkValidate();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Get',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ) : ElevatedButton(
                    onPressed: () {
                      apiCall();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final item = apiDataList[index];
                          return UserCard(apiData: item);
                        },
                        itemCount: apiDataList.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> apiCall() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<ApiModel> res = await apiServices.fetchData();

      setState(() {
        apiDataList = res;
      });
    } catch (e) {
      print('Api data is empty or error : $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchById(int id) async {
    setState(() {
      isLoading = true;
    });

    try {
      final ApiModel res = await apiServices.getById(id);

      setState(() {
        apiDataList = [res];
      });
    } catch (e) {
      print('Api data for Id $id not found.');
      setState(() {
        apiDataList = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteById(int id) async {
    setState(() {
      isLoading = true;
    });


  }
}
