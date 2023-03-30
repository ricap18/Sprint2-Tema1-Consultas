 --TIENDA--
 --1  
 SELECT nombre FROM productos
--3  
SELECT * FROM productos
--4  
SELECT nombre, precio, ROUND(precio / 0.93, 2)  FROM producto
--5  
SELECT nombre, precio AS  euros, ROUND(precio / 0.93, 2) AS dolares_estadounidenses FROM producto
--6    nombre en mayuscula
 SELECT UPPER (nombre), precio  FROM producto
 --7    nombre en minuscula
 SELECT LOWER (nombre), precio FROM producto
 --8  UPPER (LEFT (nombre, 2))  Las 2 primerasletras en mayuscula
 SELECT nombre, UPPER (LEFT (nombre, 2)) FROM fabricante
 --9   redondea precio
 SELECT nombre, ROUND (precio) FROM producto
 --10   sin decimales
 SELECT nombre, ROUND (precio, 0) FROM producto
 --11
 SELECT codigo_fabricante   FROM producto
 --12   elimina codigo repetido
 SELECT DISTINCT (codigo_fabricante)   FROM producto
 --13    orden ascendente
 SELECT  nombre  FROM fabricante ORDER BY nombre ASC
 --14   orden descendente
 SELECT  nombre  FROM fabricante ORDER BY nombre DESC
 --15
 SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC
 --16    limita a 5 filas
 SELECT * FROM fabricante LIMIT 5
 --17    imprime a partir de la fila 4 dos filas
 SELECT * FROM fabricante  LIMIT 3,2
 --18    el precio mas barato
 SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1
 --19    el precio mas caro
 SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1
 --20   
 SELECT nombre FROM producto where codigo_fabricante = 2
 --21  combina 2 tablas  
 SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
--22
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC 
--23
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto  INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
--24
SELECT  producto.nombre, producto.precio,  fabricante.nombre FROM producto  INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio ASC LIMIT 1
--25
SELECT  producto.nombre, producto.precio,  fabricante.nombre FROM producto    INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio DESC LIMIT 1
 --26
 SELECT  * FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Lenovo"
--27
SELECT * FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE  producto.precio > 200 AND fabricante.nombre = "crucial"
--28
SELECT * FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE  fabricante.nombre = "Asus" OR fabricante.nombre = "Hewlett-Packard" OR fabricante.nombre = "Seagate"
--29  filtra varios nombres 
SELECT * FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE   fabricante.nombre IN ('Asus', 'Hewlett-Packard',  'Seagate')
--30  "%e" acaben en e
SELECT producto.nombre, producto.precio  FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE  fabricante.nombre LIKE '%e'
--31
SELECT producto.nombre, producto.precio  FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE  fabricante.nombre LIKE '%w%'
--32
SELECT producto.nombre, producto.precio, fabricante.nombre  FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY  producto.precio DESC,  producto.nombre ASC
--33    DISTINCT   no se repiten los valores,  INNER JOIN enseña productos asociados de ambas tablas
SELECT DISTINCT fabricante.codigo, fabricante.nombre  FROM fabricante INNER JOIN producto ON producto.codigo_fabricante = fabricante.codigo
--34     LEFT JOIN da prioridd a la columna de la izquierda
SELECT   fabricante.nombre, producto.nombre  FROM fabricante LEFT JOIN producto ON producto.codigo_fabricante = fabricante.codigo
--35      productos que no coinciden con el fabricante
SELECT   fabricante.nombre  FROM fabricante WHERE codigo NOT IN (SELECT DISTINCT codigo_fabricante FROM producto)
--36
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
--37
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'))
--38
 SELECT  producto.nombre FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Lenovo" ORDER BY precio DESC LIMIT 1
--39
 SELECT  producto.nombre FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo  WHERE fabricante.nombre = "Hewlett-Packard" ORDER BY precio ASC LIMIT 1
--40
SELECT producto.nombre FROM producto WHERE precio >= (SELECT  producto.precio FROM producto   INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Lenovo" ORDER BY precio DESC LIMIT 1) 
--41     precio medio
SELECT * FROM producto, fabricante WHERE precio > (SELECT AVG(precio) FROM producto WHERE fabricante.nombre = "Asus")

--UNIVERSIDAD--
--1     Se puede asignar el orden con numeros  ORDER BY 1, 2, 3 ASC
 SELECT  apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY 1, 2, 3 ASC
--2    Cuando hace referencia a null  (IS NULL)
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL
--3   Cuenado compara el año  year(fecha_nacimiento) = ' '
SELECT * FROM persona WHERE tipo = 'alumno' AND  year(fecha_nacimiento) = '1999'
--4
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%k'
--5
SELECT * FROM asignatura WHERE cuatrimestre = 1 and curso = 3 and id_grado = 7 
--6
 SELECT  p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.nombre, dep.nombre  AS nombre_departamento FROM persona p INNER JOIN departamento dep ON  dep.id = p.id WHERE tipo = 'profesor'  ORDER BY 1, 2, 3 ASC
--7
SELECT  DISTINCT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura a INNER JOIN curso_escolar ce ON a.id = ce.id INNER JOIN  alumno_se_matricula_asignatura am ON ce.id = am.id_alumno INNER JOIN persona p ON am.id_alumno = p.id WHERE nif = '26902806M'
--8
SELECT dep.nombre AS departamento , per.nombre AS profesor , a.nombre AS asignatura FROM departamento dep INNER JOIN profesor pro ON dep.id = pro.id_departamento INNER JOIN persona per ON pro.id_departamento = per.id INNER JOIN asignatura a ON per.id = a.id INNER JOIN grado g ON a.id_grado = g.id WHERE per.tipo = 'profesor' AND g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
--9
SELECT per.nombre AS nombre, per.apellido1 AS primer_apellido, per.apellido2 AS segundo_apellido, a.nombre asignatura FROM persona per INNER JOIN alumno_se_matricula_asignatura am ON per.id = am.id_alumno INNER JOIN curso_escolar ce ON am.id_curso_escolar = ce.id INNER JOIN asignatura a ON am.id_asignatura = a.id WHERE per.tipo = 'alumno' AND ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019

--LEFT JOIN y RIGHT JOIN.
--1
SELECT dep.nombre AS nombre_departamento, per.apellido1 AS primer_apellido, per.apellido2 AS segundo_apellido, per.nombre AS nombre_profesor FROM persona per LEFT JOIN departamento dep ON per.id = dep.id WHERE per.tipo = 'profesor' ORDER BY 1, 2, 3, 4 ASC
--2
SELECT  per.apellido1 AS primer_apellido, per.apellido2 AS segundo_apellido, per.nombre AS nombre_profesor FROM persona per LEFT JOIN departamento dep ON per.id = dep.id WHERE per.tipo = 'profesor' AND dep.nombre IS null 
--3
SELECT per.nombre AS nombre_profesor, dep.nombre AS nombre_departamento FROM persona per  INNER JOIN profesor pro ON per.id = pro.id_profesor RIGHT JOIN departamento dep ON pro.id_departamento = dep.id WHERE per.nombre IS null
--4
SELECT  per.nombre AS nombre, per.apellido1 AS primer_apellido, per.apellido2 AS segundo_apellido, a.nombre AS asignatura  FROM persona per INNER JOIN profesor pro ON per.id = pro.id_profesor LEFT JOIN asignatura a ON pro.id_profesor = a.id_profesor WHERE  a.nombre  IS NULL 
--5
SELECT a.nombre AS Nombre_Asignatura FROM asignatura  a LEFT JOIN profesor pro  ON a.id_profesor = pro.id_profesor WHERE pro.id_profesor IS null
--6
SELECT dep.nombre AS Departamento, a.nombre AS Asignatura FROM departamento dep INNER JOIN profesor pro ON dep.id = pro.id_departamento INNER JOIN asignatura a ON pro.id_profesor = a.id_profesor LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura WHERE am.id_curso_escolar IS NULL

-- Consultas resumen: --
--1  numero de alumnos
SELECT count(tipo) AS Nº_Alumnos FROM persona WHERE tipo = 'alumno'
--2   cuantos nacieron en 
SELECT count(tipo) AS Nº_Alumnos FROM persona WHERE tipo = 'alumno' AND year(fecha_nacimiento) = '1999'
--3
SELECT dep.nombre AS Nombre_Departamento, COUNT(pro.id_departamento) AS Nº_Profesores FROM departamento dep INNER JOIN profesor pro ON dep.id = pro.id_departamento WHERE pro.id_departamento IS NOT null  GROUP BY pro.id_departamento ORDER BY 2  DESC
--4   GROUP BY   agrupa
SELECT dep.nombre AS Nombre_Departamento, COUNT(pro.id_departamento) AS Nº_Profesores FROM departamento dep LEFT JOIN profesor pro ON dep.id = pro.id_departamento GROUP BY dep.nombre ORDER BY 2 DESC
--5
SELECT g.nombre AS Grados, count(a.id_grado) AS Nº_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY 2 DESC
--6

--7

--8
SELECT ce.anyo_inicio AS Año_Inicio_Curso, count(am.id_alumno) AS Nº_Alumnos_Matriculados  FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar GROUP BY ce.anyo_inicio ORDER BY count(am.id_alumno)
--9
SELECT per.id As Id_Profesor, per.nombre AS Nombre_Profesor, per.apellido1 AS Primer_Apellido, per.apellido2 AS Segundo_Apellido, count(a.id_profesor) AS Nº_Asignaturas FROM asignatura a RIGHT JOIN profesor pro ON a.id_profesor = pro.id_profesor INNER JOIN persona per ON pro.id_profesor = per.id GROUP BY  pro.id_profesor ORDER BY count(a.id_profesor) DESC
--10
SELECT per.id AS Id_Alumno, per.nombre AS Nombre_Alumno, per.apellido1 AS Primer_Apellido, per.apellido2 AS Segundo_Apellido,  per.fecha_nacimiento  FROM persona per WHERE per.tipo = 'alumno' ORDER BY per.fecha_nacimiento DESC LIMIT 1
--11
SELECT DISTINCT per.nombre AS Nombre_Profesor, per.apellido1 AS Primer_Apellido, per.apellido2 AS Segundo_Apellido FROM persona per INNER JOIN profesor pro  ON per.id = pro.id_profesor INNER JOIN departamento dep ON pro.id_departamento = dep.id LEFT JOIN asignatura a ON dep.id = a.id_profesor WHERE a.id_profesor IS null







