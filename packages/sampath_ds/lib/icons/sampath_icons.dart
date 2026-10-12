// The icon registry (DESIGN.md §6.2). Screens and components use these
// entries through `SampathIcon`, never iconoir_flutter or SvgPicture directly.
//
// Utility icons: only the Iconoir icons the Figma component file actually
// uses (scanned 12 Oct 2026, excluding pages under "🔒 Do not use"). Add an
// entry when a component needs a new one; to replace an Iconoir icon with a
// custom one, change its single entry here.
//
// Brand icons and partner logos: SVGs exported from the brand icon file
// (ztpSPR24LsEQl2L4OxUX3T, page "brand icon"). `NEW` is on hold (§10 #6).

import 'package:flutter/widgets.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

import 'sampath_icon_data.dart';

abstract final class SampathIcons {
  // Utility icons (Iconoir, recolored with fg-* tokens).
  static const arrowDownLeft = SampathUtilityIcon(
    'arrow-down-left',
    _arrowDownLeft,
  );
  static const arrowUp = SampathUtilityIcon('arrow-up', _arrowUp);
  static const arrowUpRight = SampathUtilityIcon(
    'arrow-up-right',
    _arrowUpRight,
  );
  static const bell = SampathUtilityIcon('bell', _bell);
  static const calendar = SampathUtilityIcon('calendar', _calendar);
  static const camera = SampathUtilityIcon('camera', _camera);
  static const cardNoAccess = SampathUtilityIcon(
    'card-no-access',
    _cardNoAccess,
  );
  static const chatBubble = SampathUtilityIcon('chat-bubble', _chatBubble);
  static const check = SampathUtilityIcon('check', _check);
  static const checkCircle = SampathUtilityIcon('check-circle', _checkCircle);
  static const checkCircleSolid = SampathUtilityIcon(
    'check-circle-solid',
    _checkCircleSolid,
  );
  static const clock = SampathUtilityIcon('clock', _clock);
  static const clockRotateRight = SampathUtilityIcon(
    'clock-rotate-right',
    _clockRotateRight,
  );
  static const coins = SampathUtilityIcon('coins', _coins);
  static const creditCard = SampathUtilityIcon('credit-card', _creditCard);
  static const dataTransferBoth = SampathUtilityIcon(
    'data-transfer-both',
    _dataTransferBoth,
  );
  static const download = SampathUtilityIcon('download', _download);
  static const editPencil = SampathUtilityIcon('edit-pencil', _editPencil);
  static const eye = SampathUtilityIcon('eye', _eye);
  static const eyeClosed = SampathUtilityIcon('eye-closed', _eyeClosed);
  static const fastArrowRight = SampathUtilityIcon(
    'fast-arrow-right',
    _fastArrowRight,
  );
  static const globe = SampathUtilityIcon('globe', _globe);
  static const graphUp = SampathUtilityIcon('graph-up', _graphUp);
  static const headsetHelp = SampathUtilityIcon('headset-help', _headsetHelp);
  static const homeSimple = SampathUtilityIcon('home-simple', _homeSimple);
  static const infoCircle = SampathUtilityIcon('info-circle', _infoCircle);
  static const lock = SampathUtilityIcon('lock', _lock);
  static const microphone = SampathUtilityIcon('microphone', _microphone);
  static const minus = SampathUtilityIcon('minus', _minus);
  static const moreHoriz = SampathUtilityIcon('more-horiz', _moreHoriz);
  static const navArrowDown = SampathUtilityIcon(
    'nav-arrow-down',
    _navArrowDown,
  );
  static const navArrowLeft = SampathUtilityIcon(
    'nav-arrow-left',
    _navArrowLeft,
  );
  static const navArrowRight = SampathUtilityIcon(
    'nav-arrow-right',
    _navArrowRight,
  );
  static const navArrowUp = SampathUtilityIcon('nav-arrow-up', _navArrowUp);
  static const plus = SampathUtilityIcon('plus', _plus);
  static const refreshDouble = SampathUtilityIcon(
    'refresh-double',
    _refreshDouble,
  );
  static const scanQrCode = SampathUtilityIcon('scan-qr-code', _scanQrCode);
  static const search = SampathUtilityIcon('search', _search);
  static const settings = SampathUtilityIcon('settings', _settings);
  static const shareAndroid = SampathUtilityIcon(
    'share-android',
    _shareAndroid,
  );
  static const star = SampathUtilityIcon('star', _star);
  static const trash = SampathUtilityIcon('trash', _trash);
  static const upload = SampathUtilityIcon('upload', _upload);
  static const user = SampathUtilityIcon('user', _user);
  static const wallet = SampathUtilityIcon('wallet', _wallet);
  static const warningTriangle = SampathUtilityIcon(
    'warning-triangle',
    _warningTriangle,
  );
  static const xmark = SampathUtilityIcon('xmark', _xmark);

  /// Figma's older Iconoir `xmark-solid`, renamed `xmark-circle-solid` in
  /// current Iconoir (DESIGN.md §10 #17).
  static const xmarkSolid = SampathUtilityIcon('xmark-solid', _xmarkSolid);

  // Brand icons (never recolored).
  static const assistant = SampathAssetIcon(
    'assistant',
    SampathAssetIconKind.brand,
    'assets/icons/brand/assistant.svg',
  );
  static const insights = SampathAssetIcon(
    'insights',
    SampathAssetIconKind.brand,
    'assets/icons/brand/insights.svg',
  );
  static const transaction = SampathAssetIcon(
    'transaction',
    SampathAssetIconKind.brand,
    'assets/icons/brand/transaction.svg',
  );
  static const transfer = SampathAssetIcon(
    'transfer',
    SampathAssetIconKind.brand,
    'assets/icons/brand/transfer.svg',
  );

  // Partner logos (never recolored or redrawn).
  static const paypal = SampathAssetIcon(
    'paypal',
    SampathAssetIconKind.partner,
    'assets/icons/partner/paypal.svg',
  );

  /// Every utility icon, in Figma-name order (for catalogues).
  static const List<SampathUtilityIcon> utility = [
    arrowDownLeft,
    arrowUp,
    arrowUpRight,
    bell,
    calendar,
    camera,
    cardNoAccess,
    chatBubble,
    check,
    checkCircle,
    checkCircleSolid,
    clock,
    clockRotateRight,
    coins,
    creditCard,
    dataTransferBoth,
    download,
    editPencil,
    eye,
    eyeClosed,
    fastArrowRight,
    globe,
    graphUp,
    headsetHelp,
    homeSimple,
    infoCircle,
    lock,
    microphone,
    minus,
    moreHoriz,
    navArrowDown,
    navArrowLeft,
    navArrowRight,
    navArrowUp,
    plus,
    refreshDouble,
    scanQrCode,
    search,
    settings,
    shareAndroid,
    star,
    trash,
    upload,
    user,
    wallet,
    warningTriangle,
    xmark,
    xmarkSolid,
  ];

  /// Brand icons and partner logos (for catalogues).
  static const List<SampathAssetIcon> assets = [
    assistant,
    insights,
    transaction,
    transfer,
    paypal,
  ];
}

Widget _arrowDownLeft(Color c, double s) =>
    iconoir.ArrowDownLeft(color: c, width: s, height: s);
Widget _arrowUp(Color c, double s) =>
    iconoir.ArrowUp(color: c, width: s, height: s);
Widget _arrowUpRight(Color c, double s) =>
    iconoir.ArrowUpRight(color: c, width: s, height: s);
Widget _bell(Color c, double s) => iconoir.Bell(color: c, width: s, height: s);
Widget _calendar(Color c, double s) =>
    iconoir.Calendar(color: c, width: s, height: s);
Widget _camera(Color c, double s) =>
    iconoir.Camera(color: c, width: s, height: s);
Widget _cardNoAccess(Color c, double s) =>
    iconoir.CardNoAccess(color: c, width: s, height: s);
Widget _chatBubble(Color c, double s) =>
    iconoir.ChatBubble(color: c, width: s, height: s);
Widget _check(Color c, double s) =>
    iconoir.Check(color: c, width: s, height: s);
Widget _checkCircle(Color c, double s) =>
    iconoir.CheckCircle(color: c, width: s, height: s);
Widget _checkCircleSolid(Color c, double s) =>
    iconoir.CheckCircleSolid(color: c, width: s, height: s);
Widget _clock(Color c, double s) =>
    iconoir.Clock(color: c, width: s, height: s);
Widget _clockRotateRight(Color c, double s) =>
    iconoir.ClockRotateRight(color: c, width: s, height: s);
Widget _coins(Color c, double s) =>
    iconoir.Coins(color: c, width: s, height: s);
Widget _creditCard(Color c, double s) =>
    iconoir.CreditCard(color: c, width: s, height: s);
Widget _dataTransferBoth(Color c, double s) =>
    iconoir.DataTransferBoth(color: c, width: s, height: s);
Widget _download(Color c, double s) =>
    iconoir.Download(color: c, width: s, height: s);
Widget _editPencil(Color c, double s) =>
    iconoir.EditPencil(color: c, width: s, height: s);
Widget _eye(Color c, double s) => iconoir.Eye(color: c, width: s, height: s);
Widget _eyeClosed(Color c, double s) =>
    iconoir.EyeClosed(color: c, width: s, height: s);
Widget _fastArrowRight(Color c, double s) =>
    iconoir.FastArrowRight(color: c, width: s, height: s);
Widget _globe(Color c, double s) =>
    iconoir.Globe(color: c, width: s, height: s);
Widget _graphUp(Color c, double s) =>
    iconoir.GraphUp(color: c, width: s, height: s);
Widget _headsetHelp(Color c, double s) =>
    iconoir.HeadsetHelp(color: c, width: s, height: s);
Widget _homeSimple(Color c, double s) =>
    iconoir.HomeSimple(color: c, width: s, height: s);
Widget _infoCircle(Color c, double s) =>
    iconoir.InfoCircle(color: c, width: s, height: s);
Widget _lock(Color c, double s) => iconoir.Lock(color: c, width: s, height: s);
Widget _microphone(Color c, double s) =>
    iconoir.Microphone(color: c, width: s, height: s);
Widget _minus(Color c, double s) =>
    iconoir.Minus(color: c, width: s, height: s);
Widget _moreHoriz(Color c, double s) =>
    iconoir.MoreHoriz(color: c, width: s, height: s);
Widget _navArrowDown(Color c, double s) =>
    iconoir.NavArrowDown(color: c, width: s, height: s);
Widget _navArrowLeft(Color c, double s) =>
    iconoir.NavArrowLeft(color: c, width: s, height: s);
Widget _navArrowRight(Color c, double s) =>
    iconoir.NavArrowRight(color: c, width: s, height: s);
Widget _navArrowUp(Color c, double s) =>
    iconoir.NavArrowUp(color: c, width: s, height: s);
Widget _plus(Color c, double s) => iconoir.Plus(color: c, width: s, height: s);
Widget _refreshDouble(Color c, double s) =>
    iconoir.RefreshDouble(color: c, width: s, height: s);
Widget _scanQrCode(Color c, double s) =>
    iconoir.ScanQrCode(color: c, width: s, height: s);
Widget _search(Color c, double s) =>
    iconoir.Search(color: c, width: s, height: s);
Widget _settings(Color c, double s) =>
    iconoir.Settings(color: c, width: s, height: s);
Widget _shareAndroid(Color c, double s) =>
    iconoir.ShareAndroid(color: c, width: s, height: s);
Widget _star(Color c, double s) => iconoir.Star(color: c, width: s, height: s);
Widget _trash(Color c, double s) =>
    iconoir.Trash(color: c, width: s, height: s);
Widget _upload(Color c, double s) =>
    iconoir.Upload(color: c, width: s, height: s);
Widget _user(Color c, double s) => iconoir.User(color: c, width: s, height: s);
Widget _wallet(Color c, double s) =>
    iconoir.Wallet(color: c, width: s, height: s);
Widget _warningTriangle(Color c, double s) =>
    iconoir.WarningTriangle(color: c, width: s, height: s);
Widget _xmark(Color c, double s) =>
    iconoir.Xmark(color: c, width: s, height: s);
Widget _xmarkSolid(Color c, double s) =>
    iconoir.XmarkCircleSolid(color: c, width: s, height: s);
