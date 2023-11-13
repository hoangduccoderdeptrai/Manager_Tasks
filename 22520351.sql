-- 1. BÀI TẬP 1
--III.12

-- SELECT DISTINCT SOHD FROM CTHD 
-- WHERE MASP IN('BB01','BB02') AND SL BETWEEN 10 AND 20

-- III.13

-- SELECT SOHD FROM CTHD 
-- WHERE MASP ='BB01' AND SL BETWEEN 10 AND 20
-- INTERSECT
-- SELECT SOHD FROM CTHD 
-- WHERE MASP ='BB02' AND SL BETWEEN 10 AND 20

-- 2.BÀI TẬP 2
-- II.1

-- UPDATE GIAOVIEN
-- SET MUCLUONG =1.2*MUCLUONG
-- WHERE GIAOVIEN.MAGV IN (SELECT DISTINCT TRGKHOA FROM KHOA  )

-- II.2
-- WITH TEMP AS(
--     SELECT KQ.MAHV,AVG(KQ.DIEM) AS DIEMTB FROM KETQUATHI AS KQ
--     INNER JOIN (
--         SELECT MAHV,MAMH,MAX(LANTHI) AS  MAX_LANTHI FROM KETQUATHI
--         GROUP BY MAHV,MAMH

--     ) AS KQ_MAX
--     ON KQ.MAHV =KQ_MAX.MAHV AND KQ.LANTHI =KQ_MAX.MAX_LANTHI AND KQ.MAMH =KQ_MAX.MAMH
--     GROUP BY KQ.MAHV
-- )
-- UPDATE HOCVIEN
-- SET HOCVIEN.DIEMTB =(SELECT DIEMTB FROM TEMP
--     WHERE HOCVIEN.MAHV=TEMP.MAHV
-- ) 

-- II.3	

-- UPDATE HOCVIEN
-- SET GHICHU='Cam thi'
-- WHERE MAHV IN(
--     SELECT  MAHV FROM KETQUATHI
--     WHERE LANTHI=3 AND DIEM <5
-- )

--II.4

-- UPDATE HOCVIEN
-- SET XEPLOAI = CASE
--     WHEN DIEMTB>= 9 THEN 'XS'
--     WHEN DIEMTB>=8 AND DIEMTB<9 THEN 'G'
--     WHEN DIEMTB>=6.5 AND DIEMTB<8 THEN 'K'
--     WHEN DIEMTB>=5 AND DIEMTB<6.5 THEN 'TB'
--     ELSE 'Y'
--     END

-- 3.BÀI TẬP 3
-- III.6

-- SELECT TENMH FROM MONHOC AS MH
-- CROSS JOIN GIAOVIEN AS GV
-- INNER JOIN GIANGDAY AS GD ON MH.MAMH =GD.MAMH AND GD.MAGV =GV.MAGV
-- WHERE GV.HOTEN ='Tran Tam Thanh' AND GD.HOCKY=1 AND NAM=2006


-- III.7
-- SELECT MAMH,TENMH FROM MONHOC
-- WHERE MAMH IN(
--     SELECT MAMH FROM GIANGDAY
--     INNER JOIN LOP ON LOP.MAGVCN =GIANGDAY.MAGV
--     WHERE LOP.MALOP ='K11' AND HOCKY=1 AND NAM=2006
-- )

--III.8
-- c1

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

-- c2

-- SELECT HO+' '+TEN FROM HOCVIEN AS HV
-- WHERE HV.MAHV IN (
--     SELECT LOP.TRGLOP FROM LOP
--     CROSS JOIN GIAOVIEN AS GV
--     INNER JOIN MONHOC ON LOP.MAGVCN =GV.MAGV AND GV.MAKHOA =MONHOC.MAKHOA
--     WHERE GV.HOTEN ='Nguyen To Lan' and MONHOC.TENMH='Co So Du Lieu'


-- )

--III.9 In ra danh sách những môn học (mã môn học, tên môn học)
-- phải học liền trước môn “Co So Du Lieu”
-- C1

-- SELECT MAMH,TENMH FROM MONHOC AS MH
-- INNER JOIN DIEUKIEN AS DK ON DK.MAMH_TRUOC =MH.MAMH
-- WHERE DK.MAMH IN(
--     SELECT MAMH FROM MONHOC
--     WHERE TENMH ='Co So Du Lieu'
-- )
-- C2

-- SELECT MH.MAMH,TENMH FROM MONHOC AS MH 
-- WHERE MH.MAMH IN(
--     SELECT MAMH_TRUOC FROM DIEUKIEN AS DK
--     WHERE DK.MAMH IN(
--         SELECT MAMH FROM MONHOC
--         WHERE TENMH='Co So Du Lieu'
--     )
-- )

-- III.10 Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền 
-- trước những môn học (mã môn học, tên môn học) nào.

-- SELECT MAMH,TENMH FROM MONHOC AS MH
-- WHERE MH.MAMH IN(
--     SELECT MAMH FROM DIEUKIEN AS DK 
--     WHERE MAMH_TRUOC IN(
--         SELECT MAMH FROM MONHOC
--         WHERE TENMH='Cau Truc Roi Rac'
--     )
-- )

-- 4. Bài tập 4
-- III.14

-- SELECT MASP, TENSP
-- FROM SANPHAM 
-- WHERE NUOCSX = 'Trung Quoc' OR MASP IN (
-- 	SELECT DISTINCT CT.MASP 
-- 	FROM CTHD CT INNER JOIN HOADON HD
-- 	ON CT.SOHD = HD.SOHD
-- 	WHERE NGHD = '01/01/2007'
-- )

-- III.15
-- SELECT MASP,TENSP FROM SANPHAM
-- WHERE MASP NOT IN (SELECT DISTINCT MASP FROM CTHD )