const players = [
  { name: 'Virat Kohli', score: 95 },
  { name: 'Rohit Sharma', score: 89 },
  { name: 'Shubman Gill', score: 67 },
  { name: 'KL Rahul', score: 72 },
  { name: 'Rishabh Pant', score: 64 },
  { name: 'Hardik Pandya', score: 81 },
  { name: 'Ravindra Jadeja', score: 76 },
  { name: 'R Ashwin', score: 69 },
  { name: 'Jasprit Bumrah', score: 55 },
  { name: 'Mohammed Shami', score: 61 },
  { name: 'Kuldeep Yadav', score: 58 }
];

function ListOfPlayers() {
  const playersBelow70 = players.filter(player => player.score < 70);

  return (
    <div>
      <h2>List of Players</h2>

      {players.map(player => (
        <p key={player.name}>
          {player.name}: {player.score}
        </p>
      ))}

      <h2>Players with Score Below 70</h2>

      {playersBelow70.map(player => (
        <p key={player.name}>
          {player.name}: {player.score}
        </p>
      ))}
    </div>
  );
}

export default ListOfPlayers;