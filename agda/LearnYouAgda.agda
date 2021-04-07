module LearnYouAgda where
  data ℕ : Set where
    zero : ℕ
--    one  : ℕ
    suc  : ℕ -> ℕ

-- define arithmetic operations
  _+_ : ℕ → ℕ → ℕ
  zero + zero = zero
  zero + n    = n
  (suc n) + n′ = suc (n + n′)
