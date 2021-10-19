import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/components/ShowDialog.dart';

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
  @override
  void initState() {
    // TODO: implement initState

    rotationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
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
                                    image:
                                        AssetImage('asset/images/avatar4.png'),
                                    fit: BoxFit.contain)),
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
                                )),
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
                      child: navigatorTitle("Home",
                          ModalRoute.of(context).settings.name == '/homePage'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/projections');
                      },
                      child: navigatorTitle(
                          "Projeções",
                          ModalRoute.of(context).settings.name ==
                              '/projections'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/addStock');
                      },
                      child: navigatorTitle("Adicionar ativos",
                          ModalRoute.of(context).settings.name == '/addStock'),
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
            right: 0,
            top: 20,
            child: (sideBarActive)
                ? IconButton(
                    padding: EdgeInsets.all(30),
                    onPressed: closeSideBar,
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  )
                : InkWell(
                    onTap: openSideBar,
                    child: Container(
                      margin: EdgeInsets.all(17),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('asset/images/menu.png'))),
                    ),
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
