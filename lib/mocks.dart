import 'package:places/domain/sight.dart';

// Моковые данные приложения
final List<Sight> mocks = [
  Sight(
    name: 'Поволжский музей железнодорожной техники',
    type: 'Музей',
    lat: 53.22456141251903,
    lon: 50.29576692495407,
    url: 'https://img.tourister.ru/files/1/5/8/3/9/3/7/5/original.jpg',
    details:
        'Музей расположен на бывшем полигоне железнодорожных войск недалеко от станции Безымянка, куда в годы Великой Отечественной войны прибывали поезда с эвакуированными предприятиями и гражданами из западных районов страны.',
  ),
  Sight(
    name: 'Жигулевский пивоваренный завод',
    type: 'Завод',
    lat: 53.201333198228916,
    lon: 50.09899703267132,
    url: 'https://img.tourister.ru/files/2/7/7/5/4/3/4/3/original.jpg',
    details:
        'Известный по всей стране еще с советских времен сорт светлого пива «Жигулевское» появился в Самаре, где действует Жигулевский пивоваренный завод. Сейчас это не просто успешное предприятие, но и весьма популярная достопримечательность. Многие люди, приезжающие в Самару, стараются заглянуть на пивоварню, чтобы отведать ее продукцию и взять с собой пару-тройку «сувениров» для друзей и родственников..',
  ),
  Sight(
    name: 'Набережная в Самаре',
    type: 'Набережная',
    lat: 53.20669963821328,
    lon: 50.109135955722074,
    url: 'https://img.tourister.ru/files/1/9/3/6/1/0/6/4/original.jpg',
    details:
        'Набережная в Самаре протяженностью 5 км заслужила славу лучшей в Поволжье благодаря архитектурно-художественным решениям, гармонично соединившим достоинства пляжа, променада и локаций для активного отдыха и спорта. Жители и гости города приходят сюда подышать чистым речным воздухом и полюбоваться живописными панорамами великой русской реки.',
  ),
  Sight(
    name: 'Театр оперы и балета в Самаре',
    type: 'Театр',
    lat: 53.19539868552996,
    lon: 50.10307901339163,
    url: 'https://img.tourister.ru/files/2/1/2/8/5/6/0/4/original.jpg',
    details:
        'Самарский академический театр оперы и балета начал свою историю в 1931 году и с тех пор заслужил репутацию одного из выдающихся театров России, уделяющих особое внимание музыкальному сопровождению постановок. Руководителями театра и членами труппы были многие известные талантливые артисты. Почетное звание академического присвоили театру спустя половину столетия, в 1982 году, после окончания блестящих гастролей в Москве. Два из одиннадцати спектаклей, привезенных в Москву, были отмечены премией.',
  ),
  Sight(
    name: 'Музей «Самара Космическая»',
    type: 'Музей',
    lat: 53.21263835636403,
    lon: 50.145321305488125,
    url: 'https://img.tourister.ru/files/2/3/9/9/7/0/2/9/original.jpg',
    details:
        'К 45-ой годовщине космического машиностроения Самары 12 апреля 2001 года был открыт уникальный музейно-выставочный комплекс, получивший название «Самара Космическая». На открытии присутствовал генеральный конструктор «ЦСКБ-Прогресс» Дмитрий Козлов. Сегодня этот музей является одним из самых популярных культурных объектов города, несмотря на свой молодой возраст. Туристические компании активно включают комплекс в свои экскурсионные маршруты.',
  ),
  Sight(
    name: 'Самарская Лука',
    type: 'Парк',
    lat: 53.34196614136561,
    lon: 49.36655132689169,
    url: 'https://img.tourister.ru/files/1/9/6/1/2/8/2/0/original.jpg',
    details:
        'В излучине Волги близ Усинского залива, выдающейся части Куйбышевского водохранилища, расположена эта уникальная по своей красоте местность — Самарская Лука. Неповторимый холмистый рельеф, блеск вод огибающей их красавицы Волги, мягкий, целебный микроклимат, богатство растительного и животного мира — все это издавна привлекало сюда туристов и просто отдыхающих.',
  ),
  Sight(
    name: 'Музей Алабина в Самаре',
    type: 'Музей',
    lat: 53.19303363867338,
    lon: 50.10905018790644,
    url: 'https://img.tourister.ru/files/2/2/7/0/5/0/0/5/original.jpg',
    details:
        'Первый публичный музей не только Самары, но и Поволжья, появился благодаря Петру Алабину. На заседании городской думы в Самаре в 1880 году Алабин предложил построить здание, где вместе будут существовать библиотека и музей для широкой публики. Проект разработал тоже Петр Владимирович. К 1886 году Самарский городской музей начал свою работу. Имя П. В. Алабина музею присвоили в 1992 году, когда объединили краеведческий музей области и самарский музей Ленина в один с несколькими филиалами.',
  ),
  Sight(
    name: 'Загородный парк в Самаре',
    type: 'Парк',
    lat: 53.23225271134232,
    lon: 50.160502060576476,
    url: 'https://img.tourister.ru/files/1/9/2/4/3/5/9/7/original.jpg',
    details:
        'Загородный парк в Самаре, занимающий площадь более 42 га между набережной Волги и Ново-Садовой улицей, — самая большая садово-парковая территория в городе. Официальное название — Центральный парк культуры и отдыха им. Горького — используется крайне редко. Популярное место для проведения досуга открыто в будни с 11 до 18, в субботу и воскресенье — с 10 до 20, выходной — понедельник.',
  ),
  Sight(
    name: 'Бункер Сталина в Самаре',
    type: 'Музей',
    lat: 53.19695036276686,
    lon: 50.09773416183709,
    url: 'https://img.tourister.ru/files/1/5/8/2/1/9/4/6/original.jpg',
    details:
        'Бункер Сталина — рассекреченное и ставшее в 1990 году музеем секретное бомбоубежище Иосифа Сталина. Данный объект расположен в здании бывшего обкома КПСС (сейчас — Самарского государственного университета культуры). Существование объекта держалось в секрете около 48 лет. Сегодня это самый «брендовый» объект города. Он не имеет статуса музея, этим объясняется сокращенный режим посещения.',
  ),
  Sight(
    name: 'Дом-музей Фрунзе',
    type: 'Музей',
    lat: 53.19166899783122,
    lon: 50.09391998640153,
    url: 'https://i7.otzovik.com/2020/03/17/9651202/img/807390_34940389_b.jpeg',
    details:
        'В Самаре в доме № 114 по улице Фрунзе разместился Дом-музей Михаила Васильевича Фрунзе, революционера и прославленного советского военачальника. В качестве музея здание начало работать еще до Великой отечественной войны, с 23 февраля 1934 года. Дом, возведенный в конце XIX века, представляет собой памятник жилого зодчества. К 70-летию музея в 2004 году сотрудники подготовили новую выставку, где были использованы материалы, долгие годы лежавшие под грифом «секретно».',
  ),
];

final List<Sight> wantToVisitSights = [mocks[0], mocks[1], mocks[2]];
final List<Sight> visitedSights = [mocks[3], mocks[4], mocks[5]];

//final List<Sight> wantToVisitSights = [];
//final List<Sight> visitedSights = [];

/// Строковые константы приложения
class MockStrings {
  static const openingHours = 'закрыто до 09:00';
  static const scheduledDate = 'Запланировано на 12 окт. 2020';
  static const visitDate = 'Цель достигнута 12 окт. 2020';
}
