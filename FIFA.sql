CREATE DATABASE FIFA 

GO

CREATE PROCEDURE createAllTables
AS
    CREATE TABLE SystemUser
    (
        username VARCHAR(20) NOT NULL,
        password VARCHAR(20) NOT NULL,
        CONSTRAINT pk_system_user PRIMARY KEY (username)
    )

    CREATE TABLE Stadium
    (
        id INT IDENTITY,
        status BIT DEFAULT '1',
        location VARCHAR(20),
        capacity INT,
        name VARCHAR(20) UNIQUE,
        CONSTRAINT pk_stadium PRIMARY KEY (id)
    )

    CREATE TABLE StadiumManager
    (
        username VARCHAR(20),
        id INT IDENTITY,
        name VARCHAR(20),
        stadium_id INT,
        CONSTRAINT pk_stadium_manager PRIMARY KEY (id),
        CONSTRAINT fk_stadium_manager FOREIGN KEY (username) REFERENCES SystemUser ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT fk_stadium_id FOREIGN KEY (stadium_id) REFERENCES Stadium ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Club
    (
        id INT IDENTITY,
        name VARCHAR(20) UNIQUE,
        location VARCHAR(20),
        CONSTRAINT pk_club PRIMARY KEY (id)
    )

    CREATE TABLE ClubRepresentative
    (
        username VARCHAR(20),
        id INT IDENTITY,
        name VARCHAR(20),
        club_id INT,
        CONSTRAINT pk_club_representative PRIMARY KEY (id),
        CONSTRAINT fk_club_representative FOREIGN KEY (username) REFERENCES SystemUser ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT fk_club FOREIGN KEY (club_id) REFERENCES Club ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Fan
    (
        username VARCHAR(20),
        national_id VARCHAR(20),
        birth_date DATETIME,
        status BIT DEFAULT '1',
        address VARCHAR(20),
        name VARCHAR(20),
        phone_num INT,
        CONSTRAINT pk_fan PRIMARY KEY (national_id),
        CONSTRAINT fk_fan FOREIGN KEY (username) REFERENCES SystemUser ON DELETE NO ACTION ON UPDATE NO ACTION
    )

    CREATE TABLE SportsAssociationManager
    (
        username VARCHAR(20),
        id INT IDENTITY,
        name VARCHAR(20),
        CONSTRAINT pk_sports_association_manager PRIMARY KEY (id),
        CONSTRAINT fk_sports_association_manager FOREIGN KEY (username) REFERENCES SystemUser ON DELETE NO ACTION ON UPDATE NO ACTION
    )

    CREATE TABLE SystemAdmin
    (
        username VARCHAR(20),
        id INT IDENTITY,
        name VARCHAR(20),
        CONSTRAINT pk_system_admin PRIMARY KEY (id),
        CONSTRAINT fk_system_admin FOREIGN KEY (username) REFERENCES SystemUser ON DELETE NO ACTION ON UPDATE NO ACTION
    )

    CREATE TABLE Match
    (
        match_id INT IDENTITY,
        start_time DATETIME,
        end_time DATETIME,
        stadium_id INT,
        host_club_id INT,
        guest_club_id INT,
        CONSTRAINT pk_match PRIMARY KEY (match_id),
        CONSTRAINT fk_match_c_1 FOREIGN KEY (host_club_id) REFERENCES Club,
        CONSTRAINT fk_match_c_2 FOREIGN KEY (guest_club_id) REFERENCES Club,
        CONSTRAINT fk_match_s FOREIGN KEY (stadium_id) REFERENCES Stadium ON DELETE SET NULL ON UPDATE NO ACTION,
        CONSTRAINT check_time_match CHECK (start_time < end_time)
    )

    CREATE TABLE HostRequest
    (
        stadium_manager_id INT,
        club_representative_id INT,
        id INT IDENTITY,
        status CHAR(1) DEFAULT 'U',
        match_id INT,
        CONSTRAINT pk_host_request PRIMARY KEY (id),
        CONSTRAINT fk_host_request_s FOREIGN KEY (stadium_manager_id) REFERENCES StadiumManager ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_host_request_c FOREIGN KEY (club_representative_id) REFERENCES ClubRepresentative ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_host_request_m FOREIGN KEY (match_id) REFERENCES Match ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT check_status CHECK (status IN ('T', 'F', 'U'))
    )

    CREATE TABLE Ticket
    (
        id INT IDENTITY,
        status BIT DEFAULT '1',
        match_id INT,
        fan_national_id VARCHAR(20),
        CONSTRAINT pk_ticket PRIMARY KEY (id),
        CONSTRAINT fk_ticket_m FOREIGN KEY (match_id) REFERENCES Match ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_ticket_f FOREIGN KEY (fan_national_id) REFERENCES Fan ON DELETE CASCADE ON UPDATE CASCADE
)

GO

CREATE PROCEDURE dropAllTables
AS
    DROP TABLE Ticket
    DROP TABLE HostRequest
    DROP TABLE Match
    DROP TABLE SystemAdmin
    DROP TABLE SportsAssociationManager
    DROP TABLE Fan
    DROP TABLE ClubRepresentative
    DROP TABLE Club
    DROP TABLE StadiumManager
    DROP TABLE Stadium
    DROP TABLE SystemUser

GO

CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
    DROP PROCEDURE createAllTables
    DROP PROCEDURE dropAllTables
    DROP PROCEDURE clearAllTables
    DROP VIEW allAssocManagers
    DROP VIEW allClubRepresentatives
    DROP VIEW allStadiumManagers
    DROP VIEW allFans
    DROP VIEW allMatches
    DROP VIEW allTickets
    DROP VIEW allClubs
    DROP VIEW allStadiums
    DROP VIEW allRequests
    DROP PROCEDURE addAssociationManager
    DROP PROCEDURE addNewMatch
    DROP VIEW clubsWithNoMatches
    DROP PROCEDURE deleteMatch
    DROP PROCEDURE deleteMatchesOnStadium
    DROP PROCEDURE addClub
    DROP PROCEDURE addTicket
    DROP PROCEDURE deleteClub
    DROP PROCEDURE addStadium
    DROP PROCEDURE deleteStadium
    DROP PROCEDURE blockFan
    DROP PROCEDURE unblockFan
    DROP PROCEDURE addRepresentative
    DROP FUNCTION viewAvailableStadiumsOn
    DROP PROCEDURE addHostRequest
    DROP FUNCTION allUnassignedMatches
    DROP PROCEDURE addStadiumManager
    DROP FUNCTION allPendingRequests
    DROP PROCEDURE acceptRequest
    DROP PROCEDURE rejectRequest
    DROP PROCEDURE addFan
    DROP FUNCTION upcomingMatchesOfClub
    DROP FUNCTION availableMatchesToAttend
    DROP PROCEDURE purchaseTicket
    DROP PROCEDURE updateMatchHost
    DROP VIEW matchesPerTeam
    DROP VIEW clubsNeverMatched
    DROP FUNCTION clubsNeverPlayed
    DROP FUNCTION matchWithHighestAttendance
    DROP FUNCTION matchesRankedByAttendance
    DROP FUNCTION requestsFromClub

GO

CREATE PROCEDURE clearAllTables
AS
    TRUNCATE TABLE Ticket
    TRUNCATE TABLE HostRequest
    DELETE FROM Match
    DBCC CHECKIDENT (Match, RESEED, 0)
    TRUNCATE TABLE SystemAdmin
    TRUNCATE TABLE SportsAssociationManager
    DELETE FROM Fan
    DELETE FROM ClubRepresentative
    DBCC CHECKIDENT (ClubRepresentative, RESEED, 0)
    DELETE FROM Club
    DBCC CHECKIDENT (Club, RESEED, 0)
    DELETE FROM StadiumManager
    DBCC CHECKIDENT (StadiumManager, RESEED, 0)
    DELETE FROM Stadium
    DBCC CHECKIDENT (Stadium, RESEED, 0)
    DELETE FROM SystemUser

GO

CREATE VIEW allAlreadyPlayedMatches
AS
SELECT C1.name "Host Club Name", C2.name "Guest Club Name", M.start_time, M.end_time
FROM Club C1 
INNER JOIN Match M ON C1.id = M.host_club_id 
INNER JOIN Club C2 ON C2.id = M.guest_club_id
WHERE M.start_time <= CURRENT_TIMESTAMP

GO

CREATE VIEW allAssocManagers
AS
    SELECT SM.username, SU.password, SM.name
    FROM SportsAssociationManager SM, SystemUser SU
    WHERE SM.username = SU.username

GO

CREATE VIEW allClubRepresentatives
AS
    SELECT CR.username, SU.password, CR.name AS 'Club Representative Name', C.name AS 'Club Name'
    FROM ClubRepresentative CR , Club C, SystemUser SU
    WHERE C.id = CR.club_id AND CR.username = SU.username

GO

CREATE VIEW allClubs
AS
    SELECT name, location
    FROM Club

GO

CREATE VIEW allFans
AS
    SELECT F.username, SU.password, F.name, F.national_id, F.birth_date , F.status
    FROM Fan F, SystemUser SU
    WHERE F.username = SU.username

GO

CREATE VIEW allMatches
AS
    SELECT H.name AS 'Host Club Name', G.name AS 'Guest Club Name', M.start_time
    FROM Club H, Club G, Match M
    WHERE H.id = M.host_club_id AND G.id = M.guest_club_id

GO

CREATE VIEW allRequests
AS
    SELECT CR.username AS 'Club Representative Username', SM.username AS 'Stadium Manager Username', HR.status
    FROM ClubRepresentative CR, StadiumManager SM, HostRequest HR
    WHERE CR.id = HR.club_representative_id AND SM.id = HR.stadium_manager_id

GO

CREATE VIEW allStadiumManagers
AS
    SELECT SM.username, SU.password, SM.name AS 'Stadium Manager Name', S.name AS 'Stadium Name'
    FROM StadiumManager SM, Stadium S, SystemUser SU
    WHERE SM.stadium_id = S.id AND SM.username = SU.username

GO

CREATE VIEW allStadiums
AS
    SELECT name, location, capacity, status
    FROM Stadium

GO

CREATE VIEW allTickets
AS
    SELECT DISTINCT H.name AS 'Host Club Name', G.name AS 'Guest Club Name', S.name AS 'Stadium Name', M.start_time
    FROM Club H, Club G, Stadium S, Match M, Ticket T
    WHERE H.id = M.host_club_id AND G.id = M.guest_club_id
        AND M.stadium_id = S.id AND T.match_id = M.match_id

GO

CREATE VIEW allUpcomingMatches
AS
    SELECT C1.name "Host Club Name", C2.name "Guest Club Name", M.start_time, M.end_time
    FROM Club C1 
    INNER JOIN Match M ON C1.id = M.host_club_id 
    INNER JOIN Club C2 ON C2.id = M.guest_club_id
    WHERE M.start_time > CURRENT_TIMESTAMP

GO

CREATE VIEW clubsNeverMatched
AS
    SElECT DISTINCT C1.name AS 'First Club Name', C2.name AS 'Second Club Name'
    FROM Club C1, Club C2, Match M
    WHERE C1.id < C2.id 
    ORDER BY C1.name, C2.name
    OFFSET 0 ROWS
    EXCEPT (
        SELECT C3.name AS 'FirstClub Name', C4.name AS 'Second Club Name'
        FROM Match M1, Club C3, Club C4
        WHERE ((C3.id = M1.host_club_id AND C4.id = M1.guest_club_id)
              OR (C4.id = M1.host_club_id AND C3.id = M1.guest_club_id))
              AND M1.start_time < CURRENT_TIMESTAMP
    )

GO

CREATE VIEW clubsWithNoMatches
AS
    SELECT C.name
    FROM Club C
    WHERE NOT EXISTS (
    SELECT M.match_id
    FROM Match M
    WHERE C.id = M.guest_club_id OR C.id = M.host_club_id
    )

GO

CREATE VIEW matchesPerTeam
AS
    SELECT C.name AS 'Club Name', COUNT(M.match_id) AS 'Number of Matches Played'
    FROM Club C, Match M
    WHERE (C.id = M.host_club_id OR C.id = M.guest_club_id) AND CURRENT_TIMESTAMP >= M.end_time
    GROUP BY C.name

GO

CREATE PROCEDURE acceptRequest
@sm_name VARCHAR(20),
@host_name VARCHAR(20),
@guest_name VARCHAR(20),
@start_time DATETIME
AS
DECLARE @sm_id INT
DECLARE @cr_id INT
DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT
DECLARE @stadium_id INT
DECLARE @stadium_capacity INT
DECLARE @counter INT 

    SELECT @host_id = C1.id
    FROM Club C1
    WHERE C1.name = @host_name

    SELECT @guest_id = C2.id
    FROM Club C2
    WHERE C2.name = @guest_name

    SELECT @sm_id = id, @stadium_id = stadium_id
    FROM StadiumManager
    WHERE username = @sm_name

    SELECT @stadium_capacity = capacity 
    FROM Stadium
    WHERE id = @stadium_id

    SELECT @cr_id = id
    FROM ClubRepresentative
    WHERE club_id = @host_id

    SELECT @match_id = match_id
    FROM Match
    WHERE start_time = @start_time AND host_club_id = @host_id AND guest_club_id = @guest_id

    UPDATE Match 
    SET stadium_id = @stadium_id
    WHERE match_id = @match_id

    UPDATE HostRequest
    SET status = 'T'
    WHERE match_id = @match_id 

    SET @counter = 1 
    WHILE (@counter <= @stadium_capacity)
    BEGIN
      EXEC dbo.addTicket @host_name, @guest_name, @start_time
      SET @counter = @counter  + 1
    END

GO

CREATE PROCEDURE addAssociationManager
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
    INSERT INTO SystemUser VALUES (@username, @password)
    INSERT INTO SportsAssociationManager VALUES (@username, @name)

GO

CREATE PROCEDURE addClub
@club_name VARCHAR(20),
@location VARCHAR(20)
AS
    INSERT INTO Club VALUES (@club_name, @location)

GO

CREATE PROCEDURE addFan
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@national_id VARCHAR(20),
@birth_date DATETIME,
@address VARCHAR(20),
@phone_num INT
AS

    INSERT INTO SystemUser VALUES (@username, @password)
    INSERT INTO Fan (name, username, national_id, birth_date, address, phone_num) 
    VALUES (@name, @username, @national_id, @birth_date, @address, @phone_num)

GO

CREATE PROCEDURE addHostRequest
@club_name VARCHAR(20),
@stadium_name VARCHAR(20),
@start_time DATETIME
AS
DECLARE @cr_id INT
DECLARE @sm_id INT
DECLARE @match_id INT
DECLARE @club_id INT

    SELECT @cr_id = CR.id
    FROM Club C INNER JOIN ClubRepresentative CR ON C.id = CR.club_id
    WHERE C.name = @club_name

    SELECT @sm_id = SM.id
    FROM Stadium S INNER JOIN StadiumManager SM ON S.id = SM.stadium_id
    WHERE S.name = @stadium_name

    SELECT @club_id = id 
    FROM Club
    WHERE @club_name = name

    SELECT @match_id = match_id
    FROM Match
    WHERE start_time = @start_time AND host_club_id = @club_id

    INSERT INTO HostRequest VALUES (@sm_id, @cr_id, 'U', @match_id)

GO

CREATE PROCEDURE addNewMatch
@host_club VARCHAR(20),
@guest_club VARCHAR(20),
@start_time DATETIME,
@end_time DATETIME
AS
DECLARE @host_id INT
DECLARE @guest_id INT

    SELECT @host_id = C1.id, @guest_id = C2.id
    FROM Club C1, Club C2
    WHERE @host_club = C1.name AND @guest_club = C2.name

    INSERT INTO Match (host_club_id, guest_club_id, start_time, end_time) VALUES (@host_id, @guest_id, @start_time, @end_time)

GO

CREATE PROCEDURE addRepresentative
@name VARCHAR(20),
@club_name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
DECLARE @club_id INT

    SELECT @club_id = C.id
    FROM Club C
    WHERE C.name = @club_name

    INSERT INTO SystemUser VALUES (@username, @password)
    INSERT INTO ClubRepresentative VALUES (@username, @name, @club_id)

GO

CREATE PROCEDURE addStadium
@stadium_name VARCHAR(20),
@location VARCHAR(20),
@capacity INT
AS
    INSERT INTO Stadium (name, location, capacity) VALUES (@stadium_name, @location, @capacity)

GO

CREATE PROCEDURE addStadiumManager
@stadium_manager_name VARCHAR(20),
@stadium_name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
DECLARE @stadium_id INT

    SELECT @stadium_id = S.id
    FROM Stadium S
    WHERE S.name = @stadium_name

    INSERT INTO SystemUser VALUES (@username, @password)
    INSERT INTO StadiumManager VALUES (@username, @stadium_manager_name, @stadium_id)

GO

CREATE PROCEDURE addTicket
@host_club_name VARCHAR(20),
@guest_club_name VARCHAR(20),
@start_time DATETIME
AS
DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT

    SELECT @host_id = C1.id, @guest_id = C2.id
    FROM Club C1, Club C2
    WHERE C1.name = @host_club_name AND C2.name = @guest_club_name

    SELECT @match_id = match_id
    FROM Match
    WHERE @host_id = host_club_id AND @guest_id = guest_club_id AND start_time = @start_time

    INSERT INTO Ticket (match_id) VALUES (@match_id)

GO

CREATE PROCEDURE allPendingRequestsGuest2
@sm_name VARCHAR(20), 
@host_name VARCHAR(20)
AS
    DECLARE @sm_id INT
    DECLARE @cr_id INT
    DECLARE @cr_name VARCHAR(20)
    DECLARE @match_id INT
    DECLARE @host_id INT

    SELECT @sm_id = id
    FROM StadiumManager
    WHERE @sm_name = username

    SELECT @cr_id = club_representative_id, @match_id = match_id
    FROM HostRequest
    WHERE stadium_manager_id = @sm_id

    SELECT @host_id = C.id 
    FROM Club C 
    WHERE C.name = @host_name 

    SELECT C2.name
    FROM ClubRepresentative CR
        INNER JOIN HostRequest HR ON HR.club_representative_id = CR.id
        INNER JOIN StadiumManager SM ON SM.id = HR.stadium_manager_id
        INNER JOIN Match M ON M.match_id = HR.match_id AND M.host_club_id = CR.club_id
        INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE HR.status = 'U' AND HR.match_id = @match_id
          AND SM.id = @sm_id AND CR.id = @cr_id
          AND CR.club_id = @host_id

GO

CREATE PROCEDURE allPendingRequestsHost2
@sm_name VARCHAR(20)
AS
    DECLARE @sm_id INT
    DECLARE @cr_id INT
    DECLARE @cr_name VARCHAR(20)
    DECLARE @match_id INT

    SELECT @sm_id = id
    FROM StadiumManager
    WHERE @sm_name = username

    SELECT @cr_id = club_representative_id, @match_id = match_id
    FROM HostRequest
    WHERE stadium_manager_id = @sm_id

    SELECT C1.name
    FROM ClubRepresentative CR
        INNER JOIN HostRequest HR ON HR.club_representative_id = CR.id
        INNER JOIN StadiumManager SM ON SM.id = HR.stadium_manager_id
        INNER JOIN Match M ON M.match_id = HR.match_id AND M.host_club_id = CR.club_id
        INNER JOIN Club C1 ON C1.id = CR.club_id
        INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE HR.status = 'U' AND HR.match_id = @match_id
        AND SM.id = @sm_id AND CR.id = @cr_id

GO

CREATE PROCEDURE allPendingRequestsTime2
@sm_name VARCHAR(20), 
@host_name VARCHAR(20), 
@guest_name VARCHAR(20)
AS
    DECLARE @sm_id INT
    DECLARE @cr_id INT
    DECLARE @cr_name VARCHAR(20)
    DECLARE @match_id INT
    DECLARE @host_id INT
    DECLARE @guest_id INT

    SELECT @sm_id = id
    FROM StadiumManager
    WHERE @sm_name = username

    SELECT @cr_id = club_representative_id, @match_id = match_id
    FROM HostRequest
    WHERE stadium_manager_id = @sm_id

    SELECT @host_id = C.id 
    FROM Club C 
    WHERE C.name = @host_name 

    SELECT @guest_id = C.id 
    FROM Club C 
    WHERE C.name = @guest_name 

    SELECT M.start_time
    FROM ClubRepresentative CR
        INNER JOIN HostRequest HR ON HR.club_representative_id = CR.id
        INNER JOIN StadiumManager SM ON SM.id = HR.stadium_manager_id
        INNER JOIN Match M ON M.match_id = HR.match_id AND M.host_club_id = CR.club_id
        INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE HR.status = 'U' AND HR.match_id = @match_id
          AND SM.id = @sm_id AND CR.id = @cr_id
          AND CR.club_id = @host_id
          AND C2.id = @guest_id

GO

CREATE PROCEDURE availableMatchesToAttendGuest
@host_name VARCHAR(20)
AS
DECLARE @host_id INT
    SELECT @host_id = C.id 
    FROM Club C
    WHERE C.name = @host_name

    SELECT DISTINCT C2.name
    FROM Club C1, Club C2, Match M, Stadium S, Ticket T
    WHERE C1.id = M.host_club_id AND C2.id = M.guest_club_id AND S.id = M.stadium_id
        AND T.match_id = M.match_id AND T.status = '1' AND M.start_time > CURRENT_TIMESTAMP AND C1.id = @host_id

GO

CREATE PROCEDURE availableMatchesToAttendHost
AS
    SELECT DISTINCT C1.name
    FROM Club C1, Club C2, Match M, Stadium S, Ticket T
    WHERE C1.id = M.host_club_id AND C2.id = M.guest_club_id AND S.id = M.stadium_id
        AND T.match_id = M.match_id AND T.status = '1' AND M.start_time > CURRENT_TIMESTAMP

GO

CREATE PROCEDURE availableMatchesToAttendTime
@host_name VARCHAR(20),
@guest_name VARCHAR(20)
AS
DECLARE @host_id INT
DECLARE @guest_id INT

    SELECT @host_id = C.id 
    FROM Club C
    WHERE C.name = @host_name

    SELECT @guest_id = C.id 
    FROM Club C
    WHERE C.name = @guest_name

    SELECT DISTINCT M.start_time
    FROM Club C1, Club C2, Match M, Stadium S, Ticket T
    WHERE C1.id = M.host_club_id AND C2.id = M.guest_club_id AND S.id = M.stadium_id
        AND T.match_id = M.match_id AND T.status = '1' AND M.start_time > CURRENT_TIMESTAMP 
        AND C1.id = @host_id AND C2.id = @guest_id

GO

CREATE PROCEDURE blockFan
@fan_id VARCHAR(20)
AS
    UPDATE Fan
    SET status = '0'
    WHERE national_id = @fan_id

GO

CREATE PROCEDURE deleteClub
@club_name VARCHAR(20)
AS
DECLARE @club_id INT
DECLARE @cr_id INT
DECLARE @cr_username VARCHAR(20)

    SELECT @club_id = C.id
    FROM Club C 
    WHERE @club_name = C.name

    SELECT @cr_id = CR.id, @cr_username = CR.username
    FROM ClubRepresentative CR 
    WHERE CR.club_id = @club_id

    UPDATE Match
    SET host_club_id = NULL
    WHERE @club_id = host_club_id AND start_time <= CURRENT_TIMESTAMP

    UPDATE Match
    SET guest_club_id = NULL
    WHERE @club_id = guest_club_id AND start_time <= CURRENT_TIMESTAMP

    DELETE FROM HostRequest
    WHERE club_representative_id = @cr_id

    DELETE FROM Match
    WHERE (host_club_id = @club_id OR guest_club_id = @club_id) AND start_time > CURRENT_TIMESTAMP

    DELETE FROM Club
    WHERE id = @club_id

    DELETE FROM SystemUser
    WHERE username = @cr_username

GO

CREATE PROCEDURE deleteMatch 
@host_club VARCHAR(20),
@guest_club VARCHAR(20),
@start_time DATETIME,
@end_time DATETIME
AS
DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT

    SELECT @host_id = C1.id, @guest_id = C2.id
    FROM Club C1, Club C2
    WHERE @host_club = C1.name AND @guest_club = C2.name

    SELECT @match_id = match_id
    FROM Match
    WHERE host_club_id = @host_id AND guest_club_id = @guest_id AND start_time = @start_time AND end_time = @end_time

    DELETE FROM HostRequest
    WHERE match_id = @match_id

    DELETE FROM Match
    WHERE match_id = @match_id

GO

CREATE PROCEDURE deleteMatchesOnStadium
@stadium_name VARCHAR(20)
AS
DECLARE @stadium_id INT
DECLARE @sm_id INT

    SELECT @stadium_id = S.id
    FROM Stadium S
    WHERE S.name = @stadium_name

    SELECT @sm_id = SM.id 
    FROM StadiumManager SM 
    WHERE SM.stadium_id = @stadium_id

    DELETE FROM HostRequest
    WHERE stadium_manager_id = @sm_id

    DELETE FROM Match
    WHERE stadium_id = @stadium_id AND start_time > CURRENT_TIMESTAMP

GO

CREATE PROCEDURE deleteStadium
@stadium_name VARCHAR(20)
AS  
DECLARE @stadium_id INT
DECLARE @sm_username VARCHAR(20)

    SELECT @stadium_id = id 
    FROM Stadium
    WHERE @stadium_name = name

    SELECT @sm_username = username 
    FROM StadiumManager
    WHERE stadium_id = @stadium_id

    DELETE FROM Stadium 
    WHERE @stadium_name = name

    DELETE FROM SystemUser
    WHERE @sm_username = username

GO

CREATE PROCEDURE purchaseTicket 
@national_id VARCHAR(20),
@host_name VARCHAR(20),
@guest_name VARCHAR(20),
@start_time DATETIME
AS
DECLARE @match_id INT
DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @ticket_id INT
DECLARE @flag BIT

    SELECT @flag = status 
    FROM Fan
    WHERE @national_id = national_id

    IF (@flag = '1')
    BEGIN

        SELECT @host_id = C1.id, @guest_id = C2.id
        FROM Club C1, Club C2
        WHERE C1.name = @host_name AND C2.name = @guest_name

        SELECT @match_id = match_id
        FROM Match
        WHERE @start_time = start_time AND @host_id = host_club_id AND @guest_id = guest_club_id AND start_time > CURRENT_TIMESTAMP

        UPDATE t
        SET fan_national_id = @national_id, status = '0'
        FROM Ticket t
        INNER JOIN
        (
        SELECT TOP 1 id
        FROM Ticket
        WHERE match_id = @match_id AND status = '1'
        GROUP BY id
        ) t2 ON t.id = t2.id
         

    END

GO

CREATE PROCEDURE rejectRequest
@sm_name VARCHAR(20),
@host_name VARCHAR(20),
@guest_name VARCHAR(20),
@start_time DATETIME
AS
DECLARE @sm_id INT
DECLARE @cr_id INT
DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT

    SELECT @host_id = C1.id
    FROM Club C1
    WHERE C1.name = @host_name

    SELECT @guest_id = C2.id
    FROM Club C2
    WHERE C2.name = @guest_name

    SELECT @sm_id = id
    FROM StadiumManager
    WHERE username = @sm_name

    SELECT @cr_id = id
    FROM ClubRepresentative
    WHERE club_id = @host_id

    SELECT @match_id = match_id
    FROM Match
    WHERE start_time = @start_time AND host_club_id = @host_id AND guest_club_id = @guest_id

    UPDATE HostRequest
    SET status = 'F'
    WHERE match_id = @match_id

GO

CREATE PROCEDURE unblockFan
@fan_id VARCHAR(20)
AS
    UPDATE Fan
    SET status = '1'
    WHERE national_id = @fan_id

GO

CREATE PROCEDURE updateMatchHost
@host_name VARCHAR(20),
@guest_name VARCHAR(20),
@start_time DATETIME
AS
DECLARE @match_id INT
DECLARE @host_id INT
DECLARE @guest_id INT

    SELECT @match_id = M.match_id, @host_id = C1.id, @guest_id = C2.id
    FROM Match M, Club C1, Club C2
    WHERE C1.name = @host_name AND C2.name = @guest_name
          AND M.host_club_id = C1.id AND M.guest_club_id = C2.id
          AND M.start_time = @start_time

    UPDATE Match 
    SET host_club_id = @guest_id, guest_club_id = @host_id
    WHERE match_id = @match_id

GO

CREATE FUNCTION allPendingRequests
(@sm_name VARCHAR(20))
RETURNS @table TABLE (ClubRepresentativeName VARCHAR(20), GuestName VARCHAR(20), StartTime DATETIME)
BEGIN
    DECLARE @sm_id INT
    DECLARE @cr_id INT
    DECLARE @cr_name VARCHAR(20)
    DECLARE @match_id INT

    SELECT @sm_id = id
    FROM StadiumManager
    WHERE @sm_name = username

    SELECT @cr_id = club_representative_id, @match_id = match_id
    FROM HostRequest
    WHERE stadium_manager_id = @sm_id

    INSERT INTO @table
    SELECT CR.name, C2.name, M.start_time
    FROM ClubRepresentative CR
        INNER JOIN HostRequest HR ON HR.club_representative_id = CR.id
        INNER JOIN StadiumManager SM ON SM.id = HR.stadium_manager_id
        INNER JOIN Match M ON M.match_id = HR.match_id AND M.host_club_id = CR.club_id
        INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE HR.status = 'U' AND HR.match_id = @match_id
        AND SM.id = @sm_id AND CR.id = @cr_id

    RETURN
END

GO

CREATE FUNCTION allPendingRequests1
(@sm_name VARCHAR(20))
RETURNS @table TABLE (ClubRepresentativeName VARCHAR(20), HostName VARCHAR(20), GuestName VARCHAR(20), StartTime DATETIME, EndTime DATETIME, Status CHAR(1))
BEGIN
    DECLARE @sm_id INT
    DECLARE @cr_id INT
    DECLARE @cr_name VARCHAR(20)
    DECLARE @match_id INT

    SELECT @sm_id = id
    FROM StadiumManager
    WHERE @sm_name = username

    SELECT @cr_id = club_representative_id, @match_id = match_id
    FROM HostRequest
    WHERE stadium_manager_id = @sm_id

    INSERT INTO @table
    SELECT CR.name, C1.name, C2.name, M.start_time, M.end_time, HR.[status]
    FROM ClubRepresentative CR
        INNER JOIN HostRequest HR ON HR.club_representative_id = CR.id
        INNER JOIN StadiumManager SM ON SM.id = HR.stadium_manager_id
        INNER JOIN Match M ON M.match_id = HR.match_id AND M.host_club_id = CR.club_id
        INNER JOIN Club C1 ON C1.id = CR.club_id
        INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE HR.match_id = @match_id
        AND SM.id = @sm_id AND CR.id = @cr_id

    RETURN
END

GO

CREATE FUNCTION allUnassignedMatches
(@club_name VARCHAR(20))
RETURNS @table TABLE (NameOfGuestClub VARCHAR(20), StartTime DATETIME)
 BEGIN
DECLARE @host_id INT

    SELECT @host_id = id
    FROM Club
    WHERE name = @club_name

    INSERT INTO @table
    SELECT C1.name, M.start_time
    FROM Match M, Club C1, Club C2
    WHERE M.guest_club_id = C1.id AND C2.id = M.host_club_id
        AND C2.id = @host_id AND M.stadium_id IS NULL
    RETURN
END

GO

CREATE FUNCTION availableMatchesToAttend
(@date DATETIME)
RETURNS @table TABLE (HostName VARCHAR(20), GuestName VARCHAR(20), StartTime DATETIME, StadiumName VARCHAR(20))
BEGIN
    INSERT INTO @table
    SELECT DISTINCT C1.name, C2.name, M.start_time, S.name
    FROM Club C1, Club C2, Match M, Stadium S, Ticket T
    WHERE C1.id = M.host_club_id AND C2.id = M.guest_club_id AND S.id = M.stadium_id
        AND T.match_id = M.match_id AND T.status = '1' AND M.start_time > @date
    RETURN
END

GO

CREATE FUNCTION availableMatchesToAttend1
(@date DATETIME)
RETURNS @table TABLE (HostName VARCHAR(20), GuestName VARCHAR(20), StadiumName VARCHAR(20), StadiumLocation VARCHAR(20))
BEGIN
    INSERT INTO @table
    SELECT DISTINCT C1.name, C2.name, S.name, S.location
    FROM Club C1, Club C2, Match M, Stadium S, Ticket T
    WHERE C1.id = M.host_club_id AND C2.id = M.guest_club_id AND S.id = M.stadium_id
        AND T.match_id = M.match_id AND T.status = '1' AND M.start_time > @date
    RETURN
END

GO

CREATE FUNCTION clubsNeverPlayed
(@club_name VARCHAR(20))
RETURNS @table TABLE(ClubNames VARCHAR(20))
BEGIN
DECLARE @club_id INT

    SELECT @club_id = id 
    FROM Club
    WHERE @club_name = name

    INSERT INTO @table
    SELECT C.name 
    FROM Club C 
    WHERE C.id <> @club_id
    EXCEPT (
        SELECT C1.name 
        FROM Club C1, Match M 
        WHERE ((M.host_club_id = C1.id AND M.guest_club_id = @club_id)
              OR (M.guest_club_id = C1.id AND M.host_club_id = @club_id))
              AND C1.id <> @club_id
    )
    ORDER BY C.name
    OFFSET 0 ROWS

    RETURN
END

GO

CREATE FUNCTION matchesRankedByAttendance
()
RETURNS @table TABLE (HostClub VARCHAR(20), GuestClub VARCHAR(20))
BEGIN
    INSERT INTO @table
    SELECT C1.name, C2.name 
    FROM Club C1 
         INNER JOIN Match M ON C1.id = M.host_club_id
         INNER JOIN Club C2 ON C2.id = M.guest_club_id
    WHERE M.match_id IN (
        SELECT M2.match_id
        FROM Match M2 INNER JOIN Ticket T ON T.match_id = M2.match_id
        WHERE T.status = '0'
        GROUP BY M2.match_id
        ORDER BY COUNT(T.match_id) DESC
        OFFSET 0 ROWS
    )
    RETURN
END

GO

CREATE FUNCTION matchWithHighestAttendance
()
RETURNS @table TABLE (HostingClub VARCHAR(20), GuestClub VARCHAR(20))
BEGIN
DECLARE @max INT

    SELECT @max = MAX(C)
    FROM (
        SELECT COUNT(T.match_id) AS C
        FROM Ticket T 
        WHERE T.status = '0'
        GROUP BY T.match_id
    ) AS X

    INSERT INTO @table
    SELECT C1.name, C2.name 
    FROM Club C1 
         INNER JOIN Match M ON C1.id = M.host_club_id
         INNER JOIN Club C2 ON C2.id = M.guest_club_id
    WHERE M.match_id IN (
        SELECT M2.match_id 
        FROM Match M2 INNER JOIN Ticket T ON T.match_id = M2.match_id
        WHERE T.status = '0'
        GROUP BY M2.match_id
        HAVING COUNT(T.match_id) = @max
    )

    RETURN
END

GO

CREATE FUNCTION requestsFromClub
(@stadium_name VARCHAR(20), @host_name VARCHAR(20))
RETURNS @table TABLE (HostName VARCHAR(20), GuestName VARCHAR(20))
BEGIN
    INSERT INTO @table
    SELECT C1.name, C2.name
    FROM Club C1, Club C2, Stadium S, Match M, HostRequest HR
    WHERE S.name = @stadium_name AND C1.name = @host_name
          AND M.stadium_id = S.id AND M.host_club_id = C1.id
          AND M.guest_club_id = C2.id AND HR.match_id = M.match_id
    RETURN
END

GO

CREATE FUNCTION upcomingMatchesOfClub
(@club_name VARCHAR(20))
RETURNS @table TABLE (GivenName VARCHAR(20), CompetingName VARCHAR(20), StartTime DATETIME, StadiumName VARCHAR(20))
BEGIN
DECLARE @club_id INT

    SELECT @club_id = id 
    FROM Club
    WHERE @club_name = name

    INSERT INTO @table
    SELECT C1.name, C2.name, M.start_time, S.name
    FROM Club C1, Club C2, Match M, Stadium S
    WHERE C1.name = @club_name
        AND ((C1.id = M.host_club_id AND C2.id = M.guest_club_id)
        OR (C2.id = M.host_club_id AND C1.id = M.guest_club_id))
        AND M.stadium_id = S.id
        AND M.start_time > CURRENT_TIMESTAMP

    INSERT INTO @table
    SELECT C1.name, C2.name, M.start_time, 'NULL'
    FROM Club C1, Club C2, Match M
    WHERE C1.name = @club_name
        AND ((C1.id = M.host_club_id AND C2.id = M.guest_club_id)
        OR (C2.id = M.host_club_id AND C1.id = M.guest_club_id))
        AND M.start_time > CURRENT_TIMESTAMP
        AND M.stadium_id IS NULL

    RETURN
END

GO

CREATE FUNCTION viewAvailableStadiumsOn
(@time DATETIME)
RETURNS @table TABLE (Name VARCHAR(20), Location VARCHAR(20), Capacity INT)
BEGIN
    INSERT INTO @table
    SELECT S.name, S.location, S.capacity
    FROM Stadium S
    WHERE S.status = '1' AND NOT EXISTS (
       SELECT M.start_time
       FROM Match M
       WHERE M.start_time = @time AND M.stadium_id = S.id
      )
    RETURN
END

GO

CREATE FUNCTION viewMyStadium
(@username VARCHAR(20))
RETURNS @table TABLE (StadiumID INT, StadiumName VARCHAR(20), StadiumLocation VARCHAR(20), StadiumCapacity VARCHAR(20), StadiumStatus BIT)
BEGIN
    INSERT INTO @table
    SELECT S.id, S.name, S.[location], S.capacity, S.[status]
    FROM StadiumManager SM INNER JOIN Stadium S ON SM.stadium_id = S.id
    WHERE SM.username = @username
    RETURN
END