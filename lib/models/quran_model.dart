class QuranModel {
  final String arti;
  final String asma;
  final int ayat;
  final String nama;
  final String type;
  final int urut;
  final String audio;
  final int nomor;
  final int rukuk;
  final String keterangan;

  QuranModel({
    required this.arti,
    required this.asma,
    required this.ayat,
    required this.nama,
    required this.type,
    required this.urut,
    required this.audio,
    required this.nomor,
    required this.rukuk,
    required this.keterangan,
  });

  factory QuranModel.fromJson(Map<String, dynamic> json) {
    return QuranModel(
      arti: json['arti'] ?? '',
      asma: json['asma'] ?? '',
      ayat: int.parse(json['ayat'].toString()),
      nama: json['nama'] ?? '',
      type: json['type'] ?? '',
      urut: int.parse(json['urut'].toString()),
      audio: json['audio'] ?? '',
      nomor: int.parse(json['nomor'].toString()),
      rukuk: int.parse(json['rukuk'].toString()),
      keterangan: json['keterangan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arti': arti,
      'asma': asma,
      'ayat': ayat,
      'nama': nama,
      'type': type,
      'urut': urut,
      'audio': audio,
      'nomor': nomor,
      'rukuk': rukuk,
      'keterangan': keterangan,
    };
  }
}
