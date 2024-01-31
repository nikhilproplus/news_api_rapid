import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_api_rapid/controller/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetDataController getDataController = Get.put(GetDataController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getDataController.getDataApi();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            "News Hub",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 3,
          shadowColor: Colors.grey,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await getDataController.getDataApi();
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.refresh),
        ),
        backgroundColor: Colors.deepPurple.shade100,
        body: Center(
          child: SmartRefresher(
            enablePullDown: true,
            // enablePullUp: true,
            onRefresh: () {
              getDataController.saveData.clear();
              getDataController.getDataApi();
              refreshController.refreshCompleted();
            },
            onLoading: () {
              getDataController.getDataApi();
              refreshController.loadComplete();
            },
            controller: refreshController,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: getDataController.searchItemController.value,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        hintText: 'Type your topic',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              getDataController.itemName.value =
                                  getDataController
                                      .searchItemController.value.text;
                              getDataController.saveData.clear();
                              await getDataController.getDataApi();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Search'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        getDataController.itemName.value = 'India';
                        getDataController.searchItemController.value.clear();
                        getDataController.saveData.clear();
                        await getDataController.getDataApi();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orangeAccent,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Clear Screen'),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Latest news about ${getDataController.itemName.value}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => getDataController.isDataLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : getDataController.saveData.first!.data.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No news available, please try again",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: getDataController
                                      .saveData.first!.data.length,
                                  itemBuilder: (context, index) {
                                    var apiData =
                                        getDataController.saveData.first!.data;

                                    int timestamp = apiData[index].date;
                                    DateTime dateTime =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            timestamp * 1000);
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(dateTime);

                                    return Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (apiData[index].image != null)
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(15)),
                                                child: Image.network(
                                                  apiData[index]
                                                      .image
                                                      .toString(),
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    apiData[index].title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    formattedDate,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.deepPurple,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(apiData[index].excerpt),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    apiData[index].relativeTime,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
