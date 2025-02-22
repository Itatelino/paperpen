<?php 
$banco = "paperpen";
$usuario = "root";
$senha = "";
$servidor = "localhost";

date_default_timezone_set("America/Sao_Paulo");

try {
    $pdo = new PDO("mysql:dbname=$banco;host=$servidor;charset=utf8", "$usuario", "$senha");
    // Opcional: Configurações adicionais de erro no PDO
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $e) {
    echo "Erro nos dados de conexão com o banco!<br>".$e->getMessage();  // Utilizando o método getMessage()
}
?>
