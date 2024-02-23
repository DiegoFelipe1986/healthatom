-- 1. Nombre, altura, y fecha de muerte de todos los titanes que hayan muerto por “Accidente”, ordenados cronológicamente.
SELECT titanes.nombre, titanes.altura, muertes.fecha 
FROM titanes JOIN muertes ON titanes.id = muertes.id_titan
WHERE muertes.causa = 'Accidente' 
ORDER BY muertes.fecha;

-- 2. Nombre y altura del titán más alto que haya matado el “Batallón 1”.
SELECT titanes.nombre, titanes.altura
FROM titanes
JOIN muertes ON titanes.id = muertes.id_titan
WHERE muertes.causa = 'Batallón 1'
ORDER BY titanes.altura DESC
LIMIT 1;

-- 3. Nombre y altura de titanes que no se han podido matar aún, junto con su último avistamiento (más reciente), ordenados por altura incrementalmente.
SELECT titanes.nombre, titanes.altura, MAX(avistamientos.fecha) AS ultimo_avistamiento
FROM titanes
LEFT JOIN muertes ON titanes.id = muertes.id_titan
LEFT JOIN avistamientos ON titanes.id = avistamientos.id_titan
WHERE muertes.id IS NULL
GROUP BY titanes.nombre, titanes.altura
ORDER BY titanes.altura ASC;

-- 4. Lista de titanes que hayan sido vistos más de una vez el mismo año, ordenados por nombre incrementalmente.
SELECT titanes.nombre, 
COUNT(avistamientos.id) AS cantidad_avistamientos 
FROM titanes JOIN avistamientos ON titanes.id = avistamientos.id_titan 
GROUP BY titanes.nombre, YEAR(avistamientos.fecha) 
HAVING COUNT(avistamientos.id) > 1 
ORDER BY titanes.nombre ASC;

-- 5. Lista de recursos que se han usado (recurso, cantidad, unidad) en matar titanes pequeños (<= 5 metros), agrupados por recurso y ordenados por cantidad.
SELECT recursos.nombre AS recurso, SUM(movimientos_recursos.cantidad) AS cantidad, recursos.unidad
FROM titanes
JOIN muertes ON titanes.id = muertes.id_titan
JOIN movimientos_recursos ON muertes.id = movimientos_recursos.id_muerte
JOIN recursos ON movimientos_recursos.id_recurso = recursos.id
WHERE titanes.altura <= 5
GROUP BY recursos.nombre, recursos.unidad
ORDER BY SUM(movimientos_recursos.cantidad) DESC;

-- 6. Recurso que se utiliza más comúnmente para matar titanes de 9 metros, ordenado por cantidad de usos descendiente.
SELECT recursos.nombre AS recurso, COUNT(*) AS cantidad_de_usos
FROM titanes
JOIN muertes ON titanes.id = muertes.id_titan
JOIN movimientos_recursos ON muertes.id = movimientos_recursos.id_muerte
JOIN recursos ON movimientos_recursos.id_recurso = recursos.id
WHERE titanes.altura = 9
GROUP BY recursos.nombre
ORDER BY COUNT(*) DESC;

-- 7. Lista de titanes con incongruencias en torno a sus fechas de muerte y avistamientos, ordenados por su identificador, incrementalmente.
SELECT titanes.id, titanes.nombre
FROM titanes
JOIN avistamientos ON titanes.id = avistamientos.id_titan
JOIN muertes ON titanes.id = muertes.id_titan
WHERE avistamientos.fecha > muertes.fecha
ORDER BY titanes.id ASC;

-- Extra: teoriza (no más de 1 párrafo) por qué podrían generarse estas incongruencias
/*
Las incongruencias entre las fechas de muerte y avistamientos de los titanes podrían deberse a varios factores:
La falta de precisión en la información recopilada, ya que la identificación exacta de la fecha de muerte de un 
titán podría ser difícil de determinar, especialmente en situaciones caóticas como un enfrentamiento con titanes.
También es posible que algunos titanes no mueran inmediatamente después de ser avistados, lo que podría generar 
discrepancias temporales entre los avistamientos y las muertes registradas.
*/