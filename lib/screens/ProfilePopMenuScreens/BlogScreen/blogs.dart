import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/blog_comments.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blog_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/review_card.dart';
import 'package:untitled/services/services.dart';

class MyBlogs extends StatefulWidget {
  const MyBlogs({
    Key? key,
  }) : super(key: key);
  @override
  _MyBlogsState createState() => _MyBlogsState();
}

class _MyBlogsState extends State<MyBlogs> {
  int limit = 6;
  int page = 0;
  late AppConfig _appConfig;
  String? selectedValue;
  List<String> items = ['All'];
  fetchAllBlogs() {
    return WebServices.blogItems(page);
  }

  fetchBlogComments() {
    WebServices.blogCommentItems();
  }

  fetchSwatBlogs() {
    return WebServices.getBlogByCategory("Swat Tours",page);
  }

  fetchMountainsBlogs() {
    return WebServices.getBlogByCategory("Mountain Visits",page);
  }

  fetchTripsBlogs() {
    return WebServices.getBlogByCategory("Adventure Trips",page);
  }

  fetchHistoricalBlogs() {
    return WebServices.getBlogByCategory("Historical Trips",page);
  }
  fetchHoneymoonTripBlogs() {
    return WebServices.getBlogByCategory("Honeymoon Trip",page);
  }
  // List<BlogCategory>? _categories= [];
  @override
  void initState() {
    super.initState();
    // print(" list $_categories");
    fetchAllBlogs();
    getCategories();

    fetchSwatBlogs();
    fetchMountainsBlogs();
    fetchTripsBlogs();
    fetchHistoricalBlogs();
    fetchHoneymoonTripBlogs();
    debugPrint(" list $items");
  }

  getCategories() async {
    List<String> item = [];

    await WebServices.getBlogCategory().then((categories) {
      // _categories = categories;
      for (var element in categories) {
        item.add("${element.title}");
        debugPrint("${element.title}");
      }
      debugPrint("list of item $item");
      // items = item;
      debugPrint("list of items $items");
    });
    debugPrint("list of items $items");
    setState(() {
      items.addAll(item);
      // items = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppConfig.tripColor),
    );
    return Scaffold(
      appBar: preferredSizeAppbar("Blogs", context),
      drawer: const MyDrawer(),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
                  (route) => false);
          return Future.value(false);
        },
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: _appConfig.rWP(5),
                    vertical: _appConfig.rHP(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Results",
                        style: TextStyle(
                          fontSize: AppConfig.f2,
                          fontWeight: FontWeight.bold,
                          color: AppConfig.carColor,
                        ),
                        textScaleFactor: 1,
                      ),
                      DropdownButtonHideUnderline(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppConfig.tripColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                30,
                              ),
                            ),
                          ),
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppConfig.whiteColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppConfig.whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: AppConfig.whiteColor,
                            iconDisabledColor: AppConfig.tripColor,
                            buttonHeight: 30,
                            buttonWidth: 160,
                            buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              // border: Border.all(
                              //   color: Colors.black26,
                              // ),
                              color: AppConfig.tripColor,
                            ),
                            buttonElevation: 2,
                            itemHeight: 40,
                            itemPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                            dropdownMaxHeight: 120,
                            dropdownWidth: 160,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppConfig.tripColor,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  if (selectedValue == null || selectedValue== "All")
                    FutureBuilder<List<Blogs>>(
                      future: fetchAllBlogs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          debugPrint(snapshot.error.toString());
                          return Container(
                            height: 300,
                            color: Colors.red,
                          );
                        }
                        return snapshot.hasData
                            ? BlogListItems(
                          items: snapshot.data,
                          categories: items,
                          itemLimit: limit,
                        )
                            : const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                  else if (selectedValue == "Swat Tours")
                    FutureBuilder<List<Blogs>>(
                      future: fetchSwatBlogs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          debugPrint(snapshot.error.toString());
                        }
                        return snapshot.hasData
                            ? SwatBlogListItems(
                          items: snapshot.data,
                          categories: items,
                          itemLimit: limit,
                        )
                            : const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                  else if (selectedValue == "Mountain Visits")
                      FutureBuilder<List<Blogs>>(
                        future: fetchMountainsBlogs(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                          }
                          return snapshot.hasData
                              ? MountainsBlogListItems(
                            items: snapshot.data,
                            categories: items,
                            itemLimit: limit,
                          )
                              : const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    else if (selectedValue == "Adventure Trips")
                        FutureBuilder<List<Blogs>>(
                          future: fetchTripsBlogs(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              debugPrint(snapshot.error.toString());
                            }
                            return snapshot.hasData
                                ? TripsBlogListItems(
                              items: snapshot.data,
                              categories: items,
                              itemLimit: limit,
                            )
                                : const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      else if (selectedValue == "Historical Trips")
                          FutureBuilder<List<Blogs>>(
                            future: fetchHistoricalBlogs(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                debugPrint(snapshot.error.toString());
                              }
                              return snapshot.hasData
                                  ? HistoryBlogListItems(
                                items: snapshot.data,
                                categories: items,
                                itemLimit: limit,
                              )
                                  : const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )
                  else if(selectedValue == "Honeymoon Trip")
                            FutureBuilder<List<Blogs>>(
                              future: fetchHoneymoonTripBlogs(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  debugPrint(snapshot.error.toString());
                                }
                                return snapshot.hasData
                                    ? HoneymoonTripBlogListItems(
                                  items: snapshot.data,
                                  categories: items,
                                  itemLimit: limit,
                                )
                                    : const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            )


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogListItems extends StatefulWidget {
  final List<Blogs>? items;
  final List<String>? categories;
  final int itemLimit;

  const BlogListItems({
    Key? key,
    this.items,
    this.categories,
    required this.itemLimit,
  }) : super(key: key);

  @override
  State<BlogListItems> createState() => _BlogListItemsState();
}

class _BlogListItemsState extends State<BlogListItems> {
  late AppConfig _appConfig;
  List<Blogs> allBlogs = [];
  List<Blogs> filteredBlogs = [];
  int pageNumber = 1;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    WebServices.blogItems(pageNumber).then((value) {
      setState(() {
        allBlogs = value;
        filteredBlogs = allBlogs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rH(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.rH(2),
              ),
              child: CupertinoSearchTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppConfig.shadeColor,
                  size: _appConfig.rH(3),
                ),
                onChanged: (String value) {
                  setState(() {
                    filteredBlogs = allBlogs
                        .where(
                          (element) => (element.title!.toLowerCase().contains(
                        value.toLowerCase(),
                      )),
                    )
                        .toList();
                  });
                },
                backgroundColor: AppConfig.whiteColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () async {
                final temp = await WebServices.blogItems(pageNumber);
                setState(() {
                  filteredBlogs = temp;
                });
                debugPrint('Reloaded');
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredBlogs.length < widget.itemLimit
                    ? filteredBlogs.length
                    : widget.itemLimit,
                itemBuilder: (context, index) {
                  return BlogCard(
                    item: filteredBlogs[index],
                    categories: widget.categories,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CustomBtn(
                  "Previous",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (pageNumber != 1) {
                      filteredBlogs.clear();
                      pageNumber--;
                      final temp = await WebServices.blogItems(pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Already on the first page!',
                      );
                    }
                  },
                ),
                const Spacer(),
                CustomBtn(
                  "Next",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (filteredBlogs.length == 3) {
                      filteredBlogs.clear();
                      pageNumber++;
                      final temp = await WebServices.blogItems(pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'End of items!');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}

class SwatBlogListItems extends StatefulWidget {
  final List<Blogs>? items;
  final List<String>? categories;
  final int itemLimit;

  const SwatBlogListItems({
    Key? key,
    this.items,
    this.categories,
    required this.itemLimit,
  }) : super(key: key);

  @override
  State<SwatBlogListItems> createState() => _SwatBlogListItemsState();
}

class _SwatBlogListItemsState extends State<SwatBlogListItems> {
  List<Blogs> allBlogs = [];
  List<Blogs> filteredBlogs = [];
  int pageNumber = 1;
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    WebServices.getBlogByCategory("Swat Tours",pageNumber).then((value) {
      setState(() {
        allBlogs = value;
        filteredBlogs = allBlogs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rH(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.rH(2),
              ),
              child: CupertinoSearchTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppConfig.shadeColor,
                  size: _appConfig.rH(3),
                ),
                onChanged: (String value) {
                  setState(() {
                    filteredBlogs = allBlogs
                        .where((element) => (element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase())))
                        .toList();
                  });
                },
                backgroundColor: AppConfig.whiteColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () async {
                final temp = await WebServices.getBlogByCategory("Swat",pageNumber);
                setState(() {
                  filteredBlogs = temp;
                });
                debugPrint('Reloaded');
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredBlogs.length < widget.itemLimit
                    ? filteredBlogs.length
                    : widget.itemLimit,
                itemBuilder: (context, index) {
                  return BlogCard(
                    item: filteredBlogs[index],
                    categories: widget.categories,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CustomBtn(
                  "Previous",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (pageNumber != 1) {
                      filteredBlogs.clear();
                      pageNumber--;
                      final temp = await WebServices.getBlogByCategory("Swat Tours",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Already on the first page!',
                      );
                    }
                  },
                ),
                const Spacer(),
                CustomBtn(
                  "Next",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (filteredBlogs.length == 3) {
                      filteredBlogs.clear();
                      pageNumber++;
                      final temp = await WebServices.getBlogByCategory("Swat Tours",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'End of items!');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}

class MountainsBlogListItems extends StatefulWidget {
  final List<Blogs>? items;
  final List<String>? categories;
  final int itemLimit;

  const MountainsBlogListItems({
    Key? key,
    this.items,
    this.categories,
    required this.itemLimit,
  }) : super(key: key);

  @override
  State<MountainsBlogListItems> createState() => _MountainsBlogListItemsState();
}

class _MountainsBlogListItemsState extends State<MountainsBlogListItems> {
  List<Blogs> allBlogs = [];
  List<Blogs> filteredBlogs = [];
  int pageNumber = 1;
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    WebServices.getBlogByCategory("Mountain Visits",pageNumber).then((value) {
      setState(() {
        allBlogs = value;
        filteredBlogs = allBlogs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rH(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.rH(2),
              ),
              child: CupertinoSearchTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppConfig.shadeColor,
                  size: _appConfig.rH(3),
                ),
                onChanged: (String value) {
                  setState(() {
                    filteredBlogs = allBlogs
                        .where((element) => (element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase())))
                        .toList();
                  });
                },
                backgroundColor: AppConfig.whiteColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () async {
                final temp = await WebServices.getBlogByCategory("Mountain Visits",pageNumber);
                setState(() {
                  filteredBlogs = temp;
                });
                debugPrint('Reloaded');
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredBlogs.length < widget.itemLimit
                    ? filteredBlogs.length
                    : widget.itemLimit,
                itemBuilder: (context, index) {
                  return BlogCard(
                    item: filteredBlogs[index],
                    categories: widget.categories,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CustomBtn(
                  "Previous",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (pageNumber != 1) {
                      filteredBlogs.clear();
                      pageNumber--;
                      final temp = await WebServices.getBlogByCategory("Mountain Visits",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Already on the first page!',
                      );
                    }
                  },
                ),
                const Spacer(),
                CustomBtn(
                  "Next",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (filteredBlogs.length == 3) {
                      filteredBlogs.clear();
                      pageNumber++;
                      final temp = await WebServices.getBlogByCategory("Mountain Visits",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'End of items!');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}



class TripsBlogListItems extends StatefulWidget {
  final List<Blogs>? items;
  final List<String>? categories;
  final int itemLimit;

  const TripsBlogListItems({
    Key? key,
    this.items,
    this.categories,
    required this.itemLimit,
  }) : super(key: key);

  @override
  State<TripsBlogListItems> createState() => _TripsBlogListItemsState();
}

class _TripsBlogListItemsState extends State<TripsBlogListItems> {
  List<Blogs> allBlogs = [];
  List<Blogs> filteredBlogs = [];
  int pageNumber = 1;
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    WebServices.getBlogByCategory("Adventure Trips",pageNumber).then((value) {
      setState(() {
        allBlogs = value;
        filteredBlogs = allBlogs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rH(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.rH(2),
              ),
              child: CupertinoSearchTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppConfig.shadeColor,
                  size: _appConfig.rH(3),
                ),
                onChanged: (String value) {
                  setState(() {
                    filteredBlogs = allBlogs
                        .where((element) => (element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase())))
                        .toList();
                  });
                },
                backgroundColor: AppConfig.whiteColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () async {
                final temp = await WebServices.getBlogByCategory("Adventure Trips",pageNumber);
                setState(() {
                  filteredBlogs = temp;
                });
                debugPrint('Reloaded');
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredBlogs.length < widget.itemLimit
                    ? filteredBlogs.length
                    : widget.itemLimit,
                itemBuilder: (context, index) {
                  return BlogCard(
                    item: filteredBlogs[index],
                    categories: widget.categories,
                  );
                },
              ),
            ),
          ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   scrollDirection: Axis.vertical,
          //   itemCount: filteredBlogs.length < widget.itemLimit
          //       ? filteredBlogs.length
          //       : widget.itemLimit,
          //   itemBuilder: (context, index) {
          //     return BlogCard(
          //       item: filteredBlogs[index],
          //       categories: widget.categories,
          //     );
          //   },
          // ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CustomBtn(
                  "Previous",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (pageNumber != 1) {
                      filteredBlogs.clear();
                      pageNumber--;
                      final temp = await WebServices.getBlogByCategory("Adventure Trips",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Already on the first page!',
                      );
                    }
                  },
                ),
                const Spacer(),
                CustomBtn(
                  "Next",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (filteredBlogs.length == 3) {
                      filteredBlogs.clear();
                      pageNumber++;
                      final temp = await WebServices.getBlogByCategory("Adventure Trips",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'End of items!');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}

class HistoryBlogListItems extends StatefulWidget {
  final List<Blogs>? items;
  final List<String>? categories;
  final int itemLimit;

  const HistoryBlogListItems({
    Key? key,
    this.items,
    this.categories,
    required this.itemLimit,
  }) : super(key: key);

  @override
  State<HistoryBlogListItems> createState() => _HistoryBlogListItemsState();
}

class _HistoryBlogListItemsState extends State<HistoryBlogListItems> {
  List<Blogs> allBlogs = [];
  List<Blogs> filteredBlogs = [];
  int pageNumber = 1;
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    WebServices.getBlogByCategory("Historical Trips",pageNumber).then((value) {
      setState(() {
        allBlogs = value;
        filteredBlogs = allBlogs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rH(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.rH(2),
              ),
              child: CupertinoSearchTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppConfig.shadeColor,
                  size: _appConfig.rH(3),
                ),
                onChanged: (String value) {
                  setState(() {
                    filteredBlogs = allBlogs
                        .where((element) => (element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase())))
                        .toList();
                  });
                },
                backgroundColor: AppConfig.whiteColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () async {
                final temp = await WebServices.getBlogByCategory("Historical Trips",pageNumber);
                setState(() {
                  filteredBlogs = temp;
                });
                debugPrint('Reloaded');
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredBlogs.length < widget.itemLimit
                    ? filteredBlogs.length
                    : widget.itemLimit,
                itemBuilder: (context, index) {
                  return BlogCard(
                    item: filteredBlogs[index],
                    categories: widget.categories,
                  );
                },
              ),
            ),
          ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   scrollDirection: Axis.vertical,
          //   itemCount: filteredBlogs.length < widget.itemLimit
          //       ? filteredBlogs.length
          //       : widget.itemLimit,
          //   itemBuilder: (context, index) {
          //     return BlogCard(
          //       item: filteredBlogs[index],
          //       categories: widget.categories,
          //     );
          //   },
          // ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CustomBtn(
                  "Previous",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (pageNumber != 1) {
                      filteredBlogs.clear();
                      pageNumber--;
                      final temp = await WebServices.getBlogByCategory("Historical Trips",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Already on the first page!',
                      );
                    }
                  },
                ),
                const Spacer(),
                CustomBtn(
                  "Next",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (filteredBlogs.length == 3) {
                      filteredBlogs.clear();
                      pageNumber++;
                      final temp = await WebServices.getBlogByCategory("Historical Trips",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'End of items!');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}



class HoneymoonTripBlogListItems extends StatefulWidget {
  final List<Blogs>? items;
  final List<String>? categories;
  final int itemLimit;

  const HoneymoonTripBlogListItems({
    Key? key,
    this.items,
    this.categories,
    required this.itemLimit,
  }) : super(key: key);

  @override
  _HoneymoonTripBlogListItemsState createState() => _HoneymoonTripBlogListItemsState();
}

class _HoneymoonTripBlogListItemsState extends State<HoneymoonTripBlogListItems> {
  List<Blogs> allBlogs = [];
  List<Blogs> filteredBlogs = [];
  int pageNumber = 1;
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    WebServices.getBlogByCategory("Honeymoon Trip",pageNumber).then((value) {
      setState(() {
        allBlogs = value;
        filteredBlogs = allBlogs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rH(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.rH(2),
              ),
              child: CupertinoSearchTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppConfig.shadeColor,
                  size: _appConfig.rH(3),
                ),
                onChanged: (String value) {
                  setState(() {
                    filteredBlogs = allBlogs
                        .where((element) => (element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase())))
                        .toList();
                  });
                },
                backgroundColor: AppConfig.whiteColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () async {
                final temp = await WebServices.getBlogByCategory("Honeymoon Trip",pageNumber);
                setState(() {
                  filteredBlogs = temp;
                });
                debugPrint('Reloaded');
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredBlogs.length < widget.itemLimit
                    ? filteredBlogs.length
                    : widget.itemLimit,
                itemBuilder: (context, index) {
                  return BlogCard(
                    item: filteredBlogs[index],
                    categories: widget.categories,
                  );
                },
              ),
            ),
          ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   scrollDirection: Axis.vertical,
          //   itemCount: filteredBlogs.length < widget.itemLimit
          //       ? filteredBlogs.length
          //       : widget.itemLimit,
          //   itemBuilder: (context, index) {
          //     return BlogCard(
          //       item: filteredBlogs[index],
          //       categories: widget.categories,
          //     );
          //   },
          // ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CustomBtn(
                  "Previous",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (pageNumber != 1) {
                      filteredBlogs.clear();
                      pageNumber--;
                      final temp = await WebServices.getBlogByCategory("Honeymoon Trip",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Already on the first page!',
                      );
                    }
                  },
                ),
                const Spacer(),
                CustomBtn(
                  "Next",
                  30,
                  AppConfig.carColor,
                  textSize: AppConfig.f4,
                  textColor: AppConfig.whiteColor,
                  onPressed: () async {
                    if (filteredBlogs.length == 3) {
                      filteredBlogs.clear();
                      pageNumber++;
                      final temp = await WebServices.getBlogByCategory("Honeymoon Trip",pageNumber);
                      setState(() {
                        filteredBlogs = temp;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'End of items!');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}




class BlogCommentsItems extends StatelessWidget {
  final List<BlogsComments>? items;
  final int itemLimit;
  const BlogCommentsItems({
    Key? key,
    this.items,
    required this.itemLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items!.length < itemLimit ? items!.length : itemLimit,
      itemBuilder: (context, index) {
        return BlogReviewCard(item: items![index]);
      },
    );
  }
}
