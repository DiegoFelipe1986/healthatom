

function Screen2({ resource, quantity, onSelectUnit, onEnterQuantity, onNextScreen }) {
  const handleQuantityChange = (e) => {
    onEnterQuantity(e);
  };

  const handleUnitChange = (e) => {
    onSelectUnit(e.target.value);
  };

  return (
    <div className="screen2">
      <h1>Pantalla 2</h1>
      <div>
        <label htmlFor="quantityInput">Cantidad:</label>
        <input 
          type="number" 
          id="quantityInput" 
          value={quantity} 
          onChange={handleQuantityChange} 
          min="0" 
          required 
        />
      </div>
      <div>
        <label htmlFor="unitSelect">Unidad:</label>
        <select id="unitSelect" onChange={handleUnitChange} value={resource}>
          <option value="Agua">Litros</option>
          <option value="Pólvora">Kilogramos</option>
          <option value="Gas">Litros</option>
          <option value="Hojas (filo)">Unidades</option>
          <option value="Equipo maniobras">Unidades</option>
        </select>
      </div>
      <button onClick={onNextScreen}>Ingresar</button>
    </div>
  );
}

export default Screen2;
