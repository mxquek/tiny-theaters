use rcttc;

-- insert into Customer(FirstName, LastName, Email, Phone, [Address])
--     select distinct customer_first,customer_last,customer_email, customer_phone, customer_address
--     from [temp-rcttc-data];

-- insert into Theater([Name], [address], Phone, Email)
--     select distinct theater,theater_address,theater_phone,theater_email
--     from [temp-rcttc-data];

-- insert into Show (ShowName)
--     select distinct
--     Show
--     from [temp-rcttc-data];

-- insert into Performance([date], ShowId, TheaterId)
--     select distinct
--         temp.[date], s.ShowId, t.TheaterId
--     from [temp-rcttc-data] temp
--     inner join Show s on temp.show = s.ShowName
--     inner join Theater t on temp.theater = t.[Name]
--     order by temp.[date], t.TheaterId, s.ShowId;

-- insert into Ticket(Seat, Price, CustomerId, PerformanceId)
--     select
--         temp.seat, temp.ticket_price, c.CustomerId, p.PerformanceId
--     from [temp-rcttc-data] temp
--     inner join Show s on temp.show = s.ShowName
--     inner join Theater t on temp.theater = t.[Name]
--     inner join Customer c on temp.customer_email = c.Email
--     inner join Performance p on s.ShowId = p.ShowId
--                             and temp.[date] = p.[Date]
--                             and t.TheaterId = p.TheaterId
--     order by c.CustomerId;

drop table if exists [temp-rcttc-data];

--UPDATES
update Ticket
set
    Price = '22.25'
from Ticket t
left outer join Performance p on t.PerformanceId = p.PerformanceId
where
    p.ShowId = (select ShowId from Show where ShowName = 'The Sky Lit Up') and
    p.TheaterId = (select TheaterId from Theater where Theater.[Name] = 'Little Fitz') and
    p.[Date] = '2021-03-01';

--Validation
-- select *
-- from Ticket
-- where
--     PerformanceId = 6;
-- select *
-- from Ticket
-- where
--     PerformanceId = 6 and (
--     CustomerId = (select CustomerId from Customer where Customer.FirstName + ' ' + Customer.LastName = 'Pooh Bedburrow') or
--     CustomerId = (select CustomerId from Customer where Customer.FirstName + ' ' + Customer.LastName = 'Cullen Guirau'));

update Ticket set
    Seat = 'A4'
where 
    PerformanceId = 6 and
    Seat = 'C2';

update Ticket set
    Seat = 'B4'
where
    PerformanceId = 6 and
    CustomerId = (select CustomerId from Customer where Customer.FirstName + ' ' + Customer.LastName = 'Pooh Bedburrow') and
    Seat = 'A4';

update Ticket set
    Seat = 'C2'
where
    PerformanceId = 6 and
    CustomerId = (select CustomerId from Customer where Customer.FirstName + ' ' + Customer.LastName = 'Cullen Guirau') and
    Seat = 'B4';


update Customer set
    Phone = '1-801-EAT-CAKE'
where Customer.FirstName + ' ' + Customer.LastName = 'Jammie Swindles';

--DELETES

delete from Ticket
where Ticket.TicketId IN 
(
    SELECT
        Ticket.TicketId
    from Ticket
    left outer join
    (
        SELECT
            t.CustomerId 'CustomerId',
            count(t.CustomerId) 'NumOfTickets'
        from Ticket t
        left outer join Performance p on t.PerformanceId = p.PerformanceId
        where p.TheaterId = (select TheaterId from Theater where Theater.[Name] = '10 Pin')
        group by t.CustomerId
        having count(t.CustomerId) = 1
    ) t on Ticket.CustomerId = t.CustomerId
    where Ticket.CustomerId = t.CustomerId
);


delete from Ticket
where Ticket.TicketId IN
(
    select Ticket.TicketId
    from Ticket
    where Ticket.CustomerId = (select CustomerId from Customer where FirstName + ' ' + Customer.LastName = 'Liv Egle of Germany')
);
delete from Customer
where Customer.CustomerId = (select CustomerId from Customer where FirstName + ' ' + Customer.LastName = 'Liv Egle of Germany');