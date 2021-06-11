import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraLivePreviewScreen extends StatefulWidget {
  final double? top;
  final double? left;

  const CameraLivePreviewScreen(
      {Key? key, @required this.top, @required this.left})
      : super(key: key);
  @override
  CameraLivePreviewScreenState createState() => CameraLivePreviewScreenState();
}

class CameraLivePreviewScreenState extends State<CameraLivePreviewScreen> {
  final GlobalKey cameraKey = GlobalKey(debugLabel: 'LiveCamera');
  late QRViewController _captureController;

  GlobalKey _key = GlobalKey();
  late double? top, left;
  late double? xOff, yOff;

  @override
  void initState() {
    top = widget.top;
    left = widget.left;
    print("top - $top, left - $left");
    xOff = 0;
    yOff = 0;
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) async {
    this._captureController = controller;
    await _captureController.flipCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      key: _key,
      top: top,
      left: left,
      child: SizedBox(
        height: 150,
        width: 100,
        child: Draggable(
          child: QRView(
            key: cameraKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          feedback: Container(), //remains behind
          childWhenDragging: QRView(
            key: cameraKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          onDragUpdate: (drag) {
            setState(() {
              top = drag.globalPosition.dy;
              left = drag.globalPosition.dx;
            });
          },
        ),
      ),
    );
  }
}
