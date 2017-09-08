USE [auction]
GO
/****** Object:  Table [dbo].[tbItems]    Script Date: 04/08/2015 11:01:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbItems](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[item_name] [varchar](100) NOT NULL,
	[item_description] [varchar](1000) NULL,
	[item_date_open] [datetime] NOT NULL,
	[item_date_close] [datetime] NOT NULL,
	[item_seller] [varchar](50) NULL,
	[item_location] [varchar](50) NULL,
	[cat_id] [int] NULL,
	[img] [varchar](50) NULL,
 CONSTRAINT [PK_tbItems] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbCategories]    Script Date: 04/08/2015 11:01:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbCategories](
	[cat_id] [int] IDENTITY(1,1) NOT NULL,
	[cat_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbCategories] PRIMARY KEY CLUSTERED 
(
	[cat_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbBids]    Script Date: 04/08/2015 11:01:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbBids](
	[bid_id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] [int] NOT NULL,
	[item_amount] [smallmoney] NULL,
	[item_bidder] [varchar](30) NULL,
	[item_date_bid] [datetime] NOT NULL,
 CONSTRAINT [PK_auction_history] PRIMARY KEY CLUSTERED 
(
	[bid_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spTime]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spTime] AS

SELECT getdate() as auction_time
GO
/****** Object:  StoredProcedure [dbo].[spListings]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListings]  

@cat_id int 

AS

if @cat_id is null
begin

SELECT   	i.item_id,
		i.item_name,
		i.item_description,
		i.item_date_open,
		i.item_date_close,
		i.item_seller,
		i.item_location,
                          (SELECT     TOP 1 item_amount
                            FROM         dbo. tbBids
                            WHERE      tbBids.item_id = i.item_id
                            ORDER BY item_amount DESC) AS item_amount,

                          (SELECT     TOP 1 item_bidder
                            FROM          dbo.tbBids
                            WHERE      tbBids.item_id = i.item_id
                            ORDER BY item_amount DESC) AS item_bidder,

                          (SELECT     COUNT(0)
                            FROM          dbo.tbBids
                            WHERE      tbBids.item_id = i.item_id) AS item_bids,

		case when cat_id is not null then (select cat_name from tbCategories where cat_id = i.cat_id) 
		 else 'Everything Else' end as cat_name	

FROM         dbo.tbItems as i

end
else
begin

SELECT   	i.item_id,
		i.item_name,
		i.item_description,
		i.item_date_open,
		i.item_date_close,
		i.item_seller,
		i.item_location,
                          (SELECT     TOP 1 item_amount
                            FROM         dbo. tbBids
                            WHERE      tbBids.item_id = i.item_id
                            ORDER BY item_amount DESC) AS item_amount,

                          (SELECT     TOP 1 item_bidder
                            FROM          dbo.tbBids
                            WHERE      tbBids.item_id = i.item_id
                            ORDER BY item_amount DESC) AS item_bidder,

                          (SELECT     COUNT(0)
                            FROM          dbo.tbBids
                            WHERE      tbBids.item_id = i.item_id) AS item_bids,

		case when cat_id is not null then (select cat_name from tbCategories where cat_id = i.cat_id) 
		 else 'Everything Else' end as cat_name	

FROM         dbo.tbItems as i

where i.cat_id = @cat_id

end
GO
/****** Object:  StoredProcedure [dbo].[spListCategory]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spListCategory] AS

SELECT     c.cat_id, c.cat_name, COUNT(i.item_id) AS TOTAL_ITEMS
FROM         tbCategories c LEFT OUTER JOIN
                      tbItems i ON i.cat_id = c.cat_id
GROUP BY c.cat_id, c.cat_name
HAVING      COUNT(i.item_id) <> 0
UNION
SELECT     '0' AS cat_id, 'All' AS cat_name, COUNT(0) AS TOTAL_ITEMS
FROM         tbItems
GO
/****** Object:  StoredProcedure [dbo].[spListAllCategory]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spListAllCategory] AS

SELECT     c.cat_id, c.cat_name

FROM         tbCategories c
GO
/****** Object:  StoredProcedure [dbo].[spItemDetails]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spItemDetails]  

@item_id int

AS

SELECT     	item_name,
		item_description,
		item_date_close,
		item_seller,
		item_location,

                          (SELECT     TOP 1 item_amount
                            FROM          tbBids
                            WHERE      tbBids.item_id = i.item_id
                            ORDER BY item_amount DESC) AS item_amount,

                          (SELECT     TOP 1 item_bidder
                            FROM          tbBids
                            WHERE      tbBids.item_id = i.item_id
                            ORDER BY item_amount DESC) AS item_bidder,    

		 (SELECT     COUNT(0)
                            FROM          tbBids
                            WHERE      tbBids.item_id = i.item_id) AS item_bids,
		
		case when cat_id is not null then (select cat_name from tbCategories where cat_id = i.cat_id) 
		 else 'Everything Else' end as cat_name, img

FROM         tbItems as i
WHERE item_id=@item_id
GO
/****** Object:  StoredProcedure [dbo].[spCatName]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spCatName]

@cat_id int

AS

SELECT     cat_name
FROM         tbCategories
WHERE     (cat_id = @cat_id)
GO
/****** Object:  StoredProcedure [dbo].[spBidHistory]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBidHistory]  

@item_id int

AS

SELECT     item_date_bid, item_amount, item_bidder
FROM        tbBids
WHERE     (item_id = @item_id)
GO
/****** Object:  StoredProcedure [dbo].[spBid]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBid]

@item_id int,
@amount smallmoney,
@bidder varchar(30)

AS


declare @check_date datetime
declare @check_amount smallmoney

set @check_date = (SELECT item_date_close FROM tbItems WHERE item_id = @item_id) 
set @check_amount = (SELECT max(item_amount) FROM tbBids WHERE item_id = @item_id)

IF((@check_amount+0.09<@amount) OR @check_amount is null)AND (@check_date>GETDATE())
BEGIN

--update main item
--UPDATE    auction_items
--SET item_price = @amount ,item_bidder = @bidder           
--WHERE item_id = @item_id

--update history
INSERT INTO tbBids
                      (item_id,item_amount,item_bidder,item_date_bid)
VALUES     (@item_id,@amount,@bidder,getDate())

--updated
SELECT 1 AS [action]

END
ELSE
BEGIN

SELECT 0 AS [action]
END
GO
/****** Object:  StoredProcedure [dbo].[spAddAuction]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddAuction] 

@name varchar(100),
@description varchar(1000),
@closedate datetime,
@seller varchar(100),
@location varchar(100),
@cat int,
@img varchar(50)

AS

INSERT INTO tbItems
                      (item_name, item_description, item_date_open, item_date_close, item_seller, item_location, cat_id, img)
VALUES     (@name, @description, GETDATE(), @closedate, @seller, @location,@cat, @img)
GO
/****** Object:  StoredProcedure [dbo].[spTotalRaised]    Script Date: 04/08/2015 11:01:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spTotalRaised] AS

SELECT     MAX(item_amount) AS MAX_BID
INTO            #TEMP
FROM         tbBids
GROUP BY item_id

SELECT SUM(MAX_BID) FROM #TEMP
GO
