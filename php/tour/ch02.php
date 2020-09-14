<title>Ch02</title>
<?php 

// Show all errors
error_reporting(E_ALL);

$a_bool = TRUE;
$a_str = "foo";
$a_str1 = 'foo';
$an_int = 1200;

echo gettype($a_bool);
echo '<br /><br />';

echo var_dump($a_str);
echo '<br /><br />';

if (is_int($an_int)) {
  $an_int += 4;
  echo $an_int;
}

echo '<br /><br /># Boolean';
echo '<br /><br />';
echo TRUE == True;
echo TRUE == 1;
echo is_int($an_int);

$a = 1_234_567;
echo '<br /><br />';
echo is_int($a);
echo '<br /><br />';
echo var_dump(is_string($a));


echo '<br /><br />';
$x = 8 - 6.4;  // which is equal to 1.6
$y = 1.6;
var_dump($x == $y); // is not true

echo '<br /><br />';

var_dump(floor((0.1+0.7)*10));

echo '<br /><br />';

echo "octal value: \0123";

echo '<br /><br />';

$string = 'string';
echo "The character at index -2 is $string[-2].", PHP_EOL;

echo '<br /><br />';

var_dump(array(<<<EOD
foobar!
EOD
));

echo '<br /><br />';

class beers {
  const softdrink = 'rootbeer';
  public static $ale = 'ipa';
}

$rootbeer = 'A & W';
$ipa = 'Alexander Keith\'s';

// This works; outputs: I'd like an A & W
echo "I'd like an {${beers::softdrink}}\n";

echo '<br /><br />';

// This works too; outputs: I'd like an Alexander Keith's
echo "I'd like an {${beers::$ale}}\n";

echo '<br /><br />';

$array = [
  "foo" => "bar",
  "bar" => "foo",
];
echo var_dump($array);

echo '<br /><br />';

$array = array("foo", "bar", "hello", "world");
echo var_dump($array);

echo '<br /><br />';

$array = ["foo", "bar", "hello", "world"];
echo var_dump($array);

echo '<br /><br />';

$array = array(
  "a",
  "b",
  "b",
  "b",
1 => "c",
  "d",
);
echo var_dump($array);

echo '<br /><br />';

$array = array(
  "foo" => "bar",
  42    => 24,
  "multi" => array(
       "dimensional" => array(
           "array" => "foo"
       )
  )
);

echo '<br /><br />';

echo var_dump($array["foo"]);

echo '<br /><br />';

echo var_dump($array[42]);

echo '<br /><br />';

echo var_dump($array["multi"]["dimensionals"]["array"]);

// $a = "new string";

// $c = $b = $a;

// echo '<br /><br />';
// echo xdebug_debug_zval( 'a' );

// unset( $b, $c );

// echo '<br /><br />';
// echo xdebug_debug_zval( 'a' );

// $handle = opendir('.');
// while (false !== ($file = readdir($handle))) {
//     $files[] = $file;
//     echo $file . '<br />';
// }
// echo var_dump($file[]) . '<br />';
// closedir($handle); 

echo '<br /># iterable <br />';

function eachValue(iterable $iterable) {
  foreach($iterable as $value) {
    echo "$value <br />";
  }
}

eachValue([1,2,3,4,5]);

