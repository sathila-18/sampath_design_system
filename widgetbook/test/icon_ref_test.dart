// iconRef must give each registry entry's real field name. The keys are
// compiled, so a renamed field fails to build, and a new icon fails the
// coverage test until its line is added here.
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:sampath_widgetbook/shared/code_snippet.dart';

const _expected = <SampathIconData, String>{
  SampathIcons.arrowDownLeft: 'SampathIcons.arrowDownLeft',
  SampathIcons.arrowUp: 'SampathIcons.arrowUp',
  SampathIcons.arrowUpRight: 'SampathIcons.arrowUpRight',
  SampathIcons.bell: 'SampathIcons.bell',
  SampathIcons.calendar: 'SampathIcons.calendar',
  SampathIcons.camera: 'SampathIcons.camera',
  SampathIcons.cardNoAccess: 'SampathIcons.cardNoAccess',
  SampathIcons.chatBubble: 'SampathIcons.chatBubble',
  SampathIcons.check: 'SampathIcons.check',
  SampathIcons.checkCircle: 'SampathIcons.checkCircle',
  SampathIcons.checkCircleSolid: 'SampathIcons.checkCircleSolid',
  SampathIcons.clock: 'SampathIcons.clock',
  SampathIcons.clockRotateRight: 'SampathIcons.clockRotateRight',
  SampathIcons.coins: 'SampathIcons.coins',
  SampathIcons.creditCard: 'SampathIcons.creditCard',
  SampathIcons.dataTransferBoth: 'SampathIcons.dataTransferBoth',
  SampathIcons.download: 'SampathIcons.download',
  SampathIcons.editPencil: 'SampathIcons.editPencil',
  SampathIcons.eye: 'SampathIcons.eye',
  SampathIcons.eyeClosed: 'SampathIcons.eyeClosed',
  SampathIcons.fastArrowRight: 'SampathIcons.fastArrowRight',
  SampathIcons.globe: 'SampathIcons.globe',
  SampathIcons.graphUp: 'SampathIcons.graphUp',
  SampathIcons.headsetHelp: 'SampathIcons.headsetHelp',
  SampathIcons.homeSimple: 'SampathIcons.homeSimple',
  SampathIcons.infoCircle: 'SampathIcons.infoCircle',
  SampathIcons.lock: 'SampathIcons.lock',
  SampathIcons.microphone: 'SampathIcons.microphone',
  SampathIcons.minus: 'SampathIcons.minus',
  SampathIcons.moreHoriz: 'SampathIcons.moreHoriz',
  SampathIcons.navArrowDown: 'SampathIcons.navArrowDown',
  SampathIcons.navArrowLeft: 'SampathIcons.navArrowLeft',
  SampathIcons.navArrowRight: 'SampathIcons.navArrowRight',
  SampathIcons.navArrowUp: 'SampathIcons.navArrowUp',
  SampathIcons.plus: 'SampathIcons.plus',
  SampathIcons.refreshDouble: 'SampathIcons.refreshDouble',
  SampathIcons.scanQrCode: 'SampathIcons.scanQrCode',
  SampathIcons.search: 'SampathIcons.search',
  SampathIcons.settings: 'SampathIcons.settings',
  SampathIcons.shareAndroid: 'SampathIcons.shareAndroid',
  SampathIcons.star: 'SampathIcons.star',
  SampathIcons.trash: 'SampathIcons.trash',
  SampathIcons.upload: 'SampathIcons.upload',
  SampathIcons.user: 'SampathIcons.user',
  SampathIcons.wallet: 'SampathIcons.wallet',
  SampathIcons.warningTriangle: 'SampathIcons.warningTriangle',
  SampathIcons.xmark: 'SampathIcons.xmark',
  SampathIcons.xmarkSolid: 'SampathIcons.xmarkSolid',
  SampathIcons.assistant: 'SampathIcons.assistant',
  SampathIcons.insights: 'SampathIcons.insights',
  SampathIcons.transaction: 'SampathIcons.transaction',
  SampathIcons.transfer: 'SampathIcons.transfer',
  SampathIcons.paypal: 'SampathIcons.paypal',
};

void main() {
  test('iconRef gives the field name for every entry', () {
    for (final e in _expected.entries) {
      expect(iconRef(e.key), e.value, reason: e.key.figmaName);
    }
  });

  test('the map covers every registry entry', () {
    final missing = [
      for (final icon in [...SampathIcons.utility, ...SampathIcons.assets])
        if (!_expected.containsKey(icon)) icon.figmaName,
    ];
    expect(missing, isEmpty, reason: 'Add these to _expected');
  });
}
