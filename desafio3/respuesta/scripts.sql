-- Escribe (en MySQL) los cambios que harías al modelo de datos para soportar y servir esta información. 
-- Luego, con el modelo de datos nuevo, escriba una consulta que rescate aquella persona que más titanes mató durante el año 2020.

-- 1. Agregar una tabla para los responsables de la información:
CREATE TABLE IF NOT EXISTS `responsables` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 2. ALTER TABLE `avistamientos`
ADD COLUMN `id_responsable` INT(11) NOT NULL,
ADD COLUMN `fecha_reporte` DATETIME NOT NULL,
ADD CONSTRAINT `avistamientos_id_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `responsables` (`id`);

-- 3. Enlazar la tabla 'avistamientos' con la tabla 'responsables' para registrar quién reportó cada avistamiento:
ALTER TABLE `avistamientos`
ADD COLUMN `id_responsable` INT(11) NOT NULL,
ADD COLUMN `fecha_reporte` DATETIME NOT NULL,
ADD CONSTRAINT `avistamientos_id_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `responsables` (`id`);

-- 4. Agregar una tabla para registrar quién autorizó o gestionó cada movimiento de recurso:

CREATE TABLE IF NOT EXISTS `autorizaciones` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_responsable` INT(11) NOT NULL,
  `id_movimiento_recursos` INT(11) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `autorizaciones_id_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `responsables` (`id`),
  CONSTRAINT `autorizaciones_id_movimiento_recursos` FOREIGN KEY (`id_movimiento_recursos`) REFERENCES `movimientos_recursos` (`id`)
);

-- 5. Agregar una columna en la tabla muertes para registrar quién ejecutó la muerte de cada titán:
ALTER TABLE `muertes`
ADD COLUMN `id_responsable` INT(11) NOT NULL,
ADD CONSTRAINT `muertes_id_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `responsables` (`id`);

-- 6. Para encontrar a la persona que más titanes mató durante el año 2020, asumiendo que tenemos una columna fecha en la tabla 'muertes', podemos usar la siguiente consulta:

SELECT r.nombre AS responsable, COUNT(m.id) AS cantidad_titanes_muertos
FROM responsables r
JOIN muertes m ON r.id = m.id_responsable
WHERE YEAR(m.fecha) = 2020
GROUP BY r.id
ORDER BY cantidad_titanes_muertos DESC
LIMIT 1;