use master;
GO
drop DATABASE if exists rcttc;
GO
create DATABASE rcttc;
GO
use rcttc;
GO

create table Customer(
    CustomerId int primary key identity (1,1),
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Email varchar(50) not null,
    Phone varchar(50) null,
    [Address] varchar(50) null
);

create table Show(
    ShowId int primary key IDENTITY(1,1),
    ShowName varchar(50) not null
);

create table Theater(
    TheaterId int primary key identity(1,1),
    [Name] varchar(50) not null,
    Email varchar(50) not null,
    Phone varchar(50) not null,
    [Address] varchar(50) not null
);

create table Performance(
    PerformanceId int primary key identity(1,1),
    [Date] date not null,
    TheaterId int not null,
    ShowId int not null,
    CONSTRAINT fk_Performance_TheaterId
        foreign key (TheaterId)
        references Theater(TheaterId),
    CONSTRAINT fk_Performance_ShowId
        foreign key (ShowId)
        references Show(ShowId)
);

create table Ticket(
    TicketId int primary key identity(1,1),
    Seat varchar(10) not null,
    Price decimal(8,2) not null,
    CustomerId int not null,
    PerformanceId int not null,
    CONSTRAINT fk_Ticket_CustomerId
        foreign key (CustomerId)
        references Customer(CustomerId),
    CONSTRAINT fk_Ticket_PerformanceId
        foreign key (PerformanceId)
        references Performance(PerformanceId),
);