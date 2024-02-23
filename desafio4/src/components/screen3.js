import { useState } from 'react';

function Screen3({ resourcesList, onRemoveResource }) {
    const [newResource, setNewResource] = useState('');
    const [newQuantity, setNewQuantity] = useState('');
    const [unit, setUnit] = useState('');

    const handleAddResource = (e) => {
        e.preventDefault();
        if (newResource !== '' && newQuantity !== '' && unit !== '') {
            resourcesList.push({ resource: newResource, quantity: newQuantity, unit: unit });
            setNewResource('');
            setNewQuantity('');
            setUnit('');
        } else {
            alert('Ingrese un recurso, una cantidad y una unidad válida.');
        }
    };

    return (
        <div className="screen3">
            <h1>Ingresar recursos</h1>
            <form onSubmit={handleAddResource}>
                <select value={newResource} onChange={(e) => setNewResource(e.target.value)}>
                    <option value="">Seleccionar recurso</option>
                    <option value="Agua">Agua</option>
                    <option value="Pólvora">Pólvora</option>
                    <option value="Gas">Gas</option>
                    <option value="Hojas (filo)">Hojas (filo)</option>
                    <option value="Equipo maniobras">Equipo maniobras</option>
                </select>
                <input
                    type="number"
                    value={newQuantity}
                    onChange={(e) => setNewQuantity(e.target.value)}
                    placeholder="Cantidad"
                />
                <select value={unit} onChange={(e) => setUnit(e.target.value)}>
                    <option value="">Seleccionar unidad</option>
                    <option value="Litros">Litros</option>
                    <option value="Kilogramos">Kilogramos</option>
                    <option value="Metros cúbicos">Metros cúbicos</option>
                </select>
                <button type="submit">Ingresar</button>
            </form>
            <h2>Recursos ingresados</h2>
            <table>
                <thead>
                    <tr>
                        <th>Recurso</th>
                        <th>Cantidad</th>
                        <th>Unidad</th>
                        <th>Fecha de ingreso</th>
                        <th>Borrar</th>
                    </tr>
                </thead>
                <tbody>
                    {resourcesList.map((resource, index) => (
                        <tr key={index}>
                            <td>{resource.resource}</td>
                            <td>{resource.quantity}</td>
                            <td>{resource.unit}</td>
                            <td>{new Date().toLocaleDateString()}</td>
                            <td><button onClick={() => onRemoveResource(resource.resource)}>Borrar</button></td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default Screen3;
