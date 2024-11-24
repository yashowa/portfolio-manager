-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 24 nov. 2024 à 22:17
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `portfolio`
--

-- --------------------------------------------------------

--
-- Structure de la table `cat_event`
--

DROP TABLE IF EXISTS `cat_event`;
CREATE TABLE IF NOT EXISTS `cat_event` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `id_lang` int NOT NULL DEFAULT '1',
  `color` varchar(7) NOT NULL,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `cat_event`
--

INSERT INTO `cat_event` (`id_category`, `alias`, `name`, `id_lang`, `color`, `last_update`) VALUES
(1, 'exposition collective', 'exposition collective', 1, '#B00B0B', '2019-10-28 12:00:00'),
(2, 'expo perso', 'expo personnelle', 1, '#157BD9', '2020-04-29 07:00:00'),
(4, 'festival', 'festival', 1, '#139206', '2020-04-25 17:58:46'),
(10, 'fête médiévale', 'fete', 1, '#E79A00', '2020-04-26 10:56:13'),
(12, 'dedicace', 'dédicace', 1, '#E3B729', '2020-05-08 18:07:49');

-- --------------------------------------------------------

--
-- Structure de la table `cat_media`
--

DROP TABLE IF EXISTS `cat_media`;
CREATE TABLE IF NOT EXISTS `cat_media` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `id_lang` int NOT NULL DEFAULT '1',
  `author` int NOT NULL DEFAULT '0',
  `last_update` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_category`),
  KEY `name` (`name`,`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `cat_media`
--

INSERT INTO `cat_media` (`id_category`, `alias`, `name`, `id_lang`, `author`, `last_update`) VALUES
(2, 'portraits', 'portrait', 1, 0, '2019-11-20 00:00:00'),
(17, 'medieval', 'médieval', 1, 0, '2019-12-09 16:48:29'),
(19, 'landscape', 'paysage', 1, 0, '2019-12-20 15:14:07'),
(23, 'animaux', 'animaux', 1, 0, '2020-04-25 17:33:41'),
(29, 'heroic fantasy', 'heroic fantasy', 1, 0, '2020-12-12 02:03:46');

-- --------------------------------------------------------

--
-- Structure de la table `contact_control_type`
--

DROP TABLE IF EXISTS `contact_control_type`;
CREATE TABLE IF NOT EXISTS `contact_control_type` (
  `id_contact_control_type` int NOT NULL AUTO_INCREMENT,
  `control` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id_contact_control_type`),
  UNIQUE KEY `id_contact_control_type` (`id_contact_control_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `contact_control_type`
--

INSERT INTO `contact_control_type` (`id_contact_control_type`, `control`, `type`) VALUES
(1, 'input', 'text'),
(2, 'input', 'mail'),
(3, 'textarea', ''),
(4, 'input', 'radio'),
(5, 'input ', 'checkbox'),
(6, 'select', ''),
(7, 'option', ''),
(8, 'input', 'phone');

-- --------------------------------------------------------

--
-- Structure de la table `contact_field`
--

DROP TABLE IF EXISTS `contact_field`;
CREATE TABLE IF NOT EXISTS `contact_field` (
  `id_contact_field` int NOT NULL,
  `id_control_type` int NOT NULL,
  `html` longtext NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `contact_field_label`
--

DROP TABLE IF EXISTS `contact_field_label`;
CREATE TABLE IF NOT EXISTS `contact_field_label` (
  `id_contact_field_label` int NOT NULL,
  `id_field` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `placeholder` varchar(255) NOT NULL,
  `lang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `entity`
--

DROP TABLE IF EXISTS `entity`;
CREATE TABLE IF NOT EXISTS `entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `entity`
--

INSERT INTO `entity` (`id`, `name`) VALUES
(1, 'media'),
(2, 'event');

-- --------------------------------------------------------

--
-- Structure de la table `event`
--

DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `id_event` int NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `media` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `organizer` varchar(255) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `contact` varchar(255) NOT NULL,
  `fees` tinyint(1) NOT NULL DEFAULT '0',
  `author` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_event`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `event`
--

INSERT INTO `event` (`id_event`, `is_active`, `url`, `media`, `place`, `organizer`, `date_start`, `date_end`, `contact`, `fees`, `author`, `created_at`, `update_at`) VALUES
(39, 1, 'centarauto.png', '/assets/uploads/Drogon_7x07.jpg', 'cannes', 'okk', '2020-05-05 12:00:00', '2020-05-06 12:00:00', '', 0, 83, '2020-05-15 00:00:00', '2020-05-15 00:00:00'),
(40, 1, '', 'blandy.jpg', '', 'Josué Nicolas', '2021-06-05 14:00:00', '2021-06-05 16:00:00', 'joe,contact@jnicolas.art', 0, 83, NULL, NULL),
(41, 1, 'http://topwagen.com/', '77145384_562857334527427_8883002845083729920_o.jpg', '', 'josue nicolas', '2021-06-26 12:00:00', '2021-08-06 12:00:00', 'contact@jnicolas.art', 0, 83, NULL, NULL),
(42, 1, 'http://topwagen.com/', 'chastelle.jpg', 'paris', 'josue nicolas', '2021-09-04 11:27:31', '2021-11-04 11:27:31', 'jo', 0, 83, NULL, NULL),
(43, 1, 'http://www.etampes.fr/exposition_de_thierry_hulne_et_ses_eleves.html', '91008923_655062305306929_208674177236860928_o.jpg', 'lille', 'essai', '2021-05-19 11:28:46', '2021-05-19 11:28:46', 'joe', 0, 83, NULL, NULL),
(44, 1, 'http://mecarro-dev.albalogic.fr/82-disque-de-frein', 'chastelle.jpg', '', '', '2021-05-28 04:04:56', '2021-07-28 09:04:56', 'joe,contact@jnicolas.art', 0, 83, NULL, NULL),
(45, 1, 'https://www.driveautodiscount.com', '91008923_655062305306929_208674177236860928_o.jpg', 'paris', 'Mediathèque l\'ile au trésor de Brie-Comte-Robert', '2024-03-12 00:00:00', '2024-03-13 00:00:00', '', 0, 83, NULL, NULL),
(46, 1, '', 'montlhery2024.jpg', '', '', '2024-05-13 09:00:00', '2024-06-06 12:00:00', 'contact@jincolas.art', 0, 83, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `event_lang`
--

DROP TABLE IF EXISTS `event_lang`;
CREATE TABLE IF NOT EXISTS `event_lang` (
  `id_event_lang` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `id_lang` int NOT NULL DEFAULT '1',
  `cat_event` int NOT NULL,
  `id_event` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id_event_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `event_lang`
--

INSERT INTO `event_lang` (`id_event_lang`, `title`, `description`, `id_lang`, `cat_event`, `id_event`, `created_at`, `updated_at`) VALUES
(71, 'jour de pacs', '<p>zzzzzzzzzzzzzzzzz</p>', 1, 1, 35, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(72, '', '', 2, 1, 35, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(73, 'Les toiles de la briardise assiegent Blandy', '<p><strong>Pour le bonheur des plus jeunes, ou pour celui de nos ain&eacute;s,</strong></p>\n<p><strong>Pour les curieux&nbsp; ou&nbsp; les &eacute;pris pour la culture m&eacute;di&eacute;vale, le fantastique, les l&eacute;gendes, les contes, et surtout la peinture.&nbsp;</strong></p>\n<p>Si vous &ecirc;tes de passage &agrave; proximit&eacute; de Blandy les tours,&nbsp; profitez de votre visite,&nbsp; ou de votre ballade pour venir d&eacute;couvrir l\'espace d\'un court instant&nbsp; quelques fragments des&nbsp; fameuse \" to&icirc;les de la Briardise\" qui seront expos&eacute;es en plein air *.</p>\n<p>Cette exposition&nbsp; &eacute;ph&eacute;m&egrave;re comprend une collection d\'une dizaine d\'illustrations et peintures revisitant des sc&egrave;nes et&nbsp; monuments&nbsp; locaux ( mais pas que)&nbsp; dans un univers m&eacute;di&eacute;val fantastique.</p>\n<p>je me ferais une joie de vous accueillir .</p>\n<p>- Entr&eacute;e&nbsp; et visite libre.</p>\n<p>- Textes disponibles en&nbsp; Anglais et Fran&ccedil;ais</p>\n<p>*Sous r&eacute;serve des conditions climatiques , il est possible que l\'exposition soit report&eacute;e &agrave; une date ult&eacute;rieure.</p>', 1, 2, 40, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(74, 'The canvases of the briardise besiege Blandy', '<p><strong>For the happiness of the youngest, or for that of our elders,</strong></p>\n<p><strong>For the curious or those in love with medieval culture, the fantastic, legends, tales, and especially painting.</strong></p>\n<p>If you are passing near Blandy les Tours, take advantage of your visit or your walk to come and discover for a short time some fragments of the famous \"to&icirc;les de la Briardise\" which will be exhibited in the open air *.</p>\n<p>This ephemeral exhibition includes a collection of ten illustrations and paintings revisiting local scenes and monuments (but not only) in a medieval fantasy universe.</p>\n<p>I would be happy to welcome you.</p>\n<p>&nbsp;</p>\n<p>- Entrance and free visit.</p>\n<p>&nbsp;</p>\n<p>- Texts available in English and French</p>\n<p>* Subject to weather conditions, the exhibition may be postponed to a later date.</p>', 2, 2, 40, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(75, 'Les toiles de la briardise assiegent Blandy', '<p><strong>Pour le bonheur des plus jeunes, ou pour celui de nos ain&eacute;s,</strong></p>\n<p><strong>Pour les curieux&nbsp; ou&nbsp; les &eacute;pris pour la culture m&eacute;di&eacute;vale, le fantastique, les l&eacute;gendes, les contes, et surtout la peinture.&nbsp;</strong></p>\n<p>Si vous &ecirc;tes de passage &agrave; proximit&eacute; de Blandy les tours,&nbsp; profitez de votre visite,&nbsp; ou de votre ballade pour venir d&eacute;couvrir l\'espace d\'un court instant&nbsp; quelques fragments des&nbsp; fameuse \" to&icirc;les de la Briardise\" qui seront expos&eacute;es en plein air *.</p>\n<p>Cette exposition&nbsp; &eacute;ph&eacute;m&egrave;re comprend une collection d\'une dizaine d\'illustrations et peintures revisitant des sc&egrave;nes et&nbsp; monuments&nbsp; locaux ( mais pas que)&nbsp; dans un univers m&eacute;di&eacute;val fantastique.</p>\n<p>je me ferais une joie de vous accueillir .</p>\n<p>- Entr&eacute;e&nbsp; et visite libre.</p>\n<p>- Textes disponibles en&nbsp; Anglais et Fran&ccedil;ais</p>\n<p>*Sous r&eacute;serve des conditions climatiques , il est possible que l\'exposition soit report&eacute;e &agrave; une date ult&eacute;rieure.</p>', 1, 2, 41, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(76, 'The canvases of the briardise besiege Blandy', '<p><strong>For the happiness of the youngest, or for that of our elders,</strong></p>\n<p><strong>For the curious or those in love with medieval culture, the fantastic, legends, tales, and especially painting.</strong></p>\n<p>If you are passing near Blandy les Tours, take advantage of your visit or your walk to come and discover for a short time some fragments of the famous \"to&icirc;les de la Briardise\" which will be exhibited in the open air *.</p>\n<p>This ephemeral exhibition includes a collection of ten illustrations and paintings revisiting local scenes and monuments (but not only) in a medieval fantasy universe.</p>\n<p>I would be happy to welcome you.</p>\n<p>&nbsp;</p>\n<p>- Entrance and free visit.</p>\n<p>&nbsp;</p>\n<p>- Texts available in English and French</p>\n<p>* Subject to weather conditions, the exhibition may be postponed to a later date.</p>', 2, 2, 41, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(77, 'test', '<p>ssssssssssssssssssssssss</p>', 1, 4, 42, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(78, 'test', '<p>sssssssssssssssssssssssssssssss</p>', 2, 4, 42, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(79, 'etampes', '<p>eeeeeeeeeeeee</p>', 1, 10, 43, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(80, 'exhibition test', '<p>eeeeeeeeeeeeeeeeeee</p>', 2, 10, 43, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(81, 'test', '', 1, 1, 44, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(82, '', '', 2, 1, 44, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(83, 'Exposition d\'art contemporain', '<p>zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz</p>', 1, 2, 45, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(84, '', '', 2, 1, 45, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(85, 'Les toiles de la juine à Montlhéry', '<p class=\"western\" style=\"margin-bottom: 0cm; line-height: 100%;\" align=\"left\">Amoureux du fantastique, de l&rsquo;histoire m&eacute;di&eacute;vale, des monuments et du patrimoine, venez d&eacute;couvrir &laquo;Les Toiles de la Juine&raquo; &agrave; Montlh&eacute;ry, le premier acte de l&rsquo;exposition itin&eacute;rante de Josu&eacute; NICOLAS, revisitant une partie du patrimoine m&eacute;di&eacute;val &agrave; travers une collection de peintures &agrave; l&rsquo;huile.</p>\n<p class=\"western\" style=\"margin-bottom: 0cm; line-height: 100%;\" align=\"left\">&nbsp;</p>\n<p class=\"western\" style=\"margin-bottom: 0cm; line-height: 100%;\" align=\"left\">Entre clins d&rsquo;&oelig;il historiques et interpr&eacute;tations personnelles, cette tourn&eacute;e d&rsquo;exposition qui s&rsquo;agrandit au fil de ses lieux de prestation a pour vocation de vous faire voyager dans le temps et dans l&rsquo;imaginaire.</p>\n<p class=\"western\" style=\"margin-bottom: 0cm; line-height: 100%;\" align=\"left\">Depuis le pass&eacute; des &eacute;difices royaux jusqu&rsquo;aux places et foires des march&eacute;s du 15 &egrave;me si&egrave;cle, Venez d&eacute;couvrir &Eacute;tampes, Montlh&eacute;ry, Marcoussis, Chastres (Arpajon) sans oublier Milly-la-For&ecirc;t et bien d\'autres communes du d&eacute;partement sud francilien.</p>\n<p class=\"western\" style=\"margin-bottom: 0cm; line-height: 100%;\" align=\"left\">&nbsp;</p>\n<p class=\"western\" style=\"margin-bottom: 0cm; line-height: 100%;\" align=\"left\">&nbsp;</p>', 1, 2, 46, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(86, '', '', 2, 1, 46, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `homeslider`
--

DROP TABLE IF EXISTS `homeslider`;
CREATE TABLE IF NOT EXISTS `homeslider` (
  `id_slide` int NOT NULL AUTO_INCREMENT,
  `index_key` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `media` varchar(255) NOT NULL,
  `media_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id_slide`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `homeslider`
--

INSERT INTO `homeslider` (`id_slide`, `index_key`, `name`, `caption`, `active`, `media`, `media_type`) VALUES
(1, 1, 'Slide 1', 'Slide 1', 1, '69755056_502575850555576_7212638382327857152_o.jpg', 'IMG'),
(2, 1, 'Slide 2', 'Slide 2', 1, '67537691_477178419761986_240474149456183296_o.jpg', 'IMG'),
(3, 1, 'Slide 3', 'Slide 3', 1, 'uthred.jpg', 'IMG'),
(7, 1, 'Slide 4', 'Slide 4', 1, 'le_reveil_de_lebaupinay.jpg', 'IMG'),
(8, 1, 'slide 5', 'slide 5', 1, 'paris.jpg', 'IMG');

-- --------------------------------------------------------

--
-- Structure de la table `language`
--

DROP TABLE IF EXISTS `language`;
CREATE TABLE IF NOT EXISTS `language` (
  `id_lang` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  PRIMARY KEY (`id_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `language`
--

INSERT INTO `language` (`id_lang`, `code`, `name`, `alias`) VALUES
(1, 'fr', 'Français(french)', ''),
(2, 'en', 'English (Uk-Us)', '');

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `id_media` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `author` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '0',
  `is_reconstructed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_media`),
  KEY `day` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `media`
--

INSERT INTO `media` (`id_media`, `type`, `url`, `author`, `is_active`, `is_reconstructed`, `created_at`, `updated_at`) VALUES
(91, 'IMG', 'guerriere.jpeg', 0, 1, 0, '2020-05-19 10:14:13', '2020-05-19 10:14:13'),
(92, 'IMG', 'centurion.jpg', 0, 1, 0, '2020-05-19 18:35:14', '2020-05-19 18:35:14'),
(93, 'IMG', 'fontainebleau.jpg', 0, 1, 0, '2020-05-23 23:42:05', '2020-05-23 23:42:05'),
(94, 'IMG', 'chastelle.jpg', 0, 1, 0, '2020-09-02 00:21:16', '2020-09-02 00:21:16'),
(95, 'IMG', 'kahina.jpg', 0, 1, 0, '2020-10-31 17:45:53', '2020-10-31 17:45:53'),
(96, 'IMG', 'bcr.jpg', 0, 1, 0, '2020-11-03 23:55:12', '2020-11-03 23:55:12'),
(97, 'IMG', 'img_20190902_083355_226.jpg', 0, 1, 0, '2020-12-12 01:43:05', '2020-12-12 01:43:05'),
(98, 'IMG', 'blandy.jpg', 0, 1, 0, '2020-12-12 01:52:15', '2020-12-12 01:52:15'),
(99, 'IMG', 'paysanne.jpg', 0, 1, 0, '2020-12-12 02:01:54', '2020-12-12 02:01:54'),
(100, 'IMG', 'paris.jpg', 0, 1, 0, '2021-03-17 22:57:02', '2021-03-17 22:57:02'),
(101, 'IMG', 'knights.jpg', 0, 1, 0, '2021-03-17 23:24:17', '2021-03-17 23:24:17'),
(102, 'IMG', 'milly.jpg', 0, 1, 0, '2021-03-17 23:33:55', '2021-03-17 23:33:55'),
(103, 'IMG', 'suscinio.jpg', 0, 1, 0, '2021-05-01 21:43:50', '2021-05-01 21:43:50'),
(104, 'IMG', 'nemours.jpg', 0, 1, 0, '2021-05-02 17:56:17', '2021-05-02 17:56:17'),
(105, 'IMG', 'metlosenum.jpg', 0, 1, 0, '2021-05-04 23:47:04', '2021-05-04 23:47:04'),
(106, 'IMG', 'P1140212.jpg', 0, 1, 0, '2024-03-24 03:00:01', '2024-03-24 03:00:01');

-- --------------------------------------------------------

--
-- Structure de la table `media_lang`
--

DROP TABLE IF EXISTS `media_lang`;
CREATE TABLE IF NOT EXISTS `media_lang` (
  `id_media_lang` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `cat_media` int NOT NULL,
  `id_lang` int NOT NULL,
  `id_media` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_media_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `media_lang`
--

INSERT INTO `media_lang` (`id_media_lang`, `title`, `description`, `cat_media`, `id_lang`, `id_media`, `created_at`, `updated_at`) VALUES
(1, 'nom', 'lorem ipsume', 1, 1, 19, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(2, 'name', '0', 2, 2, 19, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(3, '0', '0', 4, 1, 44, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(4, 'okkkkkkkkkk', NULL, 2, 2, 44, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(15, 'guerriere sur le front', '<p>Technique mixte crayon de couleur polychromos et aquarelle.</p>\n<p>La peinture repr&eacute;sente un assaut ou un guerri&egrave;re est v&ecirc;tue en tenue normande au X&egrave;me si&egrave;cle</p>', 17, 1, 91, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(16, 'warrior in the front', '<p>Watercolor and color&nbsp; pencil</p>\n<p>The picture shows a woman who wear&nbsp; a chainmail like in 10th century in Normandy.</p>', 2, 2, 91, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(17, 'centurion', '<p>&nbsp;Portrait&nbsp; de Olga KURLYENKO dans le fim Centurion</p>\n<p>Technique mixte aquarelle crayon faber castell</p>\n<p>&nbsp;</p>', 17, 1, 92, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(18, 'Olga', '<p>&nbsp;a Portrait&nbsp; of&nbsp; Olga KURLYENKO in Centurion movie</p>\n<p>A combination of watercolor and Polychromos faber castell pencil&nbsp;</p>', 2, 2, 92, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(19, 'L\'abreuvoir du lévrier', '<p>Representation de la for&ecirc;t de fontainebleau au printemps</p>\n<p>Technique mixte aquarelle&nbsp; et crayon de couleur sur papier Arches Torchon</p>', 23, 1, 93, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(20, 'The Greyhound Watering Place The Greyhound Watering Place', '<p>Representation of the forest of Fontainebleau in spring</p>\n<p>Mixed technique watercolor and colored pencil on Arches Torcho paper</p>', 23, 2, 93, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(21, 'Les tourtereaux du chastelé', '<p>R&eacute;alis&eacute; &agrave; l\'aquarelle.</p>\n<p>Lisez&nbsp; le po&egrave;me associ&eacute; &agrave; cette oeuvre sur&nbsp;https://www.poeme-france.com/auteur/jnicolas/texte-185891</p>', 17, 1, 94, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(22, 'The lovebirds of the chastelé', '<p>Watercolor on paper</p>', 17, 2, 94, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(23, 'La kahina', '<p>Inspir&eacute; de la <strong>Kahina, </strong>c&eacute;l&egrave;bre reine et guerri&egrave;re berb&egrave;re adu&nbsp; moyen &acirc;ge . et bien sur d\'un portrait de la c&eacute;l&egrave;bre kim Kardashian.</p>\n<p>Technique mixte aquarelle + crayon de couleur</p>', 2, 1, 95, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(24, 'The Kahina', '<p>Inspired by <strong>the Kahina</strong>, famous queen and Berber warrior from the Middle Ages. and of course a portrait of the famous kim Kardashian.</p>\n<p>Mixed technique watercolor + colored pencil</p>', 2, 2, 95, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(25, 'brie comte robert', '<p>brie</p>', 17, 1, 96, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(26, 'brie coomte robert', '<p><code>brie</code></p>', 17, 2, 96, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(27, 'Un assassin à Provins', '<p>Inspir&eacute; d\'Assassin\'s creed. Un clich&eacute; d\'un assassin&nbsp; pr&egrave;s de la fameuse tour c&eacute;sar &agrave; Provins.</p>\n<p>Technique mixte quarelle + crayon polychromos Faber&nbsp; castell</p>', 17, 1, 97, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(28, 'An assassin in Provins', '<p>Inspired by Assassin\'s Creed. An artwork&nbsp; of an assassin near the famous Cesar Tower in a french medieval village named Provins.</p>\n<p>Watercolor + polychromos pencil Faber castell</p>', 17, 2, 97, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(29, 'Un dragon à blandy', '<p>Inspir&eacute; du ch&acirc;teau fort de Blandy les tours en Seine et Marne.</p>\n<p>Technique mixte aquarelle et crayon de couleur</p>', 29, 1, 98, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(30, 'A dragon in Blandy', '<p>Inspired by the fortress of&nbsp; Blandy les tours in Seine et Marne in France.</p>\n<p>Watercolor and Pencil</p>', 23, 2, 98, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(31, 'Le dragon et la paysanne', '<p>Composition personnelle. Huile sur toile</p>', 29, 1, 99, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(32, 'The dragon and the peasant', '<p>Personnale composition. Oil on canvas</p>', 23, 2, 99, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(33, 'Le félon de l\'ile de la cité', '<p>technixte mixte Aquarelle + crayon de couleur</p>\n<p>Illustration de l\'exposition Les toiles de la briardise</p>', 17, 1, 100, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(34, 'The felon of Island of the City', '<p>technixte mixte watercolor + pencil</p>\n<p>Canvas from the exposition The canvases of Briardise</p>', 17, 2, 100, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(35, 'La horde', '<p>Issue du recueil&nbsp; Les toiles de la briardise, le roi songeur</p>\n<p>technique mixte aquarelle gouache et crayon ploychromos</p>', 17, 1, 101, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(36, 'The horde', '<p>from the collection \"The canvases of&nbsp; the Briardise\",&nbsp; The pensive king</p>\n<p>Watercolor and pencil</p>', 17, 2, 101, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(37, 'L\'énigmatique', '<p>Issu de l\'exposition \"Les toiles de la briardise\".&nbsp;</p>\n<p>Technique mixte aquarelle crayon et pastel.</p>\n<p>Quelques particularti&eacute;s se situent sur ce tableau reprenant le ch&acirc;teau fort de Milly la For&ecirc;t au moyen &acirc;ge.</p>\n<p>Vous pouvez les consulter via ce lien facebook pour en savoir plus sur ce tableau et cet &eacute;difice.</p>\n<p>&nbsp;</p>', 19, 1, 102, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(38, 'The enigmatic', '<p class=\"MsoNormal\">From the exhibition \"The canvases of the Briardise\".</p>\n<p class=\"MsoNormal\">Mixed technique watercolor pencil and pastel.</p>\n<p class=\"MsoNormal\">Some particularities are on this table showing the fortified castle of Milly la For&ecirc;t, a beautiful small town in France in the Middle Ages.</p>\n<p class=\"MsoNormal\">&nbsp;You can consult them via this facebook link to learn more about this painting and this building.</p>\n<p class=\"MsoNormal\">&nbsp;</p>', 19, 2, 102, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(39, 'Chateau de Suscinio', '<p>Repr&eacute;sentation du ch&acirc;teau de Suscinio en Bretagne dans le Morbihan au XIII &egrave;me si&egrave;cle.</p>\n<p>Technique mixte aquarelle, crayon et gouache sur Papier Arches</p>', 17, 1, 103, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(40, 'The Suscinio\'s castle', '<p>Representation of the castle of Suscinio in Brittany in Morbihan in the 13th century.</p>\n<p>Mixed technique watercolor, pencil and gouache on Arches Paper</p>', 17, 2, 103, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(41, 'Chateau de Nemours', '<p>R&eacute;pr&eacute;sentation m&eacute;di&eacute;vale du Ch&acirc;teau de Nemours en Seine et marne au 12 &egrave;me si&egrave;cle.</p>\n<p>Huile sur papier</p>', 17, 1, 104, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(42, 'The fortress of nemours', '<p>Medieval representation of the Ch&acirc;teau de Nemours in Seine and Marne in France, in the 12th century.</p>\n<p>Oil on paper</p>', 23, 2, 104, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(43, 'Metlosenum', '<p>Repr&eacute;sentation du ch&acirc;teau de Melun en seine et marne qui existait au Moyen &acirc;ge. Tableau issu de la s&eacute;rie \"Les toiles de la briardise\" . Le rat rappelle la devise&nbsp; de la ville \"Fidamuris usque ad mures\" ( Fid&egrave;le au murs jusqu\'au dernier rat)</p>\n<p>Technique mixte aquarelle, crayon polychromos, gouache et fusain</p>', 17, 1, 105, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(44, 'Metlosenum', '<pre id=\"tw-target-text\" class=\"tw-data-text tw-text-large XcVN5d tw-ta\" dir=\"ltr\" style=\"unicode-bidi: isolate; font-size: 28px; line-height: 36px; background-color: #f8f9fa; border: none; padding: 2px 0.14em 2px 0px; position: relative; margin-top: -2px; margin-bottom: -2px; resize: none; overflow: hidden; width: 270px; white-space: pre-wrap; overflow-wrap: break-word; color: #202124; font-family: \'Google Sans\', arial, sans-serif !important;\" data-placeholder=\"Traduction\"><span class=\"Y2IQFc\" lang=\"en\">Representation of the castle of Melun in Seine and Marne which existed in the Middle Ages. Table from the series \"Les toiles de la briardise\". The rat recalls the motto of the city \"Fidamuris usque ad mures\" (Faithful to the walls until the last rat)\n\nMixed technique watercolor, polychrome pencil, gouache and charcoal</span></pre>', 17, 2, 105, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(45, 'etampes', '<p>bablalblalblal</p>', 23, 1, 106, '2024-11-11 00:53:14', '2024-11-11 00:53:14'),
(46, 'etampes', '<p>blablablaenglish</p>', 17, 2, 106, '2024-11-11 00:53:14', '2024-11-11 00:53:14');

-- --------------------------------------------------------

--
-- Structure de la table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `id_module` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `description` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id_module`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `modules`
--

INSERT INTO `modules` (`id_module`, `name`, `author`, `description`, `is_active`, `image`) VALUES
(1, 'navigation', 'yashowa', 'affiche le menu de navigation dans le site', 1, ''),
(2, 'slider', 'yashowa', 'gere le slider sur la homepage', 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `navigation`
--

DROP TABLE IF EXISTS `navigation`;
CREATE TABLE IF NOT EXISTS `navigation` (
  `id_navigation` int NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  `parent` int NOT NULL,
  `rank` int DEFAULT NULL,
  `id_entity` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_navigation`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `navigation`
--

INSERT INTO `navigation` (`id_navigation`, `alias`, `parent`, `rank`, `id_entity`, `is_active`) VALUES
(1, 'book', 0, 2, 1, 1),
(2, 'agenda', 0, 5, 2, 1),
(3, 'les-toiles-de-la-briardise', 0, 4, 0, 1),
(20, 'accueil', 0, 1, 0, 1),
(21, 'contact', 0, 6, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `navigation_lang`
--

DROP TABLE IF EXISTS `navigation_lang`;
CREATE TABLE IF NOT EXISTS `navigation_lang` (
  `id_navigation_lang` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `id_lang` int NOT NULL DEFAULT '1',
  `id_navigation` int NOT NULL,
  PRIMARY KEY (`id_navigation_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `navigation_lang`
--

INSERT INTO `navigation_lang` (`id_navigation_lang`, `name`, `url`, `id_lang`, `id_navigation`) VALUES
(1, 'Galerie', '/fr/gallery', 1, 1),
(2, 'Gallery', '/en/gallery', 2, 1),
(3, 'Biographie', '/biographie', 1, 4),
(4, 'Biography', '/biography', 2, 4),
(5, 'Agenda & Evenements', '/fr/events', 1, 2),
(6, 'Calendar & events', '/en/events', 2, 2),
(7, 'Les toiles de la Briardise', '/fr/les-toiles-de-la-briardise', 1, 3),
(8, 'The canvases of Briardise', '/en/les-toiles-de-la-briardise', 2, 3),
(11, 'Accueil', '/', 1, 20),
(12, 'Home', '/', 2, 20),
(13, 'Contact', '/fr/contact', 1, 21),
(14, 'Contact us', '/en/contact', 2, 21);

-- --------------------------------------------------------

--
-- Structure de la table `page`
--

DROP TABLE IF EXISTS `page`;
CREATE TABLE IF NOT EXISTS `page` (
  `active` tinyint(1) NOT NULL,
  `author` int NOT NULL,
  `id_page` int NOT NULL AUTO_INCREMENT,
  `date_add` datetime NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id_page`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `page`
--

INSERT INTO `page` (`active`, `author`, `id_page`, `date_add`, `last_update`) VALUES
(1, 83, 1, '2020-05-19 19:25:00', '2020-05-19 20:00:00'),
(1, 83, 2, '2020-05-22 07:00:00', '2020-05-19 00:00:31'),
(1, 83, 3, '2020-12-19 17:34:53', '2020-12-19 17:34:53'),
(1, 83, 4, '2021-03-15 22:43:18', '2021-03-15 22:43:18'),
(1, 83, 5, '2023-02-25 16:37:27', '2023-02-25 16:37:27');

-- --------------------------------------------------------

--
-- Structure de la table `page_lang`
--

DROP TABLE IF EXISTS `page_lang`;
CREATE TABLE IF NOT EXISTS `page_lang` (
  `id_page_lang` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `id_lang` int NOT NULL DEFAULT '1',
  `id_page` int NOT NULL,
  PRIMARY KEY (`id_page_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `page_lang`
--

INSERT INTO `page_lang` (`id_page_lang`, `title`, `alias`, `content`, `id_lang`, `id_page`) VALUES
(1, 'Mentions legales', 'mentions', '<h2 style=\"font-family: \'Times New Roman\';\">Informations l&eacute;gales</h2>\n<h3 style=\"font-family: \'Times New Roman\';\">1. Pr&eacute;sentation du site.</h3>\n<p style=\"font-family: \'Times New Roman\';\">En vertu de l\'article 6 de la loi n&deg; 2004-575 du 21 juin 2004 pour la confiance dans l\'&eacute;conomie num&eacute;rique, il est pr&eacute;cis&eacute; aux utilisateurs du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;l\'identit&eacute; des diff&eacute;rents intervenants dans le cadre de sa r&eacute;alisation et de son suivi :</p>\n<p style=\"font-family: \'Times New Roman\';\"><strong>Propri&eacute;taire</strong>&nbsp;: Josu&eacute; NICOLAS &ndash; josue nicolas &ndash; La briardise - 28 rue des noyers 77390 CRISENOY<br><strong>Cr&eacute;ateur</strong>&nbsp;:&nbsp;<a href=\"https://fiddle.jshell.net/_display/josu%C3%A9\">josu&eacute;</a><br><strong>Responsable publication</strong>&nbsp;: Josu&eacute; NICOLAS &ndash; contact@jnicolas.art<br>Le responsable publication est une personne physique ou une personne morale.<br><strong>Webmaster</strong>&nbsp;: Josu&eacute; NICOLAS &ndash; contact@jnicolas.art<br><strong>H&eacute;bergeur</strong>&nbsp;: OVH &ndash; 2 rue Kellermann - 59100 Roubaix - France<br>Cr&eacute;dits :<br>Le mod&egrave;le de mentions l&eacute;gales est offert par Subdelirium.com&nbsp;<a href=\"https://www.subdelirium.com/generateur-de-mentions-legales/\" target=\"_blank\" rel=\"noopener\">Mod&egrave;le de mentions l&eacute;gales</a></p>\n<h3 style=\"font-family: \'Times New Roman\';\">2. Conditions g&eacute;n&eacute;rales d&rsquo;utilisation du site et des services propos&eacute;s.</h3>\n<p style=\"font-family: \'Times New Roman\';\">L&rsquo;utilisation du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;implique l&rsquo;acceptation pleine et enti&egrave;re des conditions g&eacute;n&eacute;rales d&rsquo;utilisation ci-apr&egrave;s d&eacute;crites. Ces conditions d&rsquo;utilisation sont susceptibles d&rsquo;&ecirc;tre modifi&eacute;es ou compl&eacute;t&eacute;es &agrave; tout moment, les utilisateurs du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;sont donc invit&eacute;s &agrave; les consulter de mani&egrave;re r&eacute;guli&egrave;re.</p>\n<p style=\"font-family: \'Times New Roman\';\">Ce site est normalement accessible &agrave; tout moment aux utilisateurs. Une interruption pour raison de maintenance technique peut &ecirc;tre toutefois d&eacute;cid&eacute;e par Josu&eacute; NICOLAS, qui s&rsquo;efforcera alors de communiquer pr&eacute;alablement aux utilisateurs les dates et heures de l&rsquo;intervention.</p>\n<p style=\"font-family: \'Times New Roman\';\">Le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;est mis &agrave; jour r&eacute;guli&egrave;rement par Josu&eacute; NICOLAS. De la m&ecirc;me fa&ccedil;on, les mentions l&eacute;gales peuvent &ecirc;tre modifi&eacute;es &agrave; tout moment : elles s&rsquo;imposent n&eacute;anmoins &agrave; l&rsquo;utilisateur qui est invit&eacute; &agrave; s&rsquo;y r&eacute;f&eacute;rer le plus souvent possible afin d&rsquo;en prendre connaissance.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">3. Description des services fournis.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;a pour objet de fournir une information concernant l&rsquo;ensemble des activit&eacute;s de la soci&eacute;t&eacute;.</p>\n<p style=\"font-family: \'Times New Roman\';\">Josu&eacute; NICOLAS s&rsquo;efforce de fournir sur le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;des informations aussi pr&eacute;cises que possible. Toutefois, il ne pourra &ecirc;tre tenue responsable des omissions, des inexactitudes et des carences dans la mise &agrave; jour, qu&rsquo;elles soient de son fait ou du fait des tiers partenaires qui lui fournissent ces informations.</p>\n<p style=\"font-family: \'Times New Roman\';\">Tous les informations indiqu&eacute;es sur le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;sont donn&eacute;es &agrave; titre indicatif, et sont susceptibles d&rsquo;&eacute;voluer. Par ailleurs, les renseignements figurant sur le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;ne sont pas exhaustifs. Ils sont donn&eacute;s sous r&eacute;serve de modifications ayant &eacute;t&eacute; apport&eacute;es depuis leur mise en ligne.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">4. Limitations contractuelles sur les donn&eacute;es techniques.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Le site utilise la technologie JavaScript.</p>\n<p style=\"font-family: \'Times New Roman\';\">Le site Internet ne pourra &ecirc;tre tenu responsable de dommages mat&eacute;riels li&eacute;s &agrave; l&rsquo;utilisation du site. De plus, l&rsquo;utilisateur du site s&rsquo;engage &agrave; acc&eacute;der au site en utilisant un mat&eacute;riel r&eacute;cent, ne contenant pas de virus et avec un navigateur de derni&egrave;re g&eacute;n&eacute;ration mis-&agrave;-jour</p>\n<h3 style=\"font-family: \'Times New Roman\';\">5. Propri&eacute;t&eacute; intellectuelle et contrefa&ccedil;ons.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Josu&eacute; NICOLAS est propri&eacute;taire des droits de propri&eacute;t&eacute; intellectuelle ou d&eacute;tient les droits d&rsquo;usage sur tous les &eacute;l&eacute;ments accessibles sur le site, notamment les textes, images, graphismes, logo, ic&ocirc;nes, sons, logiciels.</p>\n<p style=\"font-family: \'Times New Roman\';\">Toute reproduction, repr&eacute;sentation, modification, publication, adaptation de tout ou partie des &eacute;l&eacute;ments du site, quel que soit le moyen ou le proc&eacute;d&eacute; utilis&eacute;, est interdite, sauf autorisation &eacute;crite pr&eacute;alable de : Josu&eacute; NICOLAS.</p>\n<p style=\"font-family: \'Times New Roman\';\">Toute exploitation non autoris&eacute;e du site ou de l&rsquo;un quelconque des &eacute;l&eacute;ments qu&rsquo;il contient sera consid&eacute;r&eacute;e comme constitutive d&rsquo;une contrefa&ccedil;on et poursuivie conform&eacute;ment aux dispositions des articles L.335-2 et suivants du Code de Propri&eacute;t&eacute; Intellectuelle.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">6. Limitations de responsabilit&eacute;.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Josu&eacute; NICOLAS ne pourra &ecirc;tre tenue responsable des dommages directs et indirects caus&eacute;s au mat&eacute;riel de l&rsquo;utilisateur, lors de l&rsquo;acc&egrave;s au site www.jnicolas.art, et r&eacute;sultant soit de l&rsquo;utilisation d&rsquo;un mat&eacute;riel ne r&eacute;pondant pas aux sp&eacute;cifications indiqu&eacute;es au point 4, soit de l&rsquo;apparition d&rsquo;un bug ou d&rsquo;une incompatibilit&eacute;.</p>\n<p style=\"font-family: \'Times New Roman\';\">Josu&eacute; NICOLAS ne pourra &eacute;galement &ecirc;tre tenue responsable des dommages indirects (tels par exemple qu&rsquo;une perte de march&eacute; ou perte d&rsquo;une chance) cons&eacute;cutifs &agrave; l&rsquo;utilisation du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>.</p>\n<p style=\"font-family: \'Times New Roman\';\">Des espaces interactifs (possibilit&eacute; de poser des questions dans l&rsquo;espace contact) sont &agrave; la disposition des utilisateurs. Josu&eacute; NICOLAS se r&eacute;serve le droit de supprimer, sans mise en demeure pr&eacute;alable, tout contenu d&eacute;pos&eacute; dans cet espace qui contreviendrait &agrave; la l&eacute;gislation applicable en France, en particulier aux dispositions relatives &agrave; la protection des donn&eacute;es. Le cas &eacute;ch&eacute;ant, Josu&eacute; NICOLAS se r&eacute;serve &eacute;galement la possibilit&eacute; de mettre en cause la responsabilit&eacute; civile et/ou p&eacute;nale de l&rsquo;utilisateur, notamment en cas de message &agrave; caract&egrave;re raciste, injurieux, diffamant, ou pornographique, quel que soit le support utilis&eacute; (texte, photographie&hellip;).</p>\n<h3 style=\"font-family: \'Times New Roman\';\">7. Gestion des donn&eacute;es personnelles.</h3>\n<p style=\"font-family: \'Times New Roman\';\">En France, les donn&eacute;es personnelles sont notamment prot&eacute;g&eacute;es par la loi n&deg; 78-87 du 6 janvier 1978, la loi n&deg; 2004-801 du 6 ao&ucirc;t 2004, l\'article L. 226-13 du Code p&eacute;nal et la Directive Europ&eacute;enne du 24 octobre 1995.</p>\n<p style=\"font-family: \'Times New Roman\';\">A l\'occasion de l\'utilisation du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>, peuvent &ecirc;tres recueillies : l\'URL des liens par l\'interm&eacute;diaire desquels l\'utilisateur a acc&eacute;d&eacute; au site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>, le fournisseur d\'acc&egrave;s de l\'utilisateur, l\'adresse de protocole Internet (IP) de l\'utilisateur.</p>\n<p style=\"font-family: \'Times New Roman\';\">En tout &eacute;tat de cause Josu&eacute; NICOLAS ne collecte des informations personnelles relatives &agrave; l\'utilisateur que pour le besoin de certains services propos&eacute;s par le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>. L\'utilisateur fournit ces informations en toute connaissance de cause, notamment lorsqu\'il proc&egrave;de par lui-m&ecirc;me &agrave; leur saisie. Il est alors pr&eacute;cis&eacute; &agrave; l\'utilisateur du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;l&rsquo;obligation ou non de fournir ces informations.</p>\n<p style=\"font-family: \'Times New Roman\';\">Conform&eacute;ment aux dispositions des articles 38 et suivants de la loi 78-17 du 6 janvier 1978 relative &agrave; l&rsquo;informatique, aux fichiers et aux libert&eacute;s, tout utilisateur dispose d&rsquo;un droit d&rsquo;acc&egrave;s, de rectification et d&rsquo;opposition aux donn&eacute;es personnelles le concernant, en effectuant sa demande &eacute;crite et sign&eacute;e, accompagn&eacute;e d&rsquo;une copie du titre d&rsquo;identit&eacute; avec signature du titulaire de la pi&egrave;ce, en pr&eacute;cisant l&rsquo;adresse &agrave; laquelle la r&eacute;ponse doit &ecirc;tre envoy&eacute;e.</p>\n<p style=\"font-family: \'Times New Roman\';\">Aucune information personnelle de l\'utilisateur du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;n\'est publi&eacute;e &agrave; l\'insu de l\'utilisateur, &eacute;chang&eacute;e, transf&eacute;r&eacute;e, c&eacute;d&eacute;e ou vendue sur un support quelconque &agrave; des tiers. Seule l\'hypoth&egrave;se du rachat de Josu&eacute; NICOLAS et de ses droits permettrait la transmission des dites informations &agrave; l\'&eacute;ventuel acqu&eacute;reur qui serait &agrave; son tour tenu de la m&ecirc;me obligation de conservation et de modification des donn&eacute;es vis &agrave; vis de l\'utilisateur du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>.</p>\n<p style=\"font-family: \'Times New Roman\';\">Les bases de donn&eacute;es sont prot&eacute;g&eacute;es par les dispositions de la loi du 1er juillet 1998 transposant la directive 96/9 du 11 mars 1996 relative &agrave; la protection juridique des bases de donn&eacute;es.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">8. Liens hypertextes et cookies.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;contient un certain nombre de liens hypertextes vers d&rsquo;autres sites, mis en place avec l&rsquo;autorisation de Josu&eacute; NICOLAS. Cependant, Josu&eacute; NICOLAS n&rsquo;a pas la possibilit&eacute; de v&eacute;rifier le contenu des sites ainsi visit&eacute;s, et n&rsquo;assumera en cons&eacute;quence aucune responsabilit&eacute; de ce fait.</p>\n<p style=\"font-family: \'Times New Roman\';\">La navigation sur le site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;est susceptible de provoquer l&rsquo;installation de cookie(s) sur l&rsquo;ordinateur de l&rsquo;utilisateur. Un cookie est un fichier de petite taille, qui ne permet pas l&rsquo;identification de l&rsquo;utilisateur, mais qui enregistre des informations relatives &agrave; la navigation d&rsquo;un ordinateur sur un site. Les donn&eacute;es ainsi obtenues visent &agrave; faciliter la navigation ult&eacute;rieure sur le site, et ont &eacute;galement vocation &agrave; permettre diverses mesures de fr&eacute;quentation.</p>\n<p style=\"font-family: \'Times New Roman\';\">Le refus d&rsquo;installation d&rsquo;un cookie peut entra&icirc;ner l&rsquo;impossibilit&eacute; d&rsquo;acc&eacute;der &agrave; certains services. L&rsquo;utilisateur peut toutefois configurer son ordinateur de la mani&egrave;re suivante, pour refuser l&rsquo;installation des cookies :</p>\n<p style=\"font-family: \'Times New Roman\';\">Sous Internet Explorer : onglet outil (pictogramme en forme de rouage en haut a droite) / options internet. Cliquez sur Confidentialit&eacute; et choisissez Bloquer tous les cookies. Validez sur Ok.</p>\n<p style=\"font-family: \'Times New Roman\';\">Sous Firefox : en haut de la fen&ecirc;tre du navigateur, cliquez sur le bouton Firefox, puis aller dans l\'onglet Options. Cliquer sur l\'onglet Vie priv&eacute;e. Param&eacute;trez les R&egrave;gles de conservation sur : utiliser les param&egrave;tres personnalis&eacute;s pour l\'historique. Enfin d&eacute;cochez-la pour d&eacute;sactiver les cookies.</p>\n<p style=\"font-family: \'Times New Roman\';\">Sous Safari : Cliquez en haut &agrave; droite du navigateur sur le pictogramme de menu (symbolis&eacute; par un rouage). S&eacute;lectionnez Param&egrave;tres. Cliquez sur Afficher les param&egrave;tres avanc&eacute;s. Dans la section \"Confidentialit&eacute;\", cliquez sur Param&egrave;tres de contenu. Dans la section \"Cookies\", vous pouvez bloquer les cookies.</p>\n<p style=\"font-family: \'Times New Roman\';\">Sous Chrome : Cliquez en haut &agrave; droite du navigateur sur le pictogramme de menu (symbolis&eacute; par trois lignes horizontales). S&eacute;lectionnez Param&egrave;tres. Cliquez sur Afficher les param&egrave;tres avanc&eacute;s. Dans la section \"Confidentialit&eacute;\", cliquez sur pr&eacute;f&eacute;rences. Dans l\'onglet \"Confidentialit&eacute;\", vous pouvez bloquer les cookies.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">9. Droit applicable et attribution de juridiction.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Tout litige en relation avec l&rsquo;utilisation du site&nbsp;<a href=\"http://www.jnicolas.art/\">www.jnicolas.art</a>&nbsp;est soumis au droit fran&ccedil;ais. Il est fait attribution exclusive de juridiction aux tribunaux comp&eacute;tents de Paris.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">10. Les principales lois concern&eacute;es.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Loi n&deg; 78-17 du 6 janvier 1978, notamment modifi&eacute;e par la loi n&deg; 2004-801 du 6 ao&ucirc;t 2004 relative &agrave; l\'informatique, aux fichiers et aux libert&eacute;s.</p>\n<p style=\"font-family: \'Times New Roman\';\">Loi n&deg; 2004-575 du 21 juin 2004 pour la confiance dans l\'&eacute;conomie num&eacute;rique.</p>\n<h3 style=\"font-family: \'Times New Roman\';\">11. Lexique.</h3>\n<p style=\"font-family: \'Times New Roman\';\">Utilisateur : Internaute se connectant, utilisant le site susnomm&eacute;.</p>\n<p style=\"font-family: \'Times New Roman\';\">Informations personnelles : &laquo; les informations qui permettent, sous quelque forme que ce soit, directement ou non, l\'identification des personnes physiques auxquelles elles s\'appliquent &raquo; (article 4 de la loi n&deg; 78-17 du 6 janvier 1978).</p>\n<p style=\"font-family: \'Times New Roman\';\">Cr&eacute;dits :&nbsp;<a style=\"background: 0px 0px #ffffff; border: 0px; margin: 0px; padding: 0px; vertical-align: baseline; outline: 0px; color: #e1ad4e; text-decoration-line: none; cursor: pointer; font-family: Poppins, sans-serif; font-size: 16px;\" title=\"mentions legales\" href=\"https://www.subdelirium.com/generateur-de-mentions-legales/\" rel=\"dc:source\">www.subdelirium.com</a><span style=\"color: #5b5b5b; font-family: Poppins, sans-serif; font-size: 16px; background-color: #ffffff;\">.</span></p>', 1, 1),
(2, 'Biographie', 'biography', '<p><strong>Josu&eacute; NICOLAS</strong> est un d&eacute;veloppeur et graphiste web de profession, mais aussi un Artiste Illustrateur et peintre amateur originaire de Maisons-Alfort vivant en Essonne.</p>\n<p>Passionn&eacute; depuis tout petit par le dessin, c&rsquo;est en essayant de recopier les jaquettes de jeux vid&eacute;o et les couvertures des mangas de ses grands fr&egrave;res qu&rsquo;il touche &agrave; ses premiers crayons.</p>\n<p>Ayant expos&eacute; en Paris, en Seine et marne, et en galerie &agrave; La Baule au sein du Club Atelier d&rsquo;artistes, il a &eacute;galement r&eacute;alis&eacute; des illustrations pour des livres destin&eacute;s aux enfants en collaboration avec l&rsquo;auteur <strong>R&eacute;gis Hurel BENINGA</strong> tels que les contes &laquo;Voyage &agrave; B&eacute;toko&raquo;, &laquo; Les &icirc;les enchant&eacute;es &raquo;, ou encore le recueil de po&egrave;mes &laquo;Ch&oelig;urs des C&oelig;urs&raquo;.</p>\n<p>Bien que pratiquant le dessin depuis toujours en autodidacte, c&rsquo;est &agrave; l&rsquo;atelier d&rsquo;arts Cl&eacute;mentine de <strong>Thierry HULNE</strong> &agrave; &Eacute;tampes ou il est toujours &eacute;l&egrave;ve, qu&rsquo;il s&lsquo;est initi&eacute; aux techniques picturales, au travail de la couleur, &agrave; l&rsquo;association de l&rsquo;aquarelle combin&eacute;e aux crayons de couleurs, ainsi qu&rsquo;&agrave; la peinture &agrave; l&rsquo;huile.</p>\n<p>C&rsquo;est &agrave; ce m&ecirc;me atelier que le d&eacute;clic et la volont&eacute; de communiquer sa passion au public l&rsquo;am&egrave;ne &agrave; participer &agrave; des expositions.</p>\n<p>Bien qu&rsquo;&eacute;tant polyvalent, la plupart de ses r&eacute;alisations traitent autour de la th&eacute;matique de l&rsquo;univers m&eacute;di&eacute;val et fantastique et la revisite de monuments historiques.</p>\n<p>Certains de ses travaux sont accompagn&eacute;s de po&egrave;mes et narrations et sont regroup&eacute;s sous une collection intitul&eacute;e <strong>\"Les toiles de la Juine\"</strong>&nbsp;(<em>anciennement: Les toiles de la Briardise</em>) qu&rsquo;il propose sous format d&rsquo;exposition semi-permanente.</p>\n<p>Les paysages, les portraits, et les animaux font &eacute;galement partie de ses th&egrave;mes de pr&eacute;dilection.</p>', 1, 2),
(3, 'Legal notice', 'mentions', '<p style=\"font-family: \'Times New Roman\';\">If you require any more information or have any questions about our site\'s disclaimer, please feel free to contact us by email at contact@jnicolas.art. Our Disclaimer was generated with the help of the&nbsp;<a href=\"https://www.disclaimergenerator.net/\">Disclaimer Generator</a>.</p>\n<h2 style=\"font-family: \'Times New Roman\';\">Disclaimers for www.jnicolas.art</h2>\n<p style=\"font-family: \'Times New Roman\';\">All the information on this website - http://www.jnicolas.art - is published in good faith and for general information purpose only. www.jnicolas.art does not make any warranties about the completeness, reliability and accuracy of this information. Any action you take upon the information you find on this website (www.jnicolas.art), is strictly at your own risk. www.jnicolas.art will not be liable for any losses and/or damages in connection with the use of our website.</p>\n<p style=\"font-family: \'Times New Roman\';\">From our website, you can visit other websites by following hyperlinks to such external sites. While we strive to provide only quality links to useful and ethical websites, we have no control over the content and nature of these sites. These links to other websites do not imply a recommendation for all the content found on these sites. Site owners and content may change without notice and may occur before we have the opportunity to remove a link which may have gone \'bad\'.</p>\n<p style=\"font-family: \'Times New Roman\';\">Please be also aware that when you leave our website, other sites may have different privacy policies and terms which are beyond our control. Please be sure to check the Privacy Policies of these sites as well as their \"Terms of Service\" before engaging in any business or uploading any information. Our Privacy Policy was created by&nbsp;<a href=\"https://www.generateprivacypolicy.com/\">the Privacy Policy Generator</a>.</p>\n<h2 style=\"font-family: \'Times New Roman\';\">Consent</h2>\n<p style=\"font-family: \'Times New Roman\';\">By using our website, you hereby consent to our disclaimer and agree to its terms.</p>\n<h2 style=\"font-family: \'Times New Roman\';\">Update</h2>\n<p style=\"font-family: \'Times New Roman\';\">Should we update, amend or make any changes to this document, those changes will be prominently posted here.</p>', 2, 1),
(4, 'Biography', 'biography', '<p><strong>Josu&eacute; NICOLAS</strong> is a professional web developer and graphic designer, but also an Illustrator Artist and amateur painter from Maisons-Alfort living in Essonne in France.</p>\n<p>Fascinated by drawing since a very young age, it was while trying to copy the jackets of video games and the manga covers of his older brothers that he touched his first pencils.</p>\n<p>Having exhibited in Paris, in Seine et marne, and in a gallery in La Baule within the Club Atelier d\'artistes, he has also produced illustrations for books for children in collaboration with the author R&eacute;gis Hurel BENINGA such as the tales \"Voyage &agrave; B&eacute;toko\", \"Les &icirc;les enchant&eacute;es\" or the collection of poems \"Ch&oelig;urs des C&oelig;urs\".</p>\n<p>Although he has always been drawing as an autodidact, it was at Thierry HULNE\'s Cl&eacute;mentine art studio in &Eacute;tampes, where he is still a student, that he was introduced to pictorial techniques, color work, the association of watercolor combined with colored pencils, as well as oil paint.</p>\n<p>It was at this same workshop that the trigger and the desire to communicate his passion to the public led him to participate in exhibitions.</p>\n<p>Although versatile, most of his achievements deal with the theme of the medieval and fantastic universe and the revisiting of historical monuments.</p>\n<p>Some of his works are accompanied by poems and narrations and are grouped under a collection entitled \"<strong>Les toiles de la Juine</strong>\", (formerly: Les toiles de la Briardise) which he offers in semi-permanent exhibition format.</p>\n<p>Landscapes, portraits, and animals are also among his favorite themes.</p>', 2, 2),
(5, 'Credits', 'credits', '<p style=\"margin-bottom: 0cm; line-height: 1px;\">D&eacute;couvrez &eacute;galement d&rsquo;autres artistes et partenaires:</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>P.J. BERMAN</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.pjbermanbooks.com/\">https://www.pjbermanbooks.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>R&eacute;gis Hurel BENINGA</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.editions-harmattan.fr/index.asp?navig=auteurs&amp;obj=artiste&amp;no=30636\">https://www.editions-harmattan.fr/index.asp?navig=auteurs&amp;obj=artiste&amp;no=30636</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Thierry HULNE</strong></p>\n<p class=\"MsoNormal\"><a href=\"http://www.thierryhulne.fr/\">http://www.thierryhulne.fr/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Quentin</strong>&nbsp;<strong>KHEYAP</strong>&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><span style=\"color: #0000ee;\"><u>https://photos-quentin.book.fr/</u></span></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Thibault DAPOIGNY</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://tbart.carbonmade.com/\">https://tbart.carbonmade.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Jimmy EVRARD</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.jlocoart.com/\">https://www.jlocoart.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Linda BACHAMMAR</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.linda-bachammar-art.com/\">https://www.linda-bachammar-art.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Thierry BLOT</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"http://thierry-blot.com/\">http://thierry-blot.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Caroline LABBE</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.instagram.com/caroline_labbe/\">https://www.instagram.com/caroline_labbe/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Steeven SALVAT</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.steeven-salvat.com/\">https://www.steeven-salvat.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Partenaires</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Fidamuris</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.fidamuris.fr/\">https://www.fidamuris.fr/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Experience radio</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.experienceradio.fr/\">https://www.experienceradio.fr/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Art&eacute;mis</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://expoartemis.blogspot.com/p/liens.html\" target=\"_blank\" rel=\"noopener\">https://expoartemis.blogspot.com/p/liens.html</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Artmosph&egrave;re</strong></p>\n<p class=\"MsoNormal\"><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\"><a href=\"https://www.facebook.com/artmosphereiledefrance\">https://www.facebook.com/artmosphereiledefrance</a></span></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\">Ch&acirc;teau de la Mothe Chandeniers</span></strong></p>\n<p class=\"MsoNormal\"><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\"><span><span><a href=\"https://mothe-chandeniers.com/fr/\" target=\"_blank\" rel=\"noopener\">https://mothe-chandeniers.com/fr/</a></span></span></span></p>\n<p class=\"MsoNormal\"><strong><span style=\"line-height: 107%;\"><span style=\"font-family: Segoe UI, sans-serif;\"><span style=\"font-size: 18px;\">Ch&acirc;teau de l\'Ebaupinay</span></span></span></strong></p>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\"><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\"><span><a href=\"https://www.ebaupinay.com/\" target=\"_blank\" rel=\"noopener\">https://www.ebaupinay.com/</a></span></span></p>', 1, 3),
(6, 'Credits', 'credits', '<p>Discover artists and partners</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>P.J. BERMAN</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.pjbermanbooks.com/\" target=\"_blank\" rel=\"noopener\">https://www.pjbermanbooks.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Thierry HULNE</strong></p>\n<p class=\"MsoNormal\"><a href=\"http://www.thierryhulne.fr/\">http://www.thierryhulne.fr/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>R&eacute;gis Hurel BENINGA</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.editions-harmattan.fr/index.asp?navig=auteurs&amp;obj=artiste&amp;no=30636\" target=\"_blank\" rel=\"noopener\">https://www.editions-harmattan.fr/index.asp?navig=auteurs&amp;obj=artiste&amp;no=30636</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Quentin</strong> <strong>KHEYAP</strong>&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><span style=\"color: #0000ee;\"><u>https://photos-quentin.book.fr/</u></span></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Thibault DAPOIGNY</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://tbart.carbonmade.com/\" target=\"_blank\" rel=\"noopener\">https://tbart.carbonmade.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Jimmy EVRARD</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.jlocoart.com/\" target=\"_blank\" rel=\"noopener\">https://www.jlocoart.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Linda BACHAMMAR</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.linda-bachammar-art.com/\" target=\"_blank\" rel=\"noopener\">https://www.linda-bachammar-art.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Thierry BLOT</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"http://thierry-blot.com/\" target=\"_blank\" rel=\"noopener\">http://thierry-blot.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Caroline LABBE</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.instagram.com/caroline_labbe/\" target=\"_blank\" rel=\"noopener\">https://www.instagram.com/caroline_labbe/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Steeven SALVAT</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.steeven-salvat.com/\" target=\"_blank\" rel=\"noopener\">https://www.steeven-salvat.com/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Partners</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Fidamuris</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.fidamuris.fr/\" target=\"_blank\" rel=\"noopener\">https://www.fidamuris.fr/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Experience radio</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://www.experienceradio.fr/\" target=\"_blank\" rel=\"noopener\">https://www.experienceradio.fr/</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Art&eacute;mis</strong></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><a href=\"https://expoartemis.blogspot.com/p/liens.html\" target=\"_blank\" rel=\"noopener\">https://expoartemis.blogspot.com/p/liens.html</a></p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\">&nbsp;</p>\n<p style=\"margin-bottom: 0cm; line-height: 1px;\"><strong>Artmosph&egrave;re</strong></p>\n<p class=\"MsoNormal\"><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\"><a href=\"https://www.facebook.com/artmosphereiledefrance\">https://www.facebook.com/artmosphereiledefrance</a></span></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\">Castle of Mothe Chandeniers</span></strong></p>\n<p class=\"MsoNormal\"><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\"><span style=\"font-family: Segoe UI, sans-serif;\"><span style=\"font-size: 18px;\"><a href=\"https://mothe-chandeniers.com/fr/\" target=\"_blank\" rel=\"noopener\">https://mothe-chandeniers.com/fr/</a></span></span></span></p>\n<p class=\"MsoNormal\"><strong><span style=\"line-height: 107%;\"><span style=\"font-family: Segoe UI, sans-serif;\"><span style=\"font-size: 18px;\">Castle of Ebaupinay</span></span></span></strong></p>\n<p class=\"MsoNormal\"><span style=\"font-size: 13.5pt; line-height: 107%; font-family: \'Segoe UI\',sans-serif; color: black;\"><span style=\"font-family: Segoe UI, sans-serif;\"><a href=\"https://www.ebaupinay.com/\" target=\"_blank\" rel=\"noopener\">https://www.ebaupinay.com/</a></span></span></p>', 2, 3),
(7, 'Les toiles de la Briardise', 'les-toiles-de-la-briardise', '<div class=\"row\">\n<div class=\"col-md-8 col-sm-12\">\n<p class=\"MsoNormal\"><strong>Les toiles de la briardise&nbsp;</strong>, sont avant tout l&rsquo;intitul&eacute; d&rsquo;une collection comme l&rsquo;a qualifi&eacute; une fois le peintre&nbsp;<strong>Thierry BLOT&nbsp;</strong>&laquo; de peintures narratives&raquo; que je propose en permanence sous format d\'exposition.</p>\n<p class=\"MsoNormal\">En permanente &eacute;volution, et comportant diff&eacute;rentes inspirations comme des lieux et monuments historiques, des portraits de personnalit&eacute;s publiques ou de personnages issus de films, s&eacute;ries ( Kingdom of Heaven, Game of Thrones) et encore de jeux vid&eacute;o dans un cadre m&eacute;di&eacute;val fantastique, cette exposition, se pr&ecirc;te tout &agrave; fait aux &eacute;tablissements de types m&eacute;diath&egrave;que ou aux petites salles mais tout aussi bien en ext&eacute;rieur comme &ccedil;a a pu &ecirc;tre le cas dans le fief de&nbsp;<strong>Jean COCTEAU,&nbsp;</strong>&agrave;&nbsp;<strong>Milly la For&ecirc;t</strong>&nbsp;dans les jardins de la&nbsp;<strong>Chapelle saint Blaise&nbsp;</strong>ou j\'ai eu la chance de pouvoir exposer.</p>\n</div>\n<div class=\"col-md-4 col-sm-12\"><img class=\"img-responsive\" title=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \" src=\"https://www.api.jnicolas.art/assets/uploads/labriardise.jpg\" alt=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \"></div>\n</div>\n<div class=\"row\">\n<p class=\"h-50\"><img class=\"img-responsive\" title=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \" src=\"https://www.api.jnicolas.art/assets/uploads/labriardise2.jpg\" alt=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \">&nbsp;<img class=\"img-responsive\" title=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \" src=\"https://www.api.jnicolas.art/assets/uploads/labriardise3.jpg\" alt=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \"></p>\n</div>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\">A certaines de ces toiles, (pas toutes) sont associ&eacute;s des &eacute;crits (po&egrave;mes ou histoires courtes, et contes&hellip;) ayant pour vocation d&rsquo;&ecirc;tre lu ou&nbsp; racont&eacute;s oralement aupr&egrave;s de petits et grands.</p>\n<p class=\"MsoNormal\"><em><strong>NB: Tous les &eacute;crits sont traduits en version anglaise&nbsp; pour le plaisir de tous&nbsp;</strong></em></p>\n<p class=\"MsoNormal\">Ainsi, &agrave; travers cette exposition,&nbsp; vous trouvez des clins d&rsquo;&oelig;il adress&eacute;s &agrave; la seine et marne (Fontainebleau,&nbsp; Melun et ses villages aux alentours), &agrave; des monuments historiques en tout genre, mais aussi &agrave; des c&eacute;l&eacute;brit&eacute;s du sport et du showbiz.</p>\n<p><iframe title=\"YouTube video player\" src=\"https://www.youtube.com/embed/t9okt5js8cc\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"\"></iframe></p>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\"><em>Si vous avez eu l&rsquo;occasion d&rsquo;assister &agrave; cette exposition, n&rsquo;h&eacute;sitez pas &agrave; partager autour de vous&nbsp;!!!</em></p>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\" style=\"text-align: right;\"><strong>Josu&eacute; NICOLAS</strong></p>', 1, 4),
(8, 'The canvases of Briardise', 'les-toiles-de-la-briardise', '<div class=\"row\">\n<div class=\"col-md-8 col-sm-12\">\n<p class=\"MsoNormal\"><strong>The canvases of the briardise&nbsp;</strong>,are above all the title of a collection, as the painter&nbsp;<a href=\"http://thierry-blot.com/\" target=\"_blank\" rel=\"noopener\"><strong>Thierry&nbsp;BLOT</strong></a>&nbsp;once described it as \"narrative paintings\" that I offer permanently in exhibition format.</p>\n<p class=\"MsoNormal\">In permanent evolution, and comprising different inspirations such as historical places and monuments, portraits of public figures or characters from films, series (<strong>Kingdom of Heaven, Game of Thrones</strong>) and even video games in a fantastic medieval setting, this exhibition , lends itself perfectly to media library type establishments or small rooms but just as well outdoors as was the case in the stronghold of&nbsp;<strong>Jean COCTEAU</strong>, in Milly la For&ecirc;t in the gardens of the Chapelle Saint Blaise where I had the chance to exhibit.</p>\n</div>\n<div class=\"col-md-4 col-sm-12\"><code><img class=\"img-responsive\" title=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \" src=\"../../assets/uploads/labriardise.jpg\" alt=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \"></code></div>\n</div>\n<p><img class=\"img-responsive\" title=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \" src=\"../../assets/uploads/labriardise2.jpg\" alt=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \">&nbsp;<img class=\"img-responsive\" title=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \" src=\"../../assets/uploads/labriardise3.jpg\" alt=\"Les toiles de la briardise &agrave; Milly-la-For&ecirc;t \"></p>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\">Some of these paintings (not all) are associated with writings (poems or short stories, and tales ...) intended to be read or told orally to young and old.NB: All the writings are translated in English version for the pleasure of all.</p>\n<p class=\"MsoNormal\">Thus, through this exhibition, you will find winks addressed to the Seine and Marne in the south east Parisian region (Fontainebleau, Melun and its surrounding villages), to historical monuments of all kinds, but also to sports and showbiz celebrities .</p>\n<p><iframe title=\"YouTube video player\" src=\"https://www.youtube.com/embed/t9okt5js8cc\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"\"></iframe></p>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\">If you had the opportunity to attend this exhibition, do not hesitate to share with others &nbsp;!!!</p>\n<p class=\"MsoNormal\">&nbsp;</p>\n<p class=\"MsoNormal\" style=\"text-align: right;\"><strong>Josu&eacute; NICOLAS</strong></p>\n<p class=\"MsoNormal\">&nbsp;</p>', 2, 4),
(9, 'Les toiles de la Juine', 'les-toiles-de-la-juine', '<p>En construction</p>', 1, 5),
(10, 'Les toiles de la Juine', 'les-toiles-de-la-juine', '<p>In construction</p>', 2, 5);

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id_setting` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id_setting`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `settings`
--

INSERT INTO `settings` (`id_setting`, `name`, `value`) VALUES
(1, 'website_logo', '44277880_2155147331471993_6745852179728302080_n.jpg'),
(2, 'website_email', 'josue_nicolas@outlook.fr'),
(3, 'website_domain', 'www.jnicolas.art'),
(4, 'website_title', 'Site officiel de l\'artiste Josué NICOLAS                                                                                                                                                                                                                                                                 '),
(5, 'website_keywords', 'artiste,peintre,illustrateur, mangaka,aquarelliste,coma,seine et marne'),
(6, 'website_description', '&lt;p style=&quot;text-align: center;&quot;&gt;Le site est actuellement en maintenance.&lt;br&gt;Vous pourrez bient&amp;ocirc;t consulter &amp;agrave; nouveau notre contenu et notre actualit&amp;eacute;.&lt;/p&gt;\n&lt;p style=&quot;text-align: center;&quot;&gt;Nous vous remercions de votre compr&amp;eacute;hension&lt;/p&gt;'),
(7, 'website_maintenance', '0'),
(8, 'website_maintenance_msg', '&lt;p style=&quot;text-align: center;&quot;&gt;Le site est actuellement en maintenance.&lt;br&gt;Vous pourrez bient&amp;ocirc;t consulter &amp;agrave; nouveau notre contenu et notre actualit&amp;eacute;.&lt;/p&gt;\n&lt;p style=&quot;text-align: center;&quot;&gt;Nous vous remercions de votre compr&amp;eacute;hension&lt;/p&gt;'),
(9, 'website_fb', 'http://www.facebook.com/jeeneekola'),
(10, 'website_fb', 'http://www.facebook.com/jeeneekola'),
(11, 'website_tw', 'http://www.twitter.com/jeeneekola'),
(12, 'website_tw_id', ''),
(13, 'website_insta', 'http://www.instagram.com/jeeneekola'),
(14, 'website_insta_id', '');

-- --------------------------------------------------------

--
-- Structure de la table `slider`
--

DROP TABLE IF EXISTS `slider`;
CREATE TABLE IF NOT EXISTS `slider` (
  `id_slider` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_slider`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `slider`
--

INSERT INTO `slider` (`id_slider`, `name`, `active`) VALUES
(1, 'diapositive accueil', 1);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `id_profile` int NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passwd` varchar(60) NOT NULL,
  `last_connexion` date DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id_user`, `id_profile`, `firstname`, `lastname`, `email`, `passwd`, `last_connexion`, `last_update`) VALUES
(83, 2, 'josué', 'NICOLAS', 'contact@jnicolas.art', '$2y$10$EMYIPFuma27QYxp3jDKzqe562WHt0WwbKk80sTS7.cE2tqeI9dgbK', '2019-12-04', '2019-12-04 15:28:34'),
(164, 1, 'laurine', 'bouillaud', 'laurine@gmail.com', 'oijuhyg', '2020-03-17', '2020-03-17 01:11:23'),
(170, 2, 'josue', 'nicolas', 'josue_nicolas@outlook.fr', 'test', '2020-04-12', '2020-04-12 18:07:08');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
