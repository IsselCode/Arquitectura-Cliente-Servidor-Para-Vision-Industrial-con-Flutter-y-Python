import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../clean_features/entities/device_entity.dart';
import '../clean_features/widgets/scan_pulse_button.dart';
import '../controller/device_controller.dart';

class ScanDevicesView extends StatefulWidget {
  const ScanDevicesView({super.key});

  @override
  State<ScanDevicesView> createState() => _ScanDevicesViewState();
}

class _ScanDevicesViewState extends State<ScanDevicesView> {
  late Future<List<DeviceEntity>> _devicesFuture;

  @override
  void initState() {
    super.initState();
    DeviceController deviceController = context.read();
    _devicesFuture = deviceController.discoverWithNsd();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          final double bigSize = h * 0.85;
          final double smallSize = h * 0.65;

          return FutureBuilder<List<DeviceEntity>>(
            future: _devicesFuture,
            builder: (context, snapshot) {
              final bool ready = snapshot.connectionState == ConnectionState.done;
              final devices = snapshot.data ?? const <DeviceEntity>[];
              final int count = devices.length;

              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: ready ? 1.0 : 0.0),
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeInOutCubic,
                builder: (context, t, _) {
                  final double split = 1.0 - 0.5 * t;
                  final double btnSize = bigSize + (smallSize - bigSize) * t;

                  final double panelW = (w * 0.5).clamp(360.0, w); // ancho del panel

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [

                      // t: 0 -> fuera; 1 -> adentro
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: -panelW * (1.0 - t),
                        width: panelW,
                        child: _RightPanel(devices: devices, loading: !ready,),
                      ),

                      Positioned(
                        left: 0,
                        right: w * (1 - split),
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: ScanPulseButton(
                            size: btnSize * 1,
                            textStyle: textTheme.displayLarge?.copyWith(color: colorScheme.primary),
                            avatarColor: colorScheme.surface,
                            image: AppAssets.db,
                            active: !ready,
                            quantity: count,
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _RightPanel extends StatelessWidget {
  final List<DeviceEntity> devices;
  final bool loading;

  const _RightPanel({required this.devices, required this.loading});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    if (loading) {
      return Center(child: CircularProgressIndicator(),);
    }

    if (devices.isEmpty) {
      return const Center(
        child: Text('Sin dispositivos', style: TextStyle(fontSize: 16)),
      );
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Dispositivos Encontrados",
              style: textTheme.displayLarge,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: devices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10
                ),
                itemBuilder: (context, i) {
                  final d = devices[i];
                  return InkWell(
                    onTap: () {
                      DeviceController deviceController = context.read();
                      deviceController.device = d;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(),));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Image.asset(AppAssets.db, height: 128, width: 128,),
                          Text(d.name, style: textTheme.titleMedium,),
                          Text("${d.host}:${d.port}", style: textTheme.titleMedium,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setDevice(BuildContext context, DeviceEntity device) {
    DeviceController deviceController = context.read();
    deviceController.device = device;
  }
}
