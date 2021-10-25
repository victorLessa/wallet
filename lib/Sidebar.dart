import 'package:file_picker/file_picker.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/components/AskName.dart';
import 'package:wallet/components/Dialog.dart';
import 'package:wallet/components/YeyVisibility.dart';

class Sidebar extends StatelessWidget {
  final component;
  Sidebar({Key key, this.component}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return sidebar(component: this.component);
  }
}

class sidebar extends StatefulWidget {
  final component;
  const sidebar({Key key, this.component}) : super(key: key);
  @override
  _sidebarState createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> with TickerProviderStateMixin {
  bool sideBarActive = false;
  AnimationController rotationController;

  AdSize adSize = AdSize(width: 300, height: 50);
  BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
  BannerAd myBanner;
  @override
  void initState() {
    // TODO: implement initState

    rotationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-8315151818484833/7832416735',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();
    super.initState();
  }

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f3f6),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(60)),
                        color: Colors.white),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xfff1f3f6),
                              image: DecorationImage(
                                  image: AssetImage('asset/images/avatar4.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder<Controller>(
                                builder: (_) => Text(
                                  controller.username ?? 'Sem nome',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              exibirDialogo(context, controller);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: CircleAvatar(
                                maxRadius: 9.0,
                                backgroundColor: Colors.black26,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 10.0,
                                  semanticLabel: 'Editar seu nome.',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => {Navigator.pushNamed(context, '/homePage')},
                      child: navigatorTitle("Início ",
                          ModalRoute.of(context).settings.name == '/homePage'),
                    ),
                    InkWell(
                      onTap: () => {Navigator.pushNamed(context, '/quotes')},
                      child: navigatorTitle("Cotações ",
                          ModalRoute.of(context).settings.name == '/quotes'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/addStock');
                      },
                      child: navigatorTitle("Adicionar ativos",
                          ModalRoute.of(context).settings.name == '/addStock'),
                    ),
                    InkWell(
                      onTap: () async {
                        var path =
                            controller.dir.path + "/" + controller.fileName;
                        await Share.shareFiles(['$path'],
                            text: 'Great picture');
                      },
                      child: navigatorTitle("Exportar dados", false),
                    ),
                    InkWell(
                      onTap: () async {
                        FilePickerResult result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['json'],
                        );

                        if (result != null) {
                          var path = result.files.first.path.toString();
                          try {
                            await controller.addSave(path);
                          } catch (e) {
                            dialog('Arquivo não suportado.', context);
                          }
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: navigatorTitle("Importar dados", false),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Ver 0.0.1 alfa",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: (sideBarActive) ? MediaQuery.of(context).size.width * 0.6 : 0,
            top: (sideBarActive) ? MediaQuery.of(context).size.height * 0.2 : 0,
            child: RotationTransition(
              turns: (sideBarActive)
                  ? Tween(begin: -0.05, end: 0.0).animate(rotationController)
                  : Tween(begin: 0.0, end: -0.05).animate(rotationController),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: (sideBarActive)
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height,
                width: (sideBarActive)
                    ? MediaQuery.of(context).size.width * 0.9
                    : MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  child: widget.component,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 20,
            child: Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<Controller>(
                    builder: (_) => yeyVisibility(controller),
                  ),
                  SizedBox(width: 20.0),
                  (sideBarActive)
                      ? IconButton(
                          onPressed: closeSideBar,
                          icon: Icon(
                            Icons.close,
                            color: Colors.blueGrey,
                            size: 30,
                          ),
                        )
                      : IconButton(
                          onPressed: openSideBar,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.blueGrey,
                            size: 30,
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
              child: AdWidget(ad: this.myBanner),
            ),
          )
        ],
      ),
    );
  }

  Row navigatorTitle(String name, bool isSelected) {
    return Row(
      children: [
        (isSelected)
            ? Container(
                width: 5,
                height: 60,
                color: Color(0xffffac30),
              )
            : Container(
                width: 5,
                height: 60,
              ),
        SizedBox(
          width: 10,
          height: 60,
        ),
        Text(
          name,
          style: TextStyle(
              fontSize: 16,
              fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400),
        )
      ],
    );
  }

  void closeSideBar() {
    sideBarActive = false;
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    setState(() {});
  }
}
