import React from 'react';
import '../Stylesheets/mystyle.css';

function CalculateScore({ name, school, total, goal }) {
  const score = ((total / goal) * 100).toFixed(2);

  return (
    <div className="score-card">
      <h1>Student Details</h1>

      <p><b>Name:</b> {name}</p>
      <p><b>School:</b> {school}</p>
      <p><b>Total:</b> {total}</p>
      <p><b>Goal:</b> {goal}</p>
      <p><b>Score:</b> {score}%</p>
    </div>
  );
}

export default CalculateScore;