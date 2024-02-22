import json
import time

# Cargar el archivo para procesamiento
with open("last_year.json", "r") as file:
    sighting_data = json.load(file)

# Filtrar los datos 
filtered_data = [tuple for tuple in sighting_data if not (0 <= tuple[0] <= 30 or 335 <= tuple[0] <= 364)]

# Crear un diccionario para contar avistamientos
sightings_per_day = {}
for start, end in filtered_data:
    for day in range(start, end + 1):
        sightings_per_day[day] = sightings_per_day.get(day, 0) + 1

# Encontrar el día con el menor número de avistamientos
least_sighted_day = min(sightings_per_day, key=sightings_per_day.get)

def print_message(message):
    lines = message.split("\n")
    for line in lines:
        print(line)
        time.sleep(0.5)

# Imprimir mensaje
message = f"""[Diego]: ¡Hola equipo!
[Diego]: Después de revisar los datos de avistamientos de titanes del año pasado, encontré algo interesante.
[Diego]: Parece que el día con menos avistamientos de titanes, excluyendo los meses de diciembre y enero, es el día {least_sighted_day}.
[Diego]: Esto podría ser útil para nuestra planificación de expedición. ¡Sigamos adelante con cautela y determinación!
[Diego]: ¡Gracias a todos por su colaboración!
[Diego]: ¡Vamos equipo!
"""

print_message(message)
