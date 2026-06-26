# Exercise 1 - Inventory Management System

## Scenario
Inventory management system for a warehouse where efficient storage and retrieval are important.

## Data Structure Used
HashMap<Integer, Product>

## Why HashMap?
Product ID is unique, so HashMap allows fast access using productId.

## Operations and Time Complexity
- Add Product: O(1) average
- Update Product: O(1) average
- Delete Product: O(1) average
- Display Inventory: O(n)

## Optimization
HashMap is better than ArrayList for searching, updating, and deleting by productId because ArrayList requires linear search O(n), while HashMap gives average O(1) access.
