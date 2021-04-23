<?php
$ip = shell_exec("ifconfig eth0 | grep 'inet addr:'");
$top = shell_exec("top -bn1 | grep 'Cpu(s)'");
echo "<h1>" . $ip . "</h1>";
echo "<h1>" . $top . "</h1>";
?>