use ExerciseDB

create table Student(Sid int primary key, SName nvarchar(50), SEmail nvarchar(50), SContact nvarchar(10))

insert into Student values(1,'Shivam','shivam.sharma@genpact.com',9876543210)
insert into Student values(2,'Daksh','daksh.dagar@gmail.com',8975640123)
insert into Student values(3,'Manav','manav.yadav@gmail.com',9780562431)

Create table Fee(Sid int foreign key references Student(Sid), SFee float, SMonth int, SYear int, constraint PkFee primary key(Sid,SMonth,SYear))

insert into Fee values(2,10000, 5,2023)
insert into Fee values(1,12005.0, 1,2023)
insert into Fee values(2,90000, 2,2023)
insert into Fee values(3,11000.99, 7,2023)

create table PayConfirmation(Sid int, Name varchar(50),Email nvarchar(50), Fee float, PaidOnDate datetime)

create trigger trgFeePayConfirmation
on Fee
after insert
As
declare @id int
declare @SFees float
declare @name nvarchar(50)
declare @email nvarchar(50)
select @id = Sid from inserted
select @SFees = @SFees from inserted
begin
select @name = SName, @email = SEMail from Student where Sid = @id
insert into PayConfirmation values (@id,@name,@email, @SFees,GETDATE())
print 'Pay Confirmation Table Updated'
rollback
end

Select * from Student
Select * from Fee
Select * from PayConfirmation

