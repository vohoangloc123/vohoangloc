// Function to calculate the sum from 1 to n using a mathematical formula
// Formula: S = n(n + 1) / 2
// Complexity: O(1) (fastest, requires only one computation)

var sum_to_n_a = function (n) {
  return (n * (n + 1)) / 2;
};

// Function to calculate the sum from 1 to n using a loop
// Complexity: O(n) (slower compared to the mathematical formula)

var sum_to_n_b = function (n) {
  let sum = 0;
  for (let i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
};

// Function to calculate the sum from 1 to n using recursion
// Complexity: O(n) (requires additional memory for function call stack)
var sum_to_n_c = function (n) {
  if (n === 1) return 1;
  return n + sum_to_n_c(n - 1);
};

console.log(sum_to_n_a(10));
console.log(sum_to_n_b(10));
console.log(sum_to_n_c(10));
