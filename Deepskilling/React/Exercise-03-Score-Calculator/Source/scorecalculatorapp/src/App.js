import './App.css';
import CalculateScore from './Components/CalculateScore';

function App() {
  return (
    <CalculateScore
      name="Aashi Garg"
      school="GLA University"
      total={450}
      goal={500}
    />
  );
}

export default App;