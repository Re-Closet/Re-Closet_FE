import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreMarker {
  final String id;
  final LatLng position;

  const StoreMarker({required this.id, required this.position});
}

const List<StoreMarker> markerData = [
  StoreMarker(id: '아름다운 가게 영등포점', position: LatLng(37.5190968, 126.9059359)),
  StoreMarker(id: '아름다운가게 강남구청역점', position: LatLng(37.5163937, 127.0378848)),
  StoreMarker(id: '아름다운가게 강동구청역점', position: LatLng(37.5302527, 127.1229333)),
  StoreMarker(id: '아름다운가게 강서화곡점', position: LatLng(37.5441543, 126.838468)),
  StoreMarker(id: '아름다운가게 개봉점', position: LatLng(37.4970413, 126.8572128)),
  StoreMarker(id: '아름다운가게 관악자명점', position: LatLng(37.484608, 126.9373154)),
  StoreMarker(id: '아름다운가게 광진화양점', position: LatLng(37.548551, 127.068139)),
  StoreMarker(id: '아름다운가게 남성역점', position: LatLng(37.4831831, 126.9755662)),
  StoreMarker(id: '아름다운가게 노원공릉점', position: LatLng(37.6240241, 127.0731581)),
  StoreMarker(id: '아름다운가게 망우점', position: LatLng(37.5999814, 127.1027812)),
  StoreMarker(id: '아름다운가게 망원역점', position: LatLng(37.5553083, 126.9101247)),
  StoreMarker(id: '아름다운가게 목동점', position: LatLng(37.5367306, 126.8822117)),
  StoreMarker(id: '아름다운가게 방학점', position: LatLng(37.6554126, 127.0428503)),
  StoreMarker(id: '아름다운가게 삼선교점', position: LatLng(37.5885305, 127.0055957)),
  StoreMarker(id: '아름다운가게 상왕십리역점', position: LatLng(37.5657656, 127.0303176)),
  StoreMarker(id: '아름다운가게 서초점', position: LatLng(37.4930764, 127.0176044)),
  StoreMarker(id: '아름다운가게 송파가락점', position: LatLng(37.4948246, 127.1219274)),
  StoreMarker(id: '아름다운가게 송파점', position: LatLng(37.5033926, 127.1136014)),
  StoreMarker(id: '아름다운가게 숙대입구점', position: LatLng(37.5431183, 126.9728513)),
  StoreMarker(id: '아름다운가게 안국점', position: LatLng(37.5788203, 126.9849592)),
  StoreMarker(id: '아름다운가게 압구정점', position: LatLng(37.5273895, 127.030957)),
  StoreMarker(id: '아름다운가게 연신내점', position: LatLng(37.6201112, 126.9228324)),
  StoreMarker(id: '아름다운가게 미아점', position: LatLng(37.6305681, 127.0249447)),
];

const List<StoreMarker> goodwillMarkerData = [
  StoreMarker(id: '굿윌스토어 은평점', position: LatLng(37.5857257, 126.9112664)),
  StoreMarker(id: '굿윌스토어 밀알도봉점', position: LatLng(37.6554126, 127.0428503)),
  StoreMarker(id: '굿윌스토어 밀알송파점', position: LatLng(37.5003887, 127.1426933)),
  StoreMarker(id: '굿윌스토어 밀알양천점', position: LatLng(37.5252531, 126.8593364)),
  StoreMarker(id: '굿윌스토어 밀알강남세움점', position: LatLng(37.4870564, 127.106901)),
];

const List<StoreMarker> hmMarkerData = [
  StoreMarker(id: 'H&M 용산아이파크몰점', position: LatLng(37.533806, 126.958287)),
  StoreMarker(id: 'H&M 영등포타임스퀘어몰점', position: LatLng(37.5170751, 126.9033411)),
  StoreMarker(id: 'H&M 홍대점', position: LatLng(37.5546492, 126.9225199)),
  StoreMarker(id: 'H&M 가로수길점', position: LatLng(37.5210682, 127.03414)),
  StoreMarker(id: 'H&M 롯데백화점김포공항점', position: LatLng(37.5650592, 126.8029919)),
  StoreMarker(id: 'H&M 명동중앙길점', position: LatLng(37.5635469, 126.9851428)),
  StoreMarker(id: 'H&M 신도림현대디큐브점', position: LatLng(37.5085845, 126.8888977)),
  StoreMarker(id: 'H&M 마리오아울렛점', position: LatLng(37.4784556, 126.8850161)),
  StoreMarker(id: 'H&M 코엑스점', position: LatLng(37.5147697, 127.0632364)),
  StoreMarker(id: 'H&M 강남신세계점', position: LatLng(37.5043637, 127.0036211)),
  StoreMarker(id: 'H&M 잠실롯데월드몰점', position: LatLng(37.5133121, 127.1037107)),
  StoreMarker(id: 'H&M 롯데백화점 청량리점', position: LatLng(37.5809769, 127.0469926)),
];

const List<StoreMarker> akMarkerData = [
  StoreMarker(id: '아르켓 아이파크몰 용산', position: LatLng(37.529557, 126.9641567)),
  StoreMarker(id: '아르켓 더현대 서울', position: LatLng(37.526056, 126.9283112)),
  StoreMarker(id: '아르켓 가로수길', position: LatLng(37.5198694, 127.0232473)),
];

const List<StoreMarker> saMarkerData = [
  StoreMarker(id: '구세군희망나누미상계점', position: LatLng(37.6597835, 127.0691598)),
  StoreMarker(id: '구세군희망나누미 북아현점', position: LatLng(37.5624168, 126.9543856)),
  StoreMarker(id: '구세군희망나누미 종암점', position: LatLng(37.60034, 127.0352175)),
  StoreMarker(id: '구세군희망나누미 역촌점', position: LatLng(37.6047811, 126.9184584)),
  StoreMarker(id: '구세군희망나누미 월곡점', position: LatLng(37.6096128, 127.051668)),
  StoreMarker(id: '구세군희망나누미 구파발점', position: LatLng(37.636298, 126.9315055)),
  StoreMarker(id: '구세군희망나누미 솔밭공원점', position: LatLng(37.6456264, 127.0157045)),
  StoreMarker(id: '구세군희망나누미우이점', position: LatLng(37.6578392, 127.0134462)),
];
