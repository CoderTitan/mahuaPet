import 'package:flutter/material.dart';

class AnimatWidget extends StatefulWidget {
  @override
  _AnimatedWidgetState createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatWidget> with TickerProviderStateMixin {

  AnimationController _animationAlignTransition;
  Animation<AlignmentGeometry> _animationTransition;
  AlignmentGeometry _aligmentAlign = Alignment.topLeft;

  AnimationController _animationBuildController;
  Animation<double> _animationBuild;

  AnimationController _animationModalController;
  Animation<Color> _animationModal;

  bool isClick = false;
  double _opacity = 1;
  EdgeInsetsGeometry _padding = EdgeInsets.symmetric(horizontal: 0);
  double _left = 0;
  double _width = 50;
  double _height = 50;

  Widget _cutrrentChild = Container(key: ValueKey('1'), color: Colors.orange, width: 50, height: 50);

  @override
  void initState() {
    _animationAlignTransition = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animationTransition = Tween<AlignmentGeometry>(begin: Alignment.topLeft, end: Alignment.bottomRight).animate(_animationAlignTransition);

    _animationAlignTransition.forward();

    _animationBuildController = AnimationController(duration: Duration(seconds: 2), vsync: this)
      ..addStatusListener((status) { 
        if (status == AnimationStatus.completed) {
          _animationBuildController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationBuildController.forward();
        }
      });

    _animationBuild = Tween<double>(begin: 0, end: 2).animate(_animationBuildController);
    _animationBuildController.forward();

    _animationModalController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animationModal = ColorTween(begin: Colors.orange, end: Colors.blueGrey).animate(_animationModalController);
    _animationModalController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationAlignTransition.dispose();
    _animationBuildController.dispose();
    _animationModalController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SectionA')),
      body: Container(
        padding: EdgeInsets.only(bottom: 34),
        child: SingleChildScrollView(
          child: Column(
            children: [
              renderAlignTransition(),
              renderAnimatedAlign(),
              renderAnimatedBuild(),
              renderAnimatedContainer(),
              renderAnimatedCrossFade(),
              renderDefaultTextStyle(),
              renderAnimatedIcon(),
              renderAnimatedModal(),
              renderAnimatedOpacity(),
              renderAnimatedPadding(),
              renderAnimatedPhysicalModel(),
              renderAnimatedPosition(),
              renderAnimatedPositionDirectional(),
              renderAnimatedSize(),
              renderAnimatedSwitch()
            ],
          ),
        ),
      ),
    );
  }

  Widget renderAlignTransition() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AlignTransition', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('对Align子控件位置变换动画', style: TextStyle(fontSize: 12)),
          Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: AlignTransition(
              alignment: _animationTransition, 
              child: Container(width: 30, height: 30, color: Colors.orange,)
            ),
          )
        ],
      ),
    );
  }

  Widget renderAnimatedAlign() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedAlign', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('方便我们构建位置动画', style: TextStyle(fontSize: 12)),
          Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: AnimatedAlign(
              alignment: _aligmentAlign, 
              duration: Duration(seconds: 2),
              curve: Curves.easeInToLinear,
              child: GestureDetector(
                child: Container(width: 30, height: 30, color: Colors.orange,),
                onTap: () {
                  setState(() {
                    _aligmentAlign = Alignment.bottomRight;
                  });
                },
              ),
              onEnd: () {
                setState(() {
                    _aligmentAlign = Alignment.topLeft;
                  });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget renderAnimatedBuild() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AlignTransition', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('对Align子控件位置变换动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          AnimatedBuilder(
            animation: _animationBuild, 
            child: Icon(Icons.desktop_mac, color: Colors.blue[300], size: 100),
            builder: (ctx, child) {
              return Transform.rotate(
                angle: _animationBuild.value,
                child: child,
              );
            }
          )
        ],
      ),
    );
  }

  Widget renderAnimatedContainer() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedContainer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('带动画功能的Container', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: AnimatedContainer(
              height: isClick ? 200 : 100,
              width: isClick ? 200 : 100,
              duration: Duration(milliseconds: 250),
              color: Colors.blue,
            ),
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimatedCrossFade() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedCrossFade', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('2个组件在切换时出现交叉渐入的效果', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 250),
              crossFadeState: isClick ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstCurve: Curves.linearToEaseOut,
              secondCurve: Curves.easeInCirc,
              firstChild: Container(
                height: 200,
                width: 200,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text('firstChild', style: TextStyle(fontSize: 12)),
              ),
              secondChild: Container(
                height: 100,
                width: 400,
                color: Colors.orange,
                alignment: Alignment.center,
                child: Text('secondChild', style: TextStyle(fontSize: 12)),
              ),
            ),
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderDefaultTextStyle() {
    final firstStyle = TextStyle(color: Colors.blue, fontSize: 12);
    final secordStyle = TextStyle(color: Colors.orange, fontSize: 24);
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedDefaultTextStyle', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('动画更改文字样式', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 250),
              child: Text('titanjun'),
              style: isClick ? secordStyle : firstStyle,
            ),
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimatedIcon() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedIcon', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('动画图标', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: 100, height: 100,
              alignment: Alignment.center,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                progress: _animationBuildController
              ),
            ),
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimatedModal() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedModalBarrier', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('ModalBarrier控件的颜色进行动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: 100, height: 100,
              alignment: Alignment.center,
              child: AnimatedModalBarrier(
                color: _animationModal,
              ),
            ),onTap: (){},
          )
        ],
      ),
    );
  }

  Widget renderAnimatedOpacity() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedOpacity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('它可以使子组件变的透明动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: 100, height: 100,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: 100, height: 100,
                  color: Colors.amber,
                ),
                onEnd: () {
                  setState(() {
                    _opacity = 1;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                _opacity = 0;
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimatedPadding() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedPadding', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('动态改变内边距的动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: double.maxFinite, height: 100,
              alignment: Alignment.center,
              child: AnimatedPadding(
                padding: _padding,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  color: Colors.amber,
                ),
                onEnd: () {
                  setState(() {
                    _padding = EdgeInsets.symmetric(horizontal: 0);
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                _padding = EdgeInsets.symmetric(horizontal: 100);
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimatedPhysicalModel() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedPhysicalModel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('修改子组件的多属性的动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: double.maxFinite, height: 100,
              alignment: Alignment.center,
              child: AnimatedPhysicalModel(
                duration: Duration(milliseconds: 1000),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(isClick ? 20 : 10),
                color: isClick ? Colors.blue : Colors.red,
                elevation: isClick ? 18 : 8,
                shadowColor: isClick ? Colors.blue : Colors.red,
                child: Container(width: 100, height: 100),
              ),
            ),
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget renderAnimatedPosition() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Stack(
        children: [
          Container(width: double.maxFinite, height: 200),
          Positioned(
            left: 10,
            child: Text('AnimatedPhysicalModel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Text('动态改变位置的动画', style: TextStyle(fontSize: 12)),
          ),
          AnimatedPositioned(
            left: _left,
            top: 50,
            duration: Duration(seconds: 1),
            child: GestureDetector(
              child: Container(
                width: 100, height: 100,
                color: Colors.amber,
              ),
              onTap: () {
                setState(() {
                  _left = 280;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget renderAnimatedPositionDirectional() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Stack(
        children: [
          Container(width: double.maxFinite, height: 200),
          Positioned(
            left: 10,
            child: Text('AnimatedPositionedDirectional', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Text('动态改变位置的动画', style: TextStyle(fontSize: 12)),
          ),
          AnimatedPositionedDirectional(
            end: _left,
            top: 50,
            duration: Duration(seconds: 1),
            child: GestureDetector(
              child: Container(
                width: 100, height: 100,
                color: Colors.amber,
              ),
              onTap: () {
                setState(() {
                  _left = 280;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget renderAnimatedSize() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedSize', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('动态改变大小的动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: double.maxFinite, height: 200,
              alignment: Alignment.center,
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 2000),
                reverseDuration: Duration(milliseconds: 2000),
                child: Container(
                  color: Colors.blue,
                  width: _width,
                  height: _height,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                _width = 100;
                _height = 100;
              });
            },
          )
        ],
      ),
    );
  }

  Widget renderAnimatedSwitch() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 100),
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          Text('AnimatedSwitcher', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('2个或者多个子组件之间切换时使用动画', style: TextStyle(fontSize: 12)),
          SizedBox(height: 30,),
          GestureDetector(
            child: Container(
              width: double.maxFinite, height: 200,
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                reverseDuration: Duration(seconds: 1),
                child: _cutrrentChild,
                transitionBuilder: (child, value) {
                  return ScaleTransition(
                    scale: value,
                    child: child,
                  );
                },
              ),
            ),
            onTap: () {
              setState(() {
                _cutrrentChild = Container(
                  key: ValueKey('2'),
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                );
              });
            },
          )
        ],
      ),
    );
  }
}