import 'dart:async';

import 'package:dolphin_ride/core/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(
          BuildContext context, T model)
      builder;
  final T model;
  final Function(T) onModelReady;
  final Function(T) onRebuild;
  final Function(BuildContext context, T model) onViewFirstLoad;
  final Function(BuildContext context, T model, String errorCode)
      onErrorOccured;
  final Function(BuildContext context, T model, String event) onEventOccured;

  BaseView({
    Key key,
    this.builder,
    this.model,
    this.onModelReady,
    this.onViewFirstLoad,
    this.onErrorOccured,
    this.onEventOccured,
    this.onRebuild,
  }) : super(key: key);

  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  BaseViewModel model;
  StreamSubscription<String> errorSubscription;
  StreamSubscription<String> eventSubscription;
  // LayoutInformation layoutInformation;
  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    errorSubscription = model.onErrorOccured.listen(onErrorOccured);
    eventSubscription = model.onEventOccured.listen(onEventOccured);
    WidgetsBinding.instance.addPostFrameCallback(onWidgetFirstBuilt);
    super.initState();
  }

  void onEventOccured(String event) {
    if (widget.onEventOccured != null && mounted) {
      widget.onEventOccured(context, model, event);
      setState(() {});
    }
  }

  void onErrorOccured(String event) {
    if (widget.onErrorOccured != null && mounted) {
      widget.onErrorOccured(context, model, event);
      setState(() {});
    }
  }

  void onWidgetFirstBuilt(Duration timeStamp) {
    if (widget.onViewFirstLoad != null && mounted) {
      widget.onViewFirstLoad(context, model);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRebuild != null) widget.onRebuild(model);
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(
        builder: (BuildContext context, T t, Widget child) =>
            widget.builder(context, t),
      ),
    );
  }

  @override
  void dispose() {
    errorSubscription?.cancel();
    eventSubscription?.cancel();
    super.dispose();
  }
}