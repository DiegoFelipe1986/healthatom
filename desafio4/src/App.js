import React, { useState } from 'react';
import './App.css';
import Screen1 from './components/screen1';
import Screen2 from './components/screen2';
import Screen3 from './components/screen3';

function App() {
  const [screen, setScreen] = useState(1);
  const [resource, setResource] = useState('');
  const [quantity, setQuantity] = useState('');
  const [unit, setUnit] = useState('');
  const [resourcesList, setResourcesList] = useState([]);

  const handleSelectResource = (selectedResource) => {
    setResource(selectedResource);
    setScreen(2);
  };

  const handleEnterQuantity = (e) => {
    setQuantity(e.target.value);
  };

  const handleSelectUnit = (selectedUnit) => {
    setUnit(selectedUnit);
  };

  const handleNextScreen = () => {
    setScreen(3);
    setResourcesList([...resourcesList, { resource, quantity, unit }]);
  };

  const handleRemoveResource = (resourceToRemove) => {
    setResourcesList(resourcesList.filter((r) => r.resource !== resourceToRemove));
  };

  return (
    <div className="App">
      {screen === 1 && <Screen1 onSelectResource={handleSelectResource} />}
      {screen === 2 && (
        <Screen2
          resource={resource}
          quantity={quantity}
          unit={unit}
          onSelectUnit={handleSelectUnit}
          onEnterQuantity={handleEnterQuantity}
          onNextScreen={handleNextScreen}
        />
      )}
      {screen === 3 && (
        <Screen3
          resourcesList={resourcesList}
          onRemoveResource={handleRemoveResource}
        />
      )}
    </div>
  );
}

export default App;