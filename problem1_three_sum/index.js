var sum_to_n_a = function (n) {
  return (n * (n + 1)) / 2; // Công thức tổng cấp số cộng
};

var sum_to_n_b = function (n) {
  let sum = 0;
  for (let i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
};

var sum_to_n_c = function (n) {
  if (n === 1) return 1;
  return n + sum_to_n_c(n - 1); // Đệ quy
};

console.log(sum_to_n_a(10)); // Kết quả: 55
console.log(sum_to_n_b(10)); // Kết quả: 55
console.log(sum_to_n_c(10)); // Kết quả: 55
