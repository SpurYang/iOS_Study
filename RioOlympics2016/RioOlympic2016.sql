drop table Events;

drop table Schedule;

create table Events (
EventsID             INTEGER                        not null,
EventName            VARCHAR(20),
EventIcon            VARCHAR(20),
KeyInfo              LONG VARBINARY,
BasicsInfo           LONG VARBINARY,
OlympicInfo          LONG VARBINARY,
primary key (EventsID)
);

create table Schedule (
ScheduleID           INTEGER                        not null,
EventsID             INTEGER,
GameDate             DATE,
GameTime             VARCHAR(20),
GameInfo             VARCHAR(500),
primary key (ScheduleID),
foreign key (EventsID)
      references Events (EventsID)
);

