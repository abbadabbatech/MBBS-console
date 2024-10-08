import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grid_layout_model.dart';
export 'grid_layout_model.dart';

class GridLayoutWidget extends StatefulWidget {
  const GridLayoutWidget({super.key});

  @override
  State<GridLayoutWidget> createState() => _GridLayoutWidgetState();
}

class _GridLayoutWidgetState extends State<GridLayoutWidget> {
  late GridLayoutModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GridLayoutModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        final chnnelGridList = FFAppState().channelLogList.toList();

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 16,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 420 / 300,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: chnnelGridList.length,
          itemBuilder: (context, chnnelGridListIndex) {
            final chnnelGridListItem = chnnelGridList[chnnelGridListIndex];
            return Container(
              width: 5.0,
              height: 10.0,
              decoration: const BoxDecoration(),
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    functions.returnCharacter(chnnelGridListItem.character),
                    '254',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Courier Prime',
                        color: FlutterFlowTheme.of(context).secondary,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
