create database HN_JV230313_phamtrunghai;
use HN_JV230313_phamtrunghai;
create table dmkhoa(
makhoa varchar (20) primary key,
tenkhoa  varchar(255)
);
create table dmnganh(
manganh int primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key (makhoa) references dmkhoa(makhoa)
);
create table dmlop(
malop varchar(20) primary key,
tenlop varchar(255),
manganh int,

khoahoc int,
hedt varchar(255),
namnhaphoc int,
foreign key (manganh) references dmnganh(manganh)
);
create table sinhvien(
masv int primary key,
hoten varchar(20),
malop varchar(20),
foreign key (malop) references dmlop(malop),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255)
);
create table dmhocphan(
mahp int primary key,
tenhp varchar(255),
sodvht int,
manganh int,
foreign key (manganh) references dmnganh(manganh),
hocky int
);
create table diemhp(

masv int,
mahp int,
diemhp float,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp)
);
insert into dmkhoa (makhoa, tenkhoa)
values
    ('CNTT', 'Công nghệ thông tin'),
    ('KT', 'Kế Toán'),
    ('SP', 'Sư phạm');

insert into dmnganh (MaNganh, Tennganh, MaKhoa)
values
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng','CNTT');

insert into dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
values
    ('CT11', 'Cao đẳng tin học', '480202', 11, 'TC', 2013),
    ('CT12', 'Cao đẳng tin học', '480202', 12, 'CĐ', 2013),
    ('CT13', 'Cao đẳng tin học', '480202', 13, 'TC', 2014);

insert into dmhocphan (MaHP, TenHP, Sodvht, MaNganh, Hocky)
values
    (1, 'Toán cấp cấp A1', 4, '480202', 1),
    (2, 'Tiếng Anh 1', 3, '480202', 1),
    (3, 'Vật lý đại cương', 4, '480202', 1),
    (4, 'Tiếng Anh 2', 7, '480202', 1),
    (5, 'Tiếng Anh 1', 3, '140902', 2),
    (6, 'Xác suất thống kê', 3, '480202', 2);

insert into sinhvien (MaSV, HoTen, MaLop, Gioitinh, NgaySinh, DiaChi)
values
    (1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
    (2, 'Nguyễn Thị Cẩm CT12', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
    (3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
    (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
    (5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
    (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
    (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù Mỹ'),
    (8, 'Nguyễn Văn Huy CT11', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
    (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

insert into diemhp(masv,mahp,diemhp)values
(2,2,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4),
(7,1,6.2);
-- 1.	 Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5     (5đ)
select sv.masv , sv.hoten , sv.malop , dhp.diemhp , dhp.mahp
from sinhvien sv
join diemhp  dhp on sv.masv = dhp.masv
where dhp.diemhp >= 5;
-- 2.	Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. (5đ)
select sv.masv, sv.hoten, sv.malop , dhp.diemhp, dhp.mahp
from sinhvien  sv
JOIN diemhp dhp on sv.masv = dhp.masv
order by  sv.malop asc, sv.hoten asc;
-- 3.	Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5  7 ở học kỳ I. (5đ)
select sv.masv, sv.hoten , sv.malop , dhp.diemhp , hp.hocky 
from sinhvien  sv
join diemhp  dhp on sv.masv = dhp.masv
join dmhocphan  hp on dhp.mahp = hp.mahp
where dhp.diemhp between 5 and 7 and hp.hocky = 1;
-- 4.	Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)
select sv.masv, sv.hoten, sv.malop , dl.tenlop , kh.makhoa 
from sinhvien  sv
join dmlop  dl on sv.malop = dl.malop
join dmnganh  ng on dl.manganh = ng.manganh
join dmkhoa  kh on ng.makhoa = kh.makhoa
where kh.makhoa = 'CNTT';
-- 5.	Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)
select dl.malop, dl.tenlop , count(sv.masv) as SiSo
from dmlop  dl
 join sinhvien  sv on dl.malop = sv.malop
group by dl.malop, dl.tenlop;
-- 6.	Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ
select sv.masv , hp.hocky , sum(dhp.diemhp * hp.sodvht) / sum(hp.sodvht) as DiemTrungBinh
from sinhvien  sv
join diemhp  dhp on sv.masv = dhp.masv
join dmhocphan  hp on dhp.mahp = hp.mahp
group by sv.masv, hp.hocky;
-- 7.	Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select dl.malop, dl.tenlop,
       sum(case when sv.gioitinh = 1 then 1 else 0 end) as SoLuongNam,
       sum(case when sv.gioitinh = 0 then 1 else 0 end) as SoLuongNu
from dmlop dl
join sinhvien sv on dl.malop = sv.malop
group by dl.malop, dl.tenlop;
-- 8.	Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1. 
select sv.masv, hp.hocky ,
       sum(dhp.diemhp * hp.sodvht) / sum(hp.sodvht) as DiemTrungBinh
from sinhvien  sv
join diemhp  dhp on sv.masv = dhp.masv
join dmhocphan  hp on dhp.mahp = hp.mahp
where hp.hocky = 1
group by sv.masv, hp.hocky;
-- 9.	Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên

select sv.masv , sv.hoten ,
       count(case when dhp.diemhp < 5 then 1 end) as soluong
from sinhvien  sv
 join diemhp  dhp on sv.masv = dhp.masv
group by sv.masv, sv.hoten
having soluong>=1;
-- 10.	Đếm số sinh viên có điểm HP <5 của mỗi học phần
select hp.mahp , hp.tenhp ,
       count(case when dhp.diemhp < 5 then 1 end) as SoSinhVienDuoiDiem
from dmhocphan  hp
left join diemhp  dhp on hp.mahp = dhp.mahp
group by hp.mahp, hp.tenhp
having SoSinhVienDuoiDiem>=1;
-- 11.	Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên
select sv.masv , sv.hoten ,
       sum(case when dhp.diemhp < 5 then hp.sodvht end) as TongDVHTDuoiDiem
from sinhvien  sv
left join diemhp  dhp on sv.masv = dhp.masv
left join dmhocphan  hp on dhp.mahp = hp.mahp
group by sv.masv, sv.hoten
having TongDVHTDuoiDiem>=1;
-- 12.	Cho biết MaLop, TenLop có tổng số sinh viên >2.
select dl.malop, dl.tenlop ,count(sv.masv) as SiSo
from dmlop dl
left join sinhvien  sv on dl.malop = sv.malop
group by dl.malop, dl.tenlop
having count(sv.masv) > 2;

-- 13.	Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5. (10đ)
select sv.hoten , count(dhp.mahp) as soluong
from sinhvien  sv
join diemhp dhp on sv.masv = dhp.masv
where dhp.diemhp < 5
group by sv.masv, sv.hoten
having count(dhp.mahp) >= 2;

-- 14.	Cho biết HoTen sinh viên học ít nhất 3 học phần mã 1,2,3 (10đ)
select sv.hoten , count(distinct dhp.mahp) as soluong
from sinhvien  sv
join diemhp  dhp on sv.masv = dhp.masv
where dhp.mahp in (1, 2, 3)
group by sv.masv, sv.hoten
having count(distinct dhp.mahp) >= 3;
