-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 16 Eki 2019, 03:57:44
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
  `movieID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `episodes`
--

INSERT INTO `episodes` (`id`, `url`, `name`, `season`, `number`, `image`, `summary`, `airtime`, `movieID`) VALUES
(1, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4', 'Pilot', 1, 1, 'http://static.tvmaze.com/uploads/images/medium_landscape/39/99519.jpg', 'When a murder reunites former detective Carrie Wells with her old colleague and flame, she must utilize her rare ability to revisit her every memory to catch the killer.', '22:00', 1),
(2, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4', 'Pilot', 1, 1, 'http://static.tvmaze.com/uploads/images/medium_landscape/39/99519.jpg', 'When a murder reunites former detective Carrie Wells with her old colleague and flame, she must utilize her rare ability to revisit her every memory to catch the killer.', '22:00', 1),
(3, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4', 'Pilot', 1, 1, 'http://static.tvmaze.com/uploads/images/medium_landscape/39/99519.jpg', 'When a murder reunites former detective Carrie Wells with her old colleague and flame, she must utilize her rare ability to revisit her every memory to catch the killer.', '22:00', 1);

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
(12, 'Sport');

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
(3, 'Poppy Montgomery', 1);

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
(4, 3, 2),
(5, 4, 2),
(6, 5, 2),
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
(22, 21, 2);

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
  `movieLink` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `movies`
--

INSERT INTO `movies` (`id`, `name`, `image`, `year`, `description`, `movieType`, `addedDate`, `rate`, `length`, `movieLink`) VALUES
(1, 'Deadpool', 'https://wallpaperaccess.com/full/26068.jpg', '2012-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 2, '2014-05-05 05:00:00', '10+', 150, NULL),
(2, 'Unforgetten', 'https://images-na.ssl-images-amazon.com/images/I/51rLEGWeR4L._SY445_.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 04:00:00', '16+', 120, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(3, 'Deadpool', 'https://i.pinimg.com/originals/c3/51/35/c351353a8582356bb6a4a3824cc62bdd.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 06:00:00', '18+', 200, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(4, 'Deadpool', 'https://wallpaperaccess.com/full/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2015-05-05 05:00:00', '0+', 251, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(5, 'Deadpool', 'https://wallpaperaccess.com/full/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2017-05-05 05:00:00', '0+', 147, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(6, 'Deadpool', 'https://i.ytimg.com/vi/WRlGteWa1cY/maxresdefault.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '0+', 645, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(7, 'Deadpool', 'https://i.pinimg.com/originals/c3/51/35/c351353a8582356bb6a4a3824cc62bdd.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '0+', 255, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(8, 'Deadpool', 'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fscottmendelson%2Ffiles%2F2016%2F02%2Fdeadpool-SYB_2040_v076.1040_rgb-1200x675.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 471, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(9, 'Deadpool', 'https://i.pinimg.com/originals/c3/51/35/c351353a8582356bb6a4a3824cc62bdd.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 64, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(10, 'Deadpool', 'https://nerdist.com/wp-content/uploads/2019/01/venom-2018-movie-4k-8h-1.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 66, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(11, 'Deadpool', 'https://wallpaperaccess.com/full/26068.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '15+', 127, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(12, 'Deadpool', 'https://i.pinimg.com/originals/c3/51/35/c351353a8582356bb6a4a3824cc62bdd.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 285, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(13, 'Deadpool', 'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fscottmendelson%2Ffiles%2F2016%2F02%2Fdeadpool-SYB_2040_v076.1040_rgb-1200x675.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(14, 'Deadpool', 'https://m.media-amazon.com/images/M/MV5BYzE5MjY1ZDgtMTkyNC00MTMyLThhMjAtZGI5OTE1NzFlZGJjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(15, 'Resad', 'https://nerdist.com/wp-content/uploads/2019/01/venom-2018-movie-4k-8h-1.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(16, 'Deadpool', 'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fscottmendelson%2Ffiles%2F2016%2F02%2Fdeadpool-SYB_2040_v076.1040_rgb-1200x675.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(17, 'Deadpool', 'https://m.media-amazon.com/images/M/MV5BYzE5MjY1ZDgtMTkyNC00MTMyLThhMjAtZGI5OTE1NzFlZGJjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(18, 'Deadpool', 'https://nerdist.com/wp-content/uploads/2019/01/venom-2018-movie-4k-8h-1.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(19, 'Deadpool', 'https://m.media-amazon.com/images/M/MV5BYzE5MjY1ZDgtMTkyNC00MTMyLThhMjAtZGI5OTE1NzFlZGJjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20+', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(20, 'Deadpool', 'https://nerdist.com/wp-content/uploads/2019/01/venom-2018-movie-4k-8h-1.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'),
(21, 'Resad', 'https://m.media-amazon.com/images/M/MV5BYzE5MjY1ZDgtMTkyNC00MTMyLThhMjAtZGI5OTE1NzFlZGJjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg', '2011-09-20', 'Unforgettable follows Carrie Wells, an enigmatic former police detective with a rare condition that makes her memory so flawless that every place, every conversation, every moment of joy and every heartbreak is forever embedded in her mind. It\'s not just that she doesn\'t forget anything - she can\'t; except for one thing: the details that would help solve her sister\'s long-ago murder. Carrie has tried to put her past behind her, but she\'s unexpectedly reunited with her ex-boyfriend and partner, NYPD Detective Al Burns when she consults on a homicide case.', 1, '2014-05-05 05:00:00', '20', 155, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4');

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
(1, 'movie'),
(2, 'series');

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
-- Tablo için AUTO_INCREMENT değeri `episodes`
--
ALTER TABLE `episodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Tablo için AUTO_INCREMENT değeri `moviecasts`
--
ALTER TABLE `moviecasts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `moviegenres`
--
ALTER TABLE `moviegenres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Tablo için AUTO_INCREMENT değeri `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
-- Tablo kısıtlamaları `moviecasts`
--
ALTER TABLE `moviecasts`
  ADD CONSTRAINT `CastMovieTable` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `moviegenres`
--
ALTER TABLE `moviegenres`
  ADD CONSTRAINT `GenreTable` FOREIGN KEY (`genreID`) REFERENCES `genres` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `MovieTable` FOREIGN KEY (`movieID`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
