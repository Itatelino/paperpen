<?php 
session_start(); // Removido o "@" pois não é bom suprimir erros
require_once("conexao.php");
$usuario = $_POST['usuario'];
$senha = $_POST['senha']; // Utilizando password_hash para a senha, caso já tenha sido criada a senha de forma segura no banco
$senha_crip = md5($senha);  // **Idealmente, deve-se substituir por password_hash em ambas as partes** (inserção e verificação)
$query = $pdo->prepare("SELECT * FROM usuarios WHERE (email = :usu OR cpf = :usu) AND senha_crip = :senha");// Consultando o banco de dados de maneira segura
$query->bindValue(":usu", $usuario);
$query->bindValue(":senha", $senha_crip);
$query->execute();
// Buscando o primeiro resultado
$res = $query->fetch(PDO::FETCH_ASSOC);  // Alterado para fetch(), já que esperamos um único resultado
if ($res) {  
    if ($res['ativo'] != 'Sim') {
        echo '<script>alert("Usuário Inativo, contate o Administrador!")</script>';
        echo '<script>window.location="index.php"</script>';
        exit();// Verifica se o usuário está ativo
    }
    // Atribuindo os valores ao ID e Nível
    $_SESSION['id'] = $res['id'];  // Melhor armazenar em sessão ao invés de localStorage
    $_SESSION['nivel'] = $res['nivel']; 
    // Redirecionando para as páginas específicas conforme o nível de acesso
    if ($res['nivel'] == 'SAS') {
        echo '<script>window.location="sas"</script>';
    } else {
        echo '<script>window.location="sistema"</script>';
    }
} else {
    echo '<script>alert("Dados Incorretos!")</script>';
    echo '<script>window.location="index.php"</script>';
    exit();
}
?>
