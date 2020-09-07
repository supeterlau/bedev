<title>PHP Tour</title>
<ul>
<li><a href="/a/b/c?a=1&b=2">Home</a></li>
<li><a href="/a/b/c?a=1&b=2">Test Link</a></li>
<li><a href="/ch01.php">---</a></li>
<li><a href="/ch01.php">ch01</a></li>
</ul>

<?php
$a = 1;
$b = 2;
echo $a+$b;

echo "<br />";
echo "<br />";

print_r($_SERVER['REQUEST_URI']);

echo "<br />";
echo "<br />";

foreach (getallheaders() as $name => $value) {
  print_r("$name: $value<br /><br />");
}

print_r($_REQUEST);