-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 08 Kas 2019, 20:13:45
-- Sunucu sürümü: 10.4.6-MariaDB
-- PHP Sürümü: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `mandalina`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `isAdminActive` bit(1) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `admins`
--

INSERT INTO `admins` (`id`, `name`, `image`, `isAdminActive`, `username`, `password`) VALUES
(1, 'Casablanca', 'http://pm1.narvii.com/6928/e8604d40465388042000aa446e71846281bc3635r1-376-391v2_00.jpg', b'1', 'casablanca98', 'casablanca78'),
(2, 'Toronto', 'https://www.dizifilm.com/wp-content/uploads/2018/04/large.jpg', b'1', 'toronto98', 'toronto10'),
(3, 'Barcelona', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxIQEBUSEhIQFRUQEBAVFRUWFRAVEBAVFRUWFhUVFRUYHSggGBolGxUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OFxAQGC0dHR0rLSstKysrLS0rLSstLS0tLS0tLS0tKy0tLS0rKy0rLS0tLS0tLS0tNzctLTcrNzcrLf/AABEIAKgBKwMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAAAAQIFAwQGBwj/xAA8EAABAwIDBQUGBAUEAwAAAAABAAIRAwQSITEFBkFRYRMicYGRBzKhsdHwQnLB4RQjUmLxgoOSojNTsv/EABgBAQEBAQEAAAAAAAAAAAAAAAABAgME/8QAHxEBAQACAgMBAQEAAAAAAAAAAAECESExAxJBUWEy/9oADAMBAAIRAxEAPwDzFNIJrTiaEBMIBMICaATSTQMKSipIBMIQqK3adQ4o4NGQ68yqtxM5/orPaDYPPitINJ1iPP7KxXSdMLx1+CQp9VtYeRPlCTqRH9Sitc0vBHZEftms2E9fXJIsP9vyPwVGLxREeH3osuA+PzUm05QO3fHDOMjJGE8Dlp4/4V9ZPaARlIMkQBizwkOaTAB5jSZzBKqbZuF0wDHDmOIKubqzAw1GkmYji7A4H3jzbpPEYeqmzS1p24cAXxgABiCQ5oMEk5wQcpjKBECAez2du2Qe0pvcwNaCxpzfTMktOLQiZHPIZmM+b3bc17S1zR3ajSwZYWteA14A8cJjovRt0Q5tMsf3xTbDXdANJ48B6clNbS8NHd+tjruLh3eLDOQiHSDrzK5/2g7sMoTcUYDC4NewGQ0nRw6HL1HWLStXdZXbspa9xPgCeHVdBtykytagThxsc0iDHg7LQA5eA0JVwZzn14mQorZvbR1J2F0HKQ4SWPHAtKwLqwihCEUIQmgEBCaIaEJhAkShOEFYmkmsqaYSTCBhNIJhA0IQgkhJNBJMKKkFRp3kYvJaVZkcVu3Yzlazm81zrrOmKizMc/kugtLYFuip7ZneXRWeizk3GnVtGnLCPT9Vq1bAK7LFiq0clnbelEdn9VJtl5qzdSSaxPap6tJtthIMT9FY2bXPAbAEfEZR5jPyQGrb2ZdCnVDnZga89E2erq9ytkB1SSJAGc6Z4TlGui9Y2NZtbTwkDIEQNOUrzXcmo1tKpWD5HaHXJzRnGfhHgvTtnVNCIIc0HXmuuM4cspy5jfXZrSwPIzaQNM8sslX7YdhtWuOeHD7uU4u7i65Rl+q6/eZgNBziJwwTHRcde1sNq2GgtNSmMzIHeyz4HPLxUvbFeV7Rq4qr4JI7R8DgJJJgDLUlapVhtq2DKsiMNUY2kaZzI6ZzlwkLQK6RhBCaFVJNCEDQhShEIJpoQCE0IKpMITCyoQhNAwmopoJICEIGmkmEDCairzZ9rTwBjx3qjZJ5T7o9FMsvWN4Ye1czWfLyOSbmLLtHZ7qNWIMHRRJWN75b1rhCm2Cruy++qq7enidkOSv7elhbn/hZybkNjc1lFMLGY4I7Q8x4SsNo1bda3YyspuhxWMXAlFApKBpLOKjVhLggvN1dpGkX04xBzHEDmRHDjp8F6tuveB1NkyCBzkDMjXzXjew6Dn1mluLumZHDkvUN3GODyYcBENGscOS6Y1zzdhftx0KgAmWPjryXmb9oY6T2lwa2i9rnEjJoxDUcxIA8AvSrl+Gg48mleL7cqdlTqg+/dPfUI4hmYpjw1PhC1l3HFQyKlt1oP9ab8v8A6DR5qvWxYvhxbwqNcw/6vd9HBp8lrrpHMFCaFQk4ThMIEAnCYCcIEUKUJQgSlCApQgp00JrKkmiE0CCYQE0DQgJoBNJCCdNskDmQPUro7SzLnueXNE5NngBkPkuetP8AyM/O35re2nclpZBIBbHoYXLy/Hp8E4q32hZdtROItc5hOYIMgZ+uq49w72Hqui2ftA4XAZggCOA6/NUlnTxVJ5uKziuU5XllbNa0ZZ81krvUyEqzYGkmFlWm6q4HRTDg5a1YVDoFOldNECo0j+791dLtmrWs5hVtRhBVu17T7jwQsdWjJ4KLtWgkJ5zxW0KE1Pyj4n7+KzC2z5Qg6P2eMms7kBzIM/c6r1iwoDhoOs5fc+i833DsgG1u8A9zAGTpz+i9I2DcswhpOeFo05DRdcHHPtl2y/Db1Ms8MeJJAHzXiG/Bp/x1UUjia3s2z/c1jQ4TxzB+K9o3tcWWld7dW0y4eIzHxhfPlRxJJJknMniStztxyRp6g8s/RY1IlJaZATSTVDTCE4QACkAkFJAQiEwhAAJwmEQqilTCQTWGjCcICEDCEIQCaSEDSQhBKm6HA8iD6FXFWzdVD2RkwlzTxg5kKkXU2daGNePxNE+IyPyXPyO/gvcaexKTOxcI7zHuxT6j4fJaOyWDGPzFXzCyKmFsOeJPWP8AKo7JhZUj+5c506XteFoGq1K1eJzBhbVQqprvLXeay016l5WcYJ7NucOjFnwkcB6rSdcOL8PatcJHeLA0RxKv6ddpGYmfMKuvWU+A+C3LGLjf1pU74teQCCByESOiv7OqHNnWOWq52m0gyANfRWuziYKlakZ6lcCQ0EEkZ5IvNqMa7jijMDh4rBRpF1QACZcq6+t4rOBBkOd0nNJCre13jIya4tmNWug+BC6Xd3bDn1ABVIM/hM5zoQuTs9lglpxQBEB2YHl5r1Xdjcel2bKtRznPlrwYAIA1EcjOhnmrOemcuO11vHWw7NrkmTgyOREwXAdRl8V4YV697UroU7VlHMdoSciOGgg6heROXfF5cu0EITC0gTQmEAFIJBNA0wkEwgkmkE0QwmkFJUUSaSYWGkkJIQSQlKEDQkhA0kIQJWGzNpmkC0jEwmY0LTzBVehLNrLZeHSWW0BVc4NbhAbxiTmsrmDkqnYJ77vy/qrdy4ZTV4ejG2zdZKQlYrq0BMrLbnNZqmYWW3P3NLDoStMuc7I/5V1c2y030g1Rpgp2hImFNj4yUxdOyAGRWKswzKo6f2e24ff05zDSSfRdjvX7NhXrOq0qrGGqScLgYxHWCOB8Fx3s8uxTvGT+MYR4k8V23tK23Wo16TKZwt7PtJ4PIcQR4CPitzUxu2ct3KSOJqbrXVtcNpVA3+oEOkOa0iSPUZZFex7Na1lJhBiQOcHLPXiuK2ZvA28eMbWmODoLmnjhPmutIDWggw0d4yZDQBJz5RKs1OY5Zb+uE9rt8DVpUgc2sxuHIEkMz8neoXnLlu7Z2i65r1KziSajyRP4W/hb5CB5LSJXWOF7RQhCqBNAQqJBMKKaCSYUFIIJBMFJNESCkohTVFCmoynKw0khJCBoSTQCEkwgaEkwgEIQgsdh++fy/qFbhUmy3htTPUgj9f0V2uOfbv4+kmFZmvlYSMkqboWXVlqxCpb58mFu3lUnJVrqZJU0tum5bVqcAOERx+q36tuxzZbmqHsyDnmsrLvAQA6JPktaT2X+7dqW3VIj/wBg8AOK6T2nbct676DKT2PdRFXGWkODcWABpcMplpyXG2Wybm7xdmHVA05jE0AeRIWy3c28xNb2bQX6TUpwfj0TV0lzm5/FpuPncxnGR8OHyXc793vY7Pqxk6o0Um/7h70f6MXoud9muzXMrVe1Y5rqYiHDOQSHRzUPa1f96jbg+6HVXDq7uM+Af6q+OMebJ524pEpEqK7POlKAoqQVQ0wkEwgaaSaAUggBShUATQApQiGFJIKUIOelNJAWWkkIQgaEk0AhCaACYQmgAEwEwFjr1hTEnyHNBE1jqDBDvSF0Gz70VG9RqOR+i5djxiPI6J29w6m7EOfkRyK5WOuN07KVClmVr2V4KjesZjiP2WwCsOsrDcGDpK0f4ipJLabSBwJMn4KxqEE5qDWAGQf3RpU1drVJzpt8OPyWJ98x/vU3A9MMFXdxgcM2g+S0/wCHpHhHmrtrbf3c3qdaOJptdhdk5pDSHcM85Gqt2739veUagmmylhZBkCHHvuPqfRae7m0W2jj+IE5NwtJc4wNTplJ8lpXodXu3d1odUqHus91snQQOH1TfDGUlvT2vYga8PrN0rPLh4GAD6BeNb4bS/ib2tVBluPCz8jO6PWJ816NvftQWGzm0mGKlZvZs/qaIGN/kDHi4Lx8rri82V50UoShNaZCaAmiGAmAgBSCACkEkwqGFIKIUwqiSaQUkAFIJBSQc2mkmFlowmkmEDQhNAJoCEDTATwrXrXYbp9+AU3okbDnACTwVfcOFQ5rWurlztJj5rU7Yys27bk03CzCcuCzVaZe0ZgT8StNlwQtltyCBOSi1lo3D2ObOX9w0P3yXQ2e0Q/umA6PXwVCXNI4HmsVWg9sEEeZ7zVLysy06mq3iFrVKhjitLZd+8d2sMjo/8Pg7l4q5NILOnSVTVazzxKyWFJ9So1gcAXuABOgk8VYVbMcFrNolpB5EHjwRrb0bdzcBzawfXqU3tbmA2YJ6yOEhbe7m57beu6s95dgc4tnWM9ev1VtuvtPHRaeJkeJhpMTw19Fa7Ru+xt6tYtLhRpOdAgEw3r4/Bb1Pjz5Z1wXtftoq0KoJh1HCdYEEkEcBqfgvPCvZ7XbBfdC2rsYW3FpRrMmC0EgtcyDqO78Vobb9n9CtLqH8l/ICaTvFvDyWpXLbydMK22nZXuzXYqlJmGYDi1lSk7z4T1hbdjvfRdAr2lEjQuY1s/8AE/VPeLz8UEJgL0O22fs67bNOm3/bc5j2+LVobR3KEE29Uk64KgAMdHD6LW2fefXGKQVhd7CuaXv0XwOIGJvq2VoBVZdhMBNNFIKQQmFUMKQUQpBBIJpJoOcTSTCy0EwhSCATaJWN9UDUrBWvcIkfupauq3qjQz3yG9NXenDzWq69j3R5lVzqxOZWCo8n6fVZ3a1I2697iMkkn1+K1n1pWKEwppWTtDpksbuuqaiqqIOSyNek0SovbCDbtG54uWg5lWbGDjmTr4qqoVAIkhbrHzoQs1KyV3AHInXj9VntNpPZkCCBwP6Hgqtz5JPMptqFFjoWbbPGn/2/ZRqbXL8hTHmT+iqGOEaqy2TZuq1WNpw4ucNSA0AZkuPAAAqaPavZN1rJtOoWtJhlCkHyZh7ocY/p7uEQOa6izuia1WkQCzsqbm5QTilrgendHqqzZFIAVDDSalw44gZ7QNa2DPIGQPyhaW8O3i14tLbvXDx33CP5FPier4mB/g7+PPu7UXtBc23urWuxzR2DeyIEy6JcAByAP/bouy2ddmtSbUBBlgMiYPI5rzvfTazMdKzyewFwqmQ6pTf3cNRriZkZ5HgSDquv2PcttrSmHPa4BsBwMtcJjLp08ln6vyLe/psq0nB7Q5rmkVGniDxC8J3h2OLe4qU2H3Hd08HNIDmk8siF7lsqqXE8j5iF4ptp/aXNYtxFprVMBOcsxHD5REKZN+KbqssL59J8tc5jxyP3IXfbD32Y4hly0N0io2cI6uHBec7QtDroRxHBKwuC7uu94D/kFJdcxvLCXt75SIIDmuBBEgg5EKu2nsOhXH8ym3EfxDuvHmP1VL7OSGUD/MxAvJwGO5lmAM8l3IotdplPmF1nLyWaunlG8O7r7SHTipvJAdGbT/S7keqpV7ZdbPa9hY9ocx4gjgfoV5TvHsZ1pWLDJa7vU3f1N69RoVuN439VKYQhVtIKQUQmERIJpBNBzoUghCy0kAo3Bw8czwAlx8AhCzlWsYrn206iPEyfTRatWlH3BQhYlbOkcXGY9U30oQhaS9scIQhAwEEDmhCCLi3gUgeoKSEUyAUgCNChCqJtc4cFlZV5oQoNikMWnFdBsnYZqCngAfUrPe1rT7rQzCXPI/EMzrkMJmdEIWfqZXh7Bc7QFnbspU83tYGjSTpLj1JJ8yuE3eqVbe6fVrMfieSXPguBBM6ieiEJXCdOa/hX1Lky1xx1HEh0tc4EzM6zmvR929gMbTDKrqhHaB1MPghjpEjz0PkhCzO287xF7vPtAWljUewQcGBvQv7oPlMrxd16GMjUR95oQtZTbXj4VTbklxPzWZrjIdGY+KELN4dovtgbFubmm6vbXAa5jw17C403DFkwgxBBMjOMwr5m1NtWECow1W695pf/ANhmEkK26efL/Vi92P7T6Lu7cU30XaSJczz4hXO8tOjtGxc+3cyq+l324SCcoxtjX3ZMdE0Lpjds5TXLysoQhdFNMIQgkE0IQf/Z', b'1', 'barcelona98', 'pussymagnet31'),
(4, 'Istanbul', 'data:image/jpeg;base64,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', b'1', 'istanbul98', 'istanbulsupertun');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `episodes`
--

CREATE TABLE `episodes` (
  `id` int(11) NOT NULL,
  `url` varchar(5000) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `season` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `image` varchar(5000) CHARACTER SET utf8 DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `airtime` varchar(45) DEFAULT NULL,
  `movieID` int(11) DEFAULT NULL,
  `addedDate` datetime DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `episodes`
--

INSERT INTO `episodes` (`id`, `url`, `name`, `season`, `number`, `image`, `summary`, `airtime`, `movieID`, `addedDate`, `isDeleted`) VALUES
(1, '/movies/buny.mp4', 'Pilot', 1, 1, '/covers/26068.jpg', 'When a murder reunites former detective Carrie Wells with her old colleague and flame, she must utilize her rare ability to revisit her every memory to catch the killer.', '50', 1, NULL, NULL),
(2, '/movies/buny.mp4', 'Pilot 2', 1, 2, '/covers/26068.jpg', 'When a murder reunites former detective Carrie Wells with her old colleague and flame, she must utilize her rare ability to revisit her every memory to catch the killer.', '100', 1, NULL, NULL),
(3, '/movies/buny.mp4', 'Pilot 3', 1, 3, '/covers/26068.jpg', 'When a murder reunites former detective Carrie Wells with her old colleague and flame, she must utilize her rare ability to revisit her every memory to catch the killer.', '150', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `genres`
--

INSERT INTO `genres` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Anime'),
(3, 'Comedy'),
(4, 'Crime'),
(5, 'Drama'),
(6, 'Fantasy'),
(7, 'Horror'),
(8, 'Love'),
(9, 'Musical'),
(10, 'Mystery'),
(11, 'Sci-Fi'),
(12, 'Sport'),
(13, 'Documentary');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `movieID` int(11) DEFAULT NULL,
  `like` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `likes`
--

INSERT INTO `likes` (`id`, `movieID`, `like`) VALUES
(7, 4, 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `moviecasts`
--

CREATE TABLE `moviecasts` (
  `id` int(11) NOT NULL,
  `name` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `movieID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `moviecasts`
--

INSERT INTO `moviecasts` (`id`, `name`, `movieID`) VALUES
(1, 'Poppy Montgomery', 1),
(2, 'Poppy Montgomery', 2),
(3, 'Poppy Montgomery', 1),
(11, '5', 5),
(18, 'Tunjay', 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `moviegenres`
--

CREATE TABLE `moviegenres` (
  `id` int(11) NOT NULL,
  `movieID` int(11) DEFAULT NULL,
  `genreID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `moviegenres`
--

INSERT INTO `moviegenres` (`id`, `movieID`, `genreID`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 2),
(7, 6, 2),
(8, 7, 2),
(9, 8, 2),
(10, 9, 2),
(11, 10, 2),
(12, 11, 2),
(13, 12, 2),
(14, 13, 2),
(15, 14, 2),
(16, 15, 2),
(17, 16, 2),
(18, 17, 2),
(19, 18, 2),
(20, 19, 2),
(21, 20, 2),
(30, 20, 1),
(31, 4, 2),
(32, 5, 2),
(41, 3, 2),
(42, 3, 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `movies`
--

CREATE TABLE `movies` (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `image` text CHARACTER SET utf8 DEFAULT NULL,
  `year` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `description` text CHARACTER SET utf8 DEFAULT NULL,
  `movieType` int(11) DEFAULT NULL,
  `addedDate` datetime DEFAULT NULL,
  `rate` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `movieLink` text DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `movies`
--

INSERT INTO `movies` (`id`, `name`, `image`, `year`, `description`, `movieType`, `addedDate`, `rate`, `length`, `movieLink`, `isDeleted`) VALUES
(1, 'Deadpool', '/covers/26068.jpg', '2012-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 2, '2014-05-05 05:00:00', '10+', 0, NULL, b'0'),
(2, 'Unforgetten', '/covers/unforget.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 04:00:00', '16+', 120, '/movies/buny.mp4', b'0'),
(3, 'Deadpool 3', '/covers/26068.jpg', '2011-09-21', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2019-10-27 09:51:34', '18+', 398, '/movies/buny.mp4', b'0'),
(4, 'Deadpool 4', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2019-10-27 09:43:48', '0+', 0, '/movies/buny.mp4', b'0'),
(5, 'Deadpool 5', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2019-10-27 09:44:48', '0+', 0, '/movies/buny.mp4', b'0'),
(6, 'Deadpool 6', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '0+', 645, '/movies/buny.mp4', b'0'),
(7, 'Deadpool 7', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '0+', 255, '/movies/buny.mp4', b'0'),
(8, 'Deadpool 2', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 471, '/movies/buny.mp4', b'0'),
(9, 'Deadpool 8', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 64, '/movies/buny.mp4', b'0'),
(10, 'Deadpool 9', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 66, '/movies/buny.mp4', b'0'),
(11, 'Deadpool 10', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 127, '/movies/buny.mp4', b'1'),
(12, 'Deadpool 11', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 285, '/movies/buny.mp4', b'0'),
(13, 'Deadpool 12', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(14, 'Deadpool 13', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(15, 'Resad', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(16, 'Deadpool 14', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(17, 'Deadpool 15', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(18, 'Deadpool 16', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(19, 'Deadpool 17', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, '/movies/buny.mp4', b'0'),
(20, 'Deadpool 18', '/covers/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20', 155, '/movies/buny.mp4', b'0');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `movietypes`
--

CREATE TABLE `movietypes` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `movietypes`
--

INSERT INTO `movietypes` (`id`, `name`) VALUES
(1, 'Movie'),
(2, 'Series');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `suggestedmovies`
--

CREATE TABLE `suggestedmovies` (
  `id` int(11) NOT NULL,
  `movieID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `suggestedmovies`
--

INSERT INTO `suggestedmovies` (`id`, `movieID`) VALUES
(1, 1);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `episodes`
--
ALTER TABLE `episodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EpisodeMovieTable` (`movieID`);

--
-- Tablo için indeksler `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likeMovieID` (`movieID`);

--
-- Tablo için indeksler `moviecasts`
--
ALTER TABLE `moviecasts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CastMovieTable` (`movieID`);

--
-- Tablo için indeksler `moviegenres`
--
ALTER TABLE `moviegenres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `GenreTable` (`genreID`),
  ADD KEY `MovieTable` (`movieID`);

--
-- Tablo için indeksler `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `TypeMovie` (`movieType`);

--
-- Tablo için indeksler `movietypes`
--
ALTER TABLE `movietypes`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `suggestedmovies`
--
ALTER TABLE `suggestedmovies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suggestedMovie` (`movieID`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `episodes`
--
ALTER TABLE `episodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Tablo için AUTO_INCREMENT değeri `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `moviecasts`
--
ALTER TABLE `moviecasts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Tablo için AUTO_INCREMENT değeri `moviegenres`
--
ALTER TABLE `moviegenres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Tablo için AUTO_INCREMENT değeri `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Tablo için AUTO_INCREMENT değeri `movietypes`
--
ALTER TABLE `movietypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `episodes`
--
ALTER TABLE `episodes`
  ADD CONSTRAINT `EpisodeMovieTable` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likeMovieID` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `moviecasts`
--
ALTER TABLE `moviecasts`
  ADD CONSTRAINT `CastMovieTable` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `moviegenres`
--
ALTER TABLE `moviegenres`
  ADD CONSTRAINT `GenreTable` FOREIGN KEY (`genreID`) REFERENCES `genres` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `MovieTable` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `TypeMovie` FOREIGN KEY (`movieType`) REFERENCES `movietypes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `suggestedmovies`
--
ALTER TABLE `suggestedmovies`
  ADD CONSTRAINT `suggestedMovie` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
