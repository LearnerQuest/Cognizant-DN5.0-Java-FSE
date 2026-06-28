# Exercise 3 - Sorting Customer Orders

## Scenario
This exercise sorts customer orders by total price on an e-commerce platform.

## Classes Created
- Order
- SortingService
- SortingTest

## Algorithms Implemented
- Bubble Sort
- Quick Sort

## Bubble Sort
Bubble Sort compares adjacent elements and swaps them if they are in the wrong order.

### Time Complexity
- Best Case: O(n) when optimized with swapped flag
- Average Case: O(n²)
- Worst Case: O(n²)

## Quick Sort
Quick Sort selects a pivot and partitions the array into smaller and greater elements.

### Time Complexity
- Best Case: O(n log n)
- Average Case: O(n log n)
- Worst Case: O(n²)

## Why Quick Sort is preferred
Quick Sort is generally preferred over Bubble Sort because its average time complexity is O(n log n), making it much faster for large datasets.