import { useState } from 'react';
import './App.css';

function GuestPage() {
  return (
    <div>
      <h2>Please sign up.</h2>
      <p>Flight: Delhi to Bengaluru</p>
      <p>Price: ₹6,500</p>
    </div>
  );
}

function UserPage() {
  return (
    <div>
      <h2>Welcome back</h2>
      <p>You can now book your ticket.</p>
      <button onClick={() => alert('Ticket booked successfully')}>
        Book Ticket
      </button>
    </div>
  );
}

function App() {
  const [loggedIn, setLoggedIn] = useState(false);

  return (
    <div className="App">
      {loggedIn ? <UserPage /> : <GuestPage />}

      <button onClick={() => setLoggedIn(!loggedIn)}>
        {loggedIn ? 'Logout' : 'Login'}
      </button>
    </div>
  );
}

export default App;