-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  lun. 07 août 2017 à 00:14
-- Version du serveur :  10.0.30-MariaDB-0+deb8u2
-- Version de PHP :  5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `openRP`
--

-- --------------------------------------------------------

--
-- Structure de la table `log_chat`
--

CREATE TABLE `log_chat` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `server` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `log_name`
--

CREATE TABLE `log_name` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `reason` varchar(64) NOT NULL,
  `used_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `log_transaction`
--

CREATE TABLE `log_transaction` (
  `log_id` int(11) NOT NULL,
  `user_sender` int(11) NOT NULL,
  `user_receiver` int(11) NOT NULL,
  `amout` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `log_work`
--

CREATE TABLE `log_work` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `work_old` int(11) NOT NULL,
  `work_new` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_data`
--

CREATE TABLE `user_data` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `user_updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_money` int(11) NOT NULL,
  `user_work` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `work_data`
--

CREATE TABLE `work_data` (
  `work_id` int(11) NOT NULL,
  `work_name` varchar(32) NOT NULL,
  `work_faction` int(11) NOT NULL,
  `work_rank` int(11) NOT NULL,
  `work_salary` int(11) NOT NULL,
  `work_chief` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `work_faction`
--

CREATE TABLE `work_faction` (
  `faction_id` int(11) NOT NULL,
  `faction_name` varchar(32) NOT NULL,
  `faction_gov` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `work_rank`
--

CREATE TABLE `work_rank` (
  `faction_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `rank_name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `log_chat`
--
ALTER TABLE `log_chat`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `id_log_chat` (`user_id`) USING BTREE;

--
-- Index pour la table `log_name`
--
ALTER TABLE `log_name`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `id_log_name` (`user_id`) USING BTREE;

--
-- Index pour la table `log_transaction`
--
ALTER TABLE `log_transaction`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `id_log_transaction_sender` (`user_sender`),
  ADD KEY `id_log_transaction_receiver` (`user_receiver`);

--
-- Index pour la table `log_work`
--
ALTER TABLE `log_work`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `id_log_work_new` (`work_new`),
  ADD KEY `id_log_work` (`work_old`);

--
-- Index pour la table `user_data`
--
ALTER TABLE `user_data`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `id_work` (`user_work`);

--
-- Index pour la table `work_data`
--
ALTER TABLE `work_data`
  ADD PRIMARY KEY (`work_id`),
  ADD KEY `id_work_rank` (`work_rank`),
  ADD KEY `id_work_faction` (`work_faction`);

--
-- Index pour la table `work_faction`
--
ALTER TABLE `work_faction`
  ADD PRIMARY KEY (`faction_id`);

--
-- Index pour la table `work_rank`
--
ALTER TABLE `work_rank`
  ADD PRIMARY KEY (`rank_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `log_name`
--
ALTER TABLE `log_name`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `log_transaction`
--
ALTER TABLE `log_transaction`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `log_work`
--
ALTER TABLE `log_work`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_data`
--
ALTER TABLE `user_data`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `work_data`
--
ALTER TABLE `work_data`
  MODIFY `work_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `work_faction`
--
ALTER TABLE `work_faction`
  MODIFY `faction_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `work_rank`
--
ALTER TABLE `work_rank`
  MODIFY `rank_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `log_chat`
--
ALTER TABLE `log_chat`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user_data` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `log_name`
--
ALTER TABLE `log_name`
  ADD CONSTRAINT `user_2` FOREIGN KEY (`user_id`) REFERENCES `user_data` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `log_transaction`
--
ALTER TABLE `log_transaction`
  ADD CONSTRAINT `id_log_transaction_receiver` FOREIGN KEY (`user_receiver`) REFERENCES `user_data` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `id_log_transaction_sender` FOREIGN KEY (`user_sender`) REFERENCES `user_data` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `log_work`
--
ALTER TABLE `log_work`
  ADD CONSTRAINT `id_log_work` FOREIGN KEY (`work_old`) REFERENCES `user_data` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `id_log_work_new` FOREIGN KEY (`work_new`) REFERENCES `work_data` (`work_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `id_log_work_old` FOREIGN KEY (`work_old`) REFERENCES `work_data` (`work_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_data`
--
ALTER TABLE `user_data`
  ADD CONSTRAINT `id_work` FOREIGN KEY (`user_work`) REFERENCES `work_data` (`work_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `work_data`
--
ALTER TABLE `work_data`
  ADD CONSTRAINT `id_work_faction` FOREIGN KEY (`work_faction`) REFERENCES `work_faction` (`faction_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `id_work_rank` FOREIGN KEY (`work_rank`) REFERENCES `work_rank` (`rank_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
