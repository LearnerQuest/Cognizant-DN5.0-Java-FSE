import './App.css';

function App() {
  const officeSpaces = [
    {
      id: 1,
      name: 'DBS Business Centre',
      rent: 55000,
      address: 'Bengaluru'
    },
    {
      id: 2,
      name: 'WeWork Galaxy',
      rent: 75000,
      address: 'Gurugram'
    },
    {
      id: 3,
      name: 'Innov8 Workspace',
      rent: 60000,
      address: 'Noida'
    }
  ];

  return (
    <div className="App">
      <h1>Office Space Rental Application</h1>

      {officeSpaces.map(office => (
        <div className="office-card" key={office.id}>
          <h2>{office.name}</h2>

          <p>
            Rent:
            <span
              style={{
                color: office.rent < 60000 ? 'red' : 'green',
                fontWeight: 'bold',
                marginLeft: '5px'
              }}
            >
              ₹{office.rent}
            </span>
          </p>

          <p>Address: {office.address}</p>
        </div>
      ))}
    </div>
  );
}

export default App;