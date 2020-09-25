runrs () {
  rustc $1.rs -o $1.out && ./$1.out
}
