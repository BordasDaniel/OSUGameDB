CREATE DATABASE IF NOT EXISTS OSUGameDB;

USE OSUGameDB;

-- Felhasználók tábla
CREATE TABLE Users (
    Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Username VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    RegistrationDate DATE NOT NULL,
    Status ENUM('in game','online','browser','mobile','idle', 'offline', 'archived', 'hybernated') NOT NULL
);

-- Perifériák tábla (one-to-many kapcsolat Users táblával)
CREATE TABLE Peripherals (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT,
    PeripheralName VARCHAR(255),
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
);

-- Barátok tábla (many-to-many kapcsolat Users táblával)
CREATE TABLE Friends (
    UserId INT,
    FriendId INT,
    PRIMARY KEY(UserId, FriendId),
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (FriendId) REFERENCES Users(Id) ON DELETE CASCADE
);

-- Teljesítmények tábla
CREATE TABLE Achievements (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Rarity VARCHAR(50) NOT NULL,
    AcquirePercentage DOUBLE NOT NULL
);

-- Elért teljesítmények tábla (many-to-many kapcsolat Users és Achievements táblák között)
CREATE TABLE EarnedAchievements (
    UserId INT,
    AchievementId INT,
    PRIMARY KEY(UserId, AchievementId),
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (AchievementId) REFERENCES Achievements(Id) ON DELETE CASCADE
);

-- Statisztikák tábla (one-to-one kapcsolat a Users és Statistics táblák között.)
CREATE TABLE Statistics (
    UserId INT PRIMARY KEY,
    UserLevel INT NOT NULL,
    UserXP INT NOT NULL,
    FriendsCount INT NOT NULL,
    ReviewsCount INT NOT NULL,
    TotalAchievements INT NOT NULL,
    AchievementCompletionPercentage DOUBLE NOT NULL,
    PlayedMaps INT NOT NULL,
    CreatedMaps INT NOT NULL,
    UsersPlayedYourMaps INT NOT NULL,
    HighestScore INT NOT NULL,
    MaximumCombo INT NOT NULL,
    TotalScore INT NOT NULL,
    PerformancePoints INT NOT NULL,
    HitPercentage DOUBLE NOT NULL,
    PerfectRun INT NOT NULL,
    NoMissRuns INT NOT NULL,
    OneMissRuns INT NOT NULL,
    PerfectRunWithMods INT NOT NULL,
    NoMissRunWithMods INT NOT NULL,
    OneMissRunWithMods INT NOT NULL,
    TotalHours DOUBLE NOT NULL,
    LocalRank INT NOT NULL,
    GlobalRank INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
);

-- Pálya tábla (one-to-many kapcsolat a Users és Maps táblák között)
CREATE TABLE Maps (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    CreatorId INT,
    Name VARCHAR(255) NOT NULL,
    PlayCount INT NOT NULL,
    LengthInSeconds INT NOT NULL,
    Favorites INT NOT NULL,
    Likes INT NOT NULL,
    Dislikes INT NOT NULL,
    ReviewsCount INT NOT NULL,
    FOREIGN KEY (CreatorId) REFERENCES Users(Id) ON DELETE CASCADE
);

-- Értékelések tábla (one-to-many kapcsolat a Users és Reviews táblák között)
CREATE TABLE Reviews (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    AuthorId INT,
    MapId INT,
    Content TEXT NOT NULL,
    Positive BOOLEAN NOT NULL,
    FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (MapId) REFERENCES Maps(Id) ON DELETE CASCADE
);
