runjava() {
  name=$1
  demo_name="demo/Demo${name}.java"
  class="Demo${name}"
  javac --enable-preview --release 15 $demo_name
  java --enable-preview demo.$class
}
