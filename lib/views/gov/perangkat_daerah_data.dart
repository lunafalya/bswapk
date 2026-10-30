/// Data pimpinan dan perangkat daerah Kota Bogor.
/// Dipisah dari view supaya file tampilan tetap ringkas.

class Official {
  const Official(this.name, this.title, this.imagePath);

  final String name;
  final String title;
  final String imagePath;
}

class AgencyContact {
  const AgencyContact({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.websiteUrl,
    required this.imagePath,
  });

  final String name;
  final String email;
  final String phone;
  final String address;
  final String websiteUrl;
  final String imagePath;

  /// Beberapa dinas punya lebih dari satu email (dipisah koma).
  List<String> get emails =>
      email.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  bool get hasWebsite => websiteUrl.trim().isNotEmpty;

  /// Nomor telepon tanpa spasi/tanda kurung, untuk link `tel:`.
  String get phoneDialable => phone.replaceAll(RegExp(r'[^0-9+]'), '');
}

const officials = [
  Official('Dedie A Rachim', 'Walikota Bogor', 'lib/assets/images/dedie.jpg'),
  Official(
    'Jenal Mutaqin',
    'Wakil Walikota Bogor',
    'lib/assets/images/jenal.jpg',
  ),
];

const agencies = [
  AgencyContact(
    name: 'Sekretariat Daerah',
    email: 'setda@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: 'https://setda.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/setda.jpg',
  ),
  AgencyContact(
    name: 'Sekretariat DPRD',
    email: 'setwan@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Pemuda No.25, RT.01/RW.06, Tanah Sareal',
    websiteUrl: 'https://setwan.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/bogor.png',
  ),
  AgencyContact(
    name: 'Inspektorat Daerah',
    email: 'inspektorat@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Raya Pajajaran No.5, RT.02/RW.04, Baranangsiang',
    websiteUrl: 'https://inspektorat.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/inspektorat.jpg',
  ),
  AgencyContact(
    name: 'Dinas Sosial',
    email: 'dinsos@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Merdeka No.142, RT.03/RW.05, Ciwaringin',
    websiteUrl: 'https://dinsos.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dinsos.png',
  ),
  AgencyContact(
    name: 'Dinas Pemberdayaan Perempuan dan Perlindungan Anak',
    email: 'dppa@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ciwaringin No.99, RT.01/RW.09, Ciwaringin',
    websiteUrl: 'https://dppa.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dppa.jpg',
  ),
  AgencyContact(
    name: 'Dinas Kesehatan',
    email: 'dinkes@kotabogor.go.id',
    phone: '(0251) 8331753',
    address:
        'Jalan R.M. Tirto Adhi Soerjo No.3, RT.02/RW.02, '
        'Tanah Sareal, Kota Bogor, Jawa Barat 16161',
    websiteUrl: 'https://dinkes.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dinkes.jpg',
  ),
  AgencyContact(
    name: 'Dinas Pendidikan',
    email: 'disdik@kotabogor.go.id',
    phone: '(0251) 8321075',
    address:
        'Jalan Pangeran Sogiri No.7, Tanah Baru, Bogor Utara, '
        'Kota Bogor, Jawa Barat 16154',
    websiteUrl: 'https://disdik.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/disdik.jpg',
  ),
  AgencyContact(
    name: 'Dinas Perhubungan',
    email: 'dishub@kotabogor.go.id',
    phone: '(0251) 8324021',
    address:
        'Jalan Raya Tajur No.5, Bogor Timur, Kota Bogor, '
        'Jawa Barat 16144',
    websiteUrl: 'https://dishub.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dishub.png',
  ),
  AgencyContact(
    name: 'Dinas Lingkungan Hidup',
    email: 'dlh@kotabogor.go.id',
    phone: '(0251) 8324021',
    address:
        'Jalan Raya Tajur No.5, Bogor Timur, Kota Bogor, '
        'Jawa Barat 16144',
    websiteUrl: 'https://dlh.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dlh.png',
  ),
  AgencyContact(
    name: 'Dinas Komunikasi dan Informatika',
    email: 'kominfo@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: 'https://kominfo.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/kominfo.webp',
  ),
  AgencyContact(
    name: 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu',
    email: 'dpmptsp@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Kapten Muslihat No.21, RT.01/RW.01, Pabaton',
    websiteUrl: 'https://perizinan.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dpmptsp.png',
  ),
  AgencyContact(
    name: 'Dinas Pemuda dan Olahraga',
    email: 'dispora@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Pemuda No.4, RT.04/RW.01, Tanah Sareal',
    websiteUrl: 'https://perizinan.kotabogor.go.id',
    imagePath: 'lib/assets/images/pd/dispora.jpg',
  ),
  AgencyContact(
    name: 'Dinas Pariwisata dan Kebudayaan Kota Bogor',
    email: 'disbudpar@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jalan Pandu Raya No. 45, Tegal Gundil',
    websiteUrl: 'https://disparbud.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/dispudbar.jpg',
  ),
  AgencyContact(
    name: 'Dinas Pemadam Kebakaran dan Penyelamatan',
    email: 'dpkp@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Raya Pajajaran No.01 raya, RT.07/RW.02, Sukasari',
    websiteUrl: 'https://damkar.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/dpkp.jpg',
  ),
  AgencyContact(
    name: 'Satuan Polisi Pamong Praja Kota Bogor',
    email: 'satpolpp@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Raya Pajajaran No.121, RT.04/RW.03, Bantarjati',
    websiteUrl: 'https://satpolpp.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/satpolpp.jpeg',
  ),
  AgencyContact(
    name: 'Dinas Pekerjaan Umum dan Penataan Ruang Kota Bogor',
    email: 'dpupr@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jalan Pool Bina Marga No.2, Tanah Sereal, RT.02/RW.01',
    websiteUrl: 'https://dpupr.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/bogor.png',
  ),
  AgencyContact(
    name: 'Dinas Arsip dan Perpustakaan Kota Bogor',
    email: 'diskarpus@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'JL Medika 1A, No. 2, Perum Menteng Asri, RT.02/RW.20',
    websiteUrl: 'https://diarpus.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/diskarpus.jpg',
  ),
  AgencyContact(
    name: 'Dinas Tenaga Kerja Kota Bogor',
    email: 'disnakertrans@kotabogor.go.id, disnakersostrans@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. DR. Sumeru No.33, RT.01/RW.02, Menteng',
    websiteUrl: 'https://disnaker.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/disnaker.jpg',
  ),
  AgencyContact(
    name: 'Dinas Kependudukan dan Pencatatan Sipil Kota Bogor',
    email: 'disdukcapil@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Achmad Adnawijaya No.45A, RT.01/RW.16, Tegal Gundil',
    websiteUrl: 'https://disdukcapil.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/dukcapil.png',
  ),
  AgencyContact(
    name: 'Dinas Pengendalian Penduduk dan Keluarga Berencana Kota Bogor',
    email: 'dppkb@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Senam No.1, RT.04/RW.02, Tanah Sareal',
    websiteUrl: 'https://dppkb.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/dppkb.jpg',
  ),
  AgencyContact(
    name: 'Dinas Koperasi, Usaha Kecil, dan Menengah, Perdagangan dan Perindustrian Kota Bogor',
    email: 'dinkumkmdagin@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Dadali No.4, RT.03/RW.06, Tanah Sareal',
    websiteUrl: 'https://dinkumkmdagin.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/dinkukmdagin.jpg',
  ),
  AgencyContact(
    name: 'Dinas Perumahan dan Pemukiman Kota Bogor',
    email: 'disperumkim@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Pengadilan No.8a, RT.03/RW.01, Pabaton',
    websiteUrl: 'https://disperumkim.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/disperumkim.jpg',
  ),
  AgencyContact(
    name: 'Badan Perencanaan Pembangunan Daerah Kota Bogor',
    email: 'bapperida@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Kapten Muslihat No.21, RT.01/RW.01, Pabaton',
    websiteUrl: 'https://bapperida.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/bapperida.jpg',
  ),
  AgencyContact(
    name: 'Badan Kepegawaian dan Pengembangan Sumber Daya Manusia Kota Bogor',
    email: 'bkpsdm@kotabogor.go.id, bkpsda@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Julang 1 No.7A, RT.02/RW.4, Tanah Sareal',
    websiteUrl: 'https://bkpsdm.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/bkpsdm.jpg',
  ),
  AgencyContact(
    name: 'Badan Keuangan dan Aset Daerah Kota Bogor',
    email: 'bkad@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Pemuda No.31, RT.01/RW.06, Tanah Sareal',
    websiteUrl: 'https://bkad.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/bkad.jpg',
  ),
  AgencyContact(
    name: 'Badan Pendapatan Daerah Kota Bogor',
    email: 'bapenda@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Pemuda No.31, RT.01/RW.06, Tanah Sareal',
    websiteUrl: 'https://bapenda.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/bapenda.jpg',
  ),
  AgencyContact(
    name: 'Badan Kesatuan Bangsa dan Politik Kota Bogor',
    email: 'kesbangpol@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Kesehatan No.2, RT.02/RW.02, Tanah Sareal',
    websiteUrl: 'https://kesbangpol.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kesbangpol.jpg',
  ),
  AgencyContact(
    name: 'Badan Penanggulangan Bencana Daerah Kota Bogor',
    email: 'bpbd@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Pool Bina Marga No.2, RT.02/RW.01, Kayu Manis',
    websiteUrl: 'https://bpbd.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/bpbd.jpg',
  ),
  AgencyContact(
    name: 'RSUD Kota Bogor',
    email: 'rsud@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. DR. Sumeru No.120, RT.03/RW.20, Menteng',
    websiteUrl: 'https://rsud.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/rsud.jpg',
  ),
  AgencyContact(
    name: 'Kecamatan Bogor Utara Kota Bogor',
    email: 'kec.bout@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Gagalur II No. 2',
    websiteUrl: 'https://kecbogorutara.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kecbogorutara.jpg',
  ),
  AgencyContact(
    name: 'Kecamatan Bogor Selatan Kota Bogor',
    email: 'kec.bosel@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Layungsari III No.41',
    websiteUrl: 'https://kecbogorselatan.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kecbogorselatan.jpg',
  ),
  AgencyContact(
    name: 'Kecamatan Bogor Timur Kota Bogor',
    email: 'kec.botim@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Raya Pajajaran No.16, Baranangsiang',
    websiteUrl: 'https://kecbogortimur.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kecbogortimur.jpg',
  ),
  AgencyContact(
    name: 'Kecamatan Bogor Barat Kota Bogor',
    email: 'kec.bobar@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. KH. TB. M. FALAK No.319, Loji',
    websiteUrl: 'https://kecbogorbarat.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kecbogorbarat.jpg',
  ),
  AgencyContact(
    name: 'Kecamatan Bogor Tengah Kota Bogor',
    email: 'kec.boteng@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Kantin No. 02',
    websiteUrl: 'https://kecbogortengah.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kecbogortengah.jpg',
  ),
  AgencyContact(
    name: 'Kecamatan Tanah Sareal Kota Bogor',
    email: 'kec.tansar@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jalan Kebon Pedes No. 20',
    websiteUrl: 'https://kectanahsareal.kotabogor.go.id/',
    imagePath: 'lib/assets/images/pd/kectanahsareal.jpg',
  ),
  AgencyContact(
    name: 'Bagian Administrasi Pembangunan',
    email: 'bag.adalbang@kotabogor.go.id, bag.adbang@kotabogor.go.id, bag.dalprog@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_adalbang.jpg',
  ),
  AgencyContact(
    name: 'Bagian Kesejahteraan Masyarakat',
    email: 'bag.kesra@kotabogor.go.id, bag.adkesra@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_kesra.jpg',
  ),
  AgencyContact(
    name: 'Bagian Perekonomian',
    email: 'bag.ekon@kotabogor.go.id, bag.ekonomi@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_ekon.jpg',
  ),
  AgencyContact(
    name: 'Bagian Hukum dan HAM',
    email: 'bag.huk@kotabogor.go.id, bag.hukham@kotabogor.go.id, bag.hukum@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_huk.jpg',
  ),
  AgencyContact(
    name: 'Bagian Protokol dan Komunikasi Pimpinan',
    email: 'bag.humas@kotabogor.go.id, bag.humpro@kotabogor.go.id, bag.prokum@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_humas.jpg',
  ),
  AgencyContact(
    name: 'Bagian Organisasi',
    email: 'bag.org@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_org.jpg',
  ),
  AgencyContact(
    name: 'Bagian Pemerintahan',
    email: 'bag.pem@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_pem.jpg',
  ),
  AgencyContact(
    name: 'Bagian Umum',
    email: 'bag.umum@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_umum.jpg',
  ),
  AgencyContact(
    name: 'Bagian Pengadaan Barang',
    email: 'bag.pbj@kotabogor.go.id',
    phone: '(0251) 8324021',
    address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
    websiteUrl: '',
    imagePath: 'lib/assets/images/pd/bag_pbj.jpg',
  ),
];
