import { useState } from 'react';
import './App.css';

function App() {
  const [count, setCount] = useState(0);
  const [amount, setAmount] = useState('');
  const [euro, setEuro] = useState('');

  const increment = () => {
    setCount(count + 1);
    alert('Hello! Counter increased.');
  };

  const decrement = () => {
    setCount(count - 1);
  };

  const sayWelcome = (message) => {
    alert(message);
  };

  const handlePress = (event) => {
    alert('I was clicked');
    console.log(event);
  };

  const convertCurrency = (event) => {
    event.preventDefault();
    setEuro((Number(amount) / 90).toFixed(2));
  };

  return (
    <div className="App">
      <h1>{count}</h1>

      <button onClick={increment}>Increment</button>
      <button onClick={decrement}>Decrement</button>
      <button onClick={() => sayWelcome('Welcome')}>
        Say Welcome
      </button>
      <button onClick={handlePress}>Click on me</button>

      <h1>Currency Converter</h1>

      <form onSubmit={convertCurrency}>
        <input
          type="number"
          placeholder="Amount in INR"
          value={amount}
          onChange={(event) => setAmount(event.target.value)}
        />

        <button type="submit">Convert</button>
      </form>

      {euro && <h3>Euro: €{euro}</h3>}
    </div>
  );
}

export default App;