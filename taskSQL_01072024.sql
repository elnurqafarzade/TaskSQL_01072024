Create Database KitabxanaDB

Use KitabxanaDB


Create Table Authors (
Id int Primary Key identity(1,1),
Name Nvarchar(100) not null, 
Surname Nvarchar(100) not null
)


Insert into Authors (Name, Surname) Values 
('Friedrich Wilhelm', 'Nietzsche'),('George', 'Orwell'), ('Diamond', 'Tema')


Create Table Books (
Id int Primary Key identity(1,1),
Name Nvarchar(100) not null,
AuthorId int,
PageCount int,
Foreign Key(AuthorId) references Authors(Id)
)


Insert into Books (Name, AuthorId, PageCount) Values 
('Antixrist', 1, 450),('1984', 2, 300),('Agnostisizm ve Ilahi Tragedya', 3, 350),('Belə Buyurdu Zərdüşt', 1, 250)


Create view BooksAuthorsView as
Select bk.Id, bk.Name, bk.PageCount,(ath.Name + ' ' + ath.Surname) as AuthorFullName from  Books bk Join Authors ath on bk.AuthorId = ath.Id


Create procedure SearchBooks  @axtaris Nvarchar(100)as
Select bk.Id, bk.Name, bk.PageCount, (ath.Name + ' ' + ath.Surname) as AuthorFullName from Books bk
 Join Authors ath on bk.AuthorId = ath.Id where bk.Name like '%' + @axtaris + '%' or (ath.Name + ' ' + ath.Surname) like '%' + @axtaris + '%'
  
Exec SearchBooks @axtaris = 'Agno';


 Create view AuthorsBooksView as
Select ath.Id, (ath.Name + ' ' + ath.Surname) as FullName, COUNT(bk.Id) as BooksCount,MAX(bk.PageCount) as MaxPageCount from Authors ath
inner Join Books bk on ath.Id = bk.AuthorId Group by ath.Id, ath.Name, ath.Surname

Select * from BooksAuthorsView
Select * from AuthorsBooksView