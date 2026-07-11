function IndianPlayers() {
  const players = [
    'Virat Kohli',
    'Rohit Sharma',
    'Shubman Gill',
    'KL Rahul',
    'Rishabh Pant',
    'Hardik Pandya'
  ];

  const [first, second, third, fourth, fifth, sixth] = players;

  const oddTeam = [first, third, fifth];
  const evenTeam = [second, fourth, sixth];

  const t20Players = ['Virat Kohli', 'Hardik Pandya'];
  const ranjiPlayers = ['Cheteshwar Pujara', 'Ajinkya Rahane'];

  const mergedPlayers = [...t20Players, ...ranjiPlayers];

  return (
    <div>
      <h2>Odd Team Players</h2>
      {oddTeam.map(player => <p key={player}>{player}</p>)}

      <h2>Even Team Players</h2>
      {evenTeam.map(player => <p key={player}>{player}</p>)}

      <h2>Merged Players</h2>
      {mergedPlayers.map(player => <p key={player}>{player}</p>)}
    </div>
  );
}

export default IndianPlayers;