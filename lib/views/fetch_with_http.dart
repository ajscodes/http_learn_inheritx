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
  final ApiServices apiServices = ApiServices();
  List<ApiModel> apiDataList = [];

  late bool isLoading;

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fetch Data Example',
          style: TextStyle(color: Colors.white),
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
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
    );
  }

  Future<void> apiCall() async {
    setState(() {
      isLoading = true;
    });

    final List<ApiModel> res = await apiServices.fetchDate();

    setState(() {
      apiDataList = res;
    });

    if (res.isEmpty) {
      print('list is empty');
    }
    isLoading = false;
  }
}
