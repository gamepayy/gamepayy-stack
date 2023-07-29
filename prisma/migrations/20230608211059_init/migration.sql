-- CreateTable
CREATE TABLE `MerkleTrees` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `root` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `token_address` VARCHAR(255) NULL,
    `amount` VARCHAR(255) NULL,
    `hash1` VARCHAR(66) NULL,
    `hash2` VARCHAR(66) NULL,
    `hash3` VARCHAR(66) NULL,
    `hash4` VARCHAR(66) NULL,
    `hash5` VARCHAR(66) NULL,
    `hash6` VARCHAR(66) NULL,
    `hash7` VARCHAR(66) NULL,
    `hash8` VARCHAR(66) NULL,
    `hash9` VARCHAR(66) NULL,
    `hash10` VARCHAR(66) NULL,
    `hash11` VARCHAR(66) NULL,
    `hash12` VARCHAR(66) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `auth` (
    `address` VARCHAR(256) NOT NULL,
    `HASH` VARCHAR(256) NULL,

    PRIMARY KEY (`address`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pending_withdrawals` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `address` VARCHAR(256) NOT NULL,
    `token_address` VARCHAR(256) NOT NULL,
    `amount` VARCHAR(256) NULL,
    `pending` BOOLEAN NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pending_withdrawals_test` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `address` VARCHAR(255) NULL,
    `token_address` VARCHAR(255) NULL,
    `amount` VARCHAR(255) NULL,
    `root` VARCHAR(255) NULL,
    `txHash` VARCHAR(255) NULL,
    `pending` BOOLEAN NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tokens` (
    `address` VARCHAR(256) NOT NULL,
    `name` VARCHAR(256) NULL,
    `symbol` VARCHAR(256) NULL,
    `decimals` INTEGER NULL,

    PRIMARY KEY (`address`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tokens_balances` (
    `address` VARCHAR(255) NOT NULL,
    `token_address` VARCHAR(255) NOT NULL,
    `balance` VARCHAR(255) NULL,

    PRIMARY KEY (`address`, `token_address`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `address` VARCHAR(255) NOT NULL,
    `balance` VARCHAR(255) NULL,

    PRIMARY KEY (`address`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

