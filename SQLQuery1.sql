-- ۱. پاک‌سازی رکوردهای احتمالی قبلی برای این شرکت خاص
DELETE FROM [FinancialAccounts] WHERE [CompanyId] = '3fa85f64-5717-4562-b3fc-2c963f66afa6';

-- ۲. تعریف متغیرهای کلیدی برای حساب‌های سطح گروه (کل)
DECLARE @AssetsId UNIQUEIDENTIFIER = '11111111-1111-1111-1111-111111111111';
DECLARE @LiabilitiesId UNIQUEIDENTIFIER = '22222222-2222-2222-2222-222222222222';
DECLARE @EquityId UNIQUEIDENTIFIER = '33333333-3333-3333-3333-333333333333';
DECLARE @RevenueId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444444';
DECLARE @ExpensesId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555555';

-- ۳. تزریق حساب‌های سطح ۱ (گروه حساب‌ها منطبق بر IFRS)
INSERT INTO [FinancialAccounts] ([Id], [CompanyId], [Code], [NameFa], [NameEn], [ParentId], [Level], [Nature], [CurrencyId]) VALUES
(@AssetsId, '3fa85f64-5717-4562-b3fc-2c963f66afa6', '1', N'دارایی‌ها', 'Assets', NULL, 1, 1, NULL),
(@LiabilitiesId, '3fa85f64-5717-4562-b3fc-2c963f66afa6', '2', N'بدهی‌ها', 'Liabilities', NULL, 1, 2, NULL),
(@EquityId, '3fa85f64-5717-4562-b3fc-2c963f66afa6', '3', N'حقوق صاحبان سهام', 'Equity', NULL, 1, 2, NULL),
(@RevenueId, '3fa85f64-5717-4562-b3fc-2c963f66afa6', '4', N'درآمدها', 'Revenue', NULL, 1, 2, NULL),
(@ExpensesId, '3fa85f64-5717-4562-b3fc-2c963f66afa6', '5', N'هزینه‌ها', 'Expenses', NULL, 1, 1, NULL);

-- ۴. تزریق حساب‌های سطح ۲ (معین‌های کاربردی و مشترک برای صنعت، صرافی و سایر کسب‌وکارها)
INSERT INTO [FinancialAccounts] ([Id], [CompanyId], [Code], [NameFa], [NameEn], [ParentId], [Level], [Nature], [CurrencyId]) VALUES
('2a111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '101', N'موجودی کالا و مواد اولیه', 'Inventories', @AssetsId, 2, 1, NULL),
('2b111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '102', N'کنترل کالای در جریان ساخت', 'Work in Progress (WIP)', @AssetsId, 2, 1, NULL),
('2c111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '103', N'موجودی نقد و بانک (ارزی/ریالی)', 'Cash and Cash Equivalents', @AssetsId, 2, 1, NULL),
('2d111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '501', N'هزینه دستمزد مستقیم تولید', 'Direct Labor Costs', @ExpensesId, 2, 1, NULL),
('2e111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '502', N'هزینه استهلاک ماشین‌آلات', 'Depreciation Expenses', @ExpensesId, 2, 1, NULL),
('2f111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '503', N'هزینه سربار جذب نشده', 'Unallocated Overheads', @ExpensesId, 2, 1, NULL),
('2g111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '504', N'زیان ناشی از تسعیر ارز', 'Foreign Exchange Loss', @ExpensesId, 2, 1, NULL),
('2h111111-1111-1111-1111-111111111111', '3fa85f64-5717-4562-b3fc-2c963f66afa6', '401', N'سود ناشی از تسعیر ارز', 'Foreign Exchange Gain', @RevenueId, 2, 2, NULL);