factorial <: (n){
  @ <: if [n < 2] then [1] else [n * @(n - 1)];
};

puts("The factorial of 10 is: ");
puts(factorial(10));
