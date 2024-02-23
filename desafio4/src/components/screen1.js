

function Screen1({ onSelectResource }) {
  const handleSelectResource = (e) => {
    const selectedResource = e.target.value;
    let selectedUnit = '';

    switch (selectedResource) {
      case 'Agua':
        selectedUnit = 'Litros';
        break;
      case 'Pólvora':
      case 'Gas':
        selectedUnit = 'Kilogramos';
        break;
      case 'Hojas (filo)':
        selectedUnit = 'Hojas';
        break;
      case 'Equipo maniobras':
        selectedUnit = 'Equipos';
        break;
      default:
        selectedUnit = '';
        break;
    }

    onSelectResource(selectedResource, selectedUnit);
  };

  return (
    <div className="screen1">
      <h1>Pantalla 1</h1>
      <select onChange={handleSelectResource}>
        <option value="">Seleccione</option>
        <option value="Agua">Agua</option>
        <option value="Pólvora">Pólvora</option>
        <option value="Gas">Gas</option>
        <option value="Hojas (filo)">Hojas (filo)</option>
        <option value="Equipo maniobras">Equipo maniobras</option>
      </select>
    </div>
  );
}

export default Screen1;
