use rcttc;

-- select *
-- from Performance
-- where [date] between '2021-10-01' and '2021-12-31';

-- select distinct *
-- from Customer;

-- Assuming .com.___ are counted as .com email addresses
-- select *
-- from Customer
-- where Email not like '%.com%';

-- Find the three cheapest shows.
-- select distinct top(3)
--     Ticket.PerformanceId,
--     t.[Name] 'Theater',
--     s.ShowName,
--         p.[Date],
--     Ticket.Price
-- from Ticket
-- left outer join Performance p on Ticket.PerformanceId = p.PerformanceId
-- left outer join Show s on p.ShowId = s.ShowId
-- left outer join Theater t on p.TheaterId = t.TheaterId
-- order by price asc;

-- List customers and the show they're attending with no duplication.
-- SELECT distinct 
--     Ticket.CustomerId,
--     Ticket.PerformanceId,
--     c.FirstName + ' ' + c.LastName 'Customer',
--     t.[Name] 'Theater',
--     s.ShowName,
--     p.[Date]
-- from Ticket
-- left outer join Performance p on Ticket.PerformanceId = p.PerformanceId
-- left outer join Show s on p.ShowId = s.ShowId
-- left outer join Theater t on p.TheaterId = t.TheaterId
-- left outer join Customer c on Ticket.CustomerId = c.CustomerId
-- order by CustomerId;

-- List customer, show, theater, and seat number in one query.
-- select
--     c.FirstName + ' ' + c.LastName 'Customer',
--     s.ShowName,
--     t.[Name] 'Theater',
--     Ticket.Seat
-- from Ticket
-- left outer join Customer c on Ticket.CustomerId = c.CustomerId
-- left outer join Performance p on Ticket.PerformanceId = p.PerformanceId
-- left outer join Show s on p.ShowId = s.ShowId
-- left outer join Theater t on p.TheaterId = t.TheaterId;

-- Find customers without an address.
-- SELECT *
-- FROM Customer
-- where Address is null;

-- Recreate the spreadsheet data with a single query.
-- select
--     c.FirstName 'customer_first',
--     c.LastName 'customer_last',
--     c.Email 'customer_email',
--     c.Phone 'customer_phone',
--     c.[Address] 'customer_address',
--     Ticket.seat ,
--     s.ShowName 'show',
--     Ticket.Price 'ticket_price',
--     p.[date],
--     t.[Name] 'theater',
--     t.[Address] 'theater_address',
--     t.Phone 'theater_phone',
--     t.Email 'theater_email'
-- from Ticket
-- left outer join Customer c on Ticket.CustomerId = c.CustomerId
-- left outer join Performance p on Ticket.PerformanceId = p.PerformanceId
-- left outer join Show s on p.ShowId = s.ShowId
-- left outer join Theater t on p.TheaterId = t.TheaterId
-- order by t.[Name] asc, s.ShowName asc, p.[Date] asc, Ticket.Seat asc;


-- Count total tickets purchased per customer.
-- select
--     c.FirstName + ' ' + c.LastName 'CustomerName',
--     count(c.CustomerId) 'TotalTickets'
-- from Customer c
-- left outer join Ticket t on c.CustomerId = t.CustomerId
-- group by c.FirstName + ' ' + c.LastName;


-- Calculate the total revenue per show based on tickets sold.
-- select
--     s.ShowName,
--     count(s.ShowName) 'TicketsSold',
--     count(s.ShowName) * Ticket.Price as 'TotalRevenue'
-- --    sum(Ticket.Price) 'TotalRevenue'
-- from Ticket
-- left outer join Performance p on Ticket.PerformanceId = p.PerformanceId
-- left outer join Show s on p.ShowId = s.ShowId
-- group by s.ShowName, Ticket.Price;


-- Calculate the total revenue per theater based on tickets sold.
-- select
--     t.[Name] 'Theater',
--     count(t.[Name]) 'TicketsSold',
--     sum(Ticket.Price) 'Total Revenue'
-- from Ticket
-- left outer join Performance p on Ticket.PerformanceId = p.PerformanceId
-- left outer join Theater t on p.TheaterId = t.TheaterId
-- group by t.[Name];

-- Who is the biggest supporter of RCTTC? Who spent the most in 2021?
-- select top (1)
--     c.FirstName + ' ' + c.LastName 'CustomerName',
--     sum(t.Price) 'Total'
-- from Ticket t
-- left outer join Customer c on t.CustomerId = c.CustomerId
-- group by c.FirstName + ' ' + c.LastName
-- order by 'Total' desc;