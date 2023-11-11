-- 1. BÀI TẬP 1
--III.12
-- 12.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, 
-- mỗi sản phẩm mua với số lượng từ 10 đến 20.

-- SELECT SOHD FROM CTHD 
-- WHERE MASP IN('BB01','BB02') AND SL BETWEEN 10 AND 20

-- 13.	Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, 
-- mỗi sản phẩm mua với số lượng từ 10 đến 20.
-- SELECT SOHD FROM CTHD 
-- WHERE MASP ='BB01' AND SL BETWEEN 10 AND 20
-- INTERSECT
-- SELECT SOHD FROM CTHD 
-- WHERE MASP ='BB02' AND SL BETWEEN 10 AND 20

-- 2.BÀI TẬP 2
--1.	Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.

-- UPDATE GIAOVIEN
-- SET MUCLUONG =1.2*MUCLUONG
-- WHERE GIAOVIEN.MAGV IN (SELECT DISTINCT TRGKHOA FROM KHOA  )

-- 2.	Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) 
-- của mỗi học viên (tất cả các môn học đều có hệ số 
-- 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).



-- SELECT MAHV,AVG(DIEM) AS DIEMTB FROM KETQUTHI AS KQ
-- INNER JOIN (
--     SELECT MAHV,MAMH,MAX(LANTHI) AS  MAX_LANTHI FROM KETQUATHI
--     GROUP BY MAHV,MAMH

-- ) AS KQ_MAX
-- ON KQ.MAHV =KQ_MAX.MAHV AND KQ.LANTHI =KQ_MAX.MAX_LANTHI AND KQ.MAMH =KQ_MAX.MAMH
-- GROUP BY KQ.MAHV


-- 3.	Cập nhật giá trị cho cột GHICHU là “Cam thi”
--  đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm.

-- UPDATE HOCVIEN
-- SET GHICHU='Cam thi'
-- WHERE MAHV IN(
--     SELECT  MAHV FROM KETQUATHI
--     WHERE LANTHI=3 AND DIEM <5
-- )

--4.
-- UPDATE HOCVIEN
-- SET XEPLOAI = CASE
--     WHEN DIEMTB>= 9 THEN 'XS'
--     WHEN DIEMTB>=8 AND DIEMTB<9 THEN 'G'
--     WHEN DIEMTB>=6.5 AND DIEMTB<8 THEN 'K'
--     WHEN DIEMTB>=5 AND DIEMTB<6.5 THEN 'TB'
--     ELSE 'Y'
--     END

-- 3.BÀI TẬP 3
--6.
-- 6.	Tìm tên những môn học mà giáo viên có 
-- tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.

-- SELECT TENMH FROM MONHOC AS MH
-- CROSS JOIN GIAOVIEN AS GV
-- INNER JOIN GIANGDAY AS GD ON MH.MAMH =GD.MAMH AND GD.MAGV =GV.MAGV
-- WHERE GV.HOTEN ='Tran Tam Thanh' AND GD.HOCKY=1 AND NAM=2006


-- 7.	Tìm những môn học (mã môn học, tên môn học)
--  mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
-- SELECT MAMH,TENMH FROM MONHOC
-- WHERE MAMH IN(
--     SELECT MAMH FROM GIANGDAY
--     INNER JOIN LOP ON LOP.MAGVCN =GIANGDAY.MAGV
--     WHERE LOP.MALOP ='K11' AND HOCKY=1 AND NAM=2006
-- )

--8.	Tìm họ tên lớp trưởng của các lớp mà giáo
-- viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.

-- SELECT HO + ' ' + TEN AS HOTEN FROM HOCVIEN
-- WHERE MAHV IN (
-- 	SELECT TRGLOP FROM LOP 
-- 	WHERE MALOP IN (
-- 		SELECT DISTINCT MALOP FROM GIANGDAY 
-- 		WHERE MAGV IN (
-- 			SELECT MAGV FROM GIAOVIEN WHERE HOTEN = 'Nguyen To Lan'
-- 		) AND MAMH IN (
-- 			SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu'
-- 		)
-- 	)
-- )


-- SELECT HO+' '+TEN FROM HOCVIEN AS HV
-- WHERE HV.MAHV IN (
--     SELECT LOP.TRGLOP FROM LOP
--     CROSS JOIN GIAOVIEN AS GV
--     INNER JOIN MONHOC ON LOP.MAGVCN =GV.MAGV AND GV.MAKHOA =MONHOC.MAKHOA
--     WHERE GV.HOTEN ='Nguyen To Lan' and GV.TENMH='Co So Du Lieu'


-- )

--9.	In ra danh sách những môn học (mã môn học, tên môn học)
-- phải học liền trước môn “Co So Du Lieu”

-- SELECT MAMH,TENMH FROM MONHOC AS MH
-- INNER JOIN DIEUKIEN AS DK ON DK.MAMH_TRUOC =MH.MAMH
-- WHERE DK.MAMH IN(
--     SELECT MAMH FROM MONHOC
--     WHERE TENMH ='Co So Du Lieu'
-- )

-- SELECT MAMH,TENMH FROM MONHOC AS MH 
-- WHERE MH.MAMH IN(
--     SELECT MAMH_TRUOC FROM DIEUKIEN AS DK
--     WHERE DK.MAMH IN(
--         SELECT MAMH FROM MONHOC
--         WHERE TENMH='Co So Du Lieu'
--     )
-- )

-- 10.	Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền 
-- trước những môn học (mã môn học, tên môn học) nào.

-- SELECT MAMH,TENMH FROM MONHOC AS MH
-- WHERE MH.MAMH IN(
--     SELECT MAMH FROM DIEUKIEN AS DK 
--     WHERE MAMH_TRUOC IN(
--         SELECT MAMH FROM MONHOC
--         WHERE TENMH='Cau Truc Roi Rac'
--     )
-- )