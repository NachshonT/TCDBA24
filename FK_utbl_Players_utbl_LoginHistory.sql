USE [Casino]
GO

ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Players_utbl_LoginHistory] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_LoginHistory] ([PlayerId])
GO

ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_utbl_Players_utbl_LoginHistory]
GO

