#!"C:/xampp/perl/bin/perl.exe"
use strict;
use CGI;
use DBI;

my $cgi = CGI->new;
my $db_host = 'localhost';
my $db_name = 'proyecto';
my $db_user = 'root';
my $db_pass = '';
my $table = 'login';
my $db = DBI->connect("DBI:mysql:database=$db_name;host=$db_host",$db_user,$db_pass) or die "Couldn't connect to the database";
my $redirect_url = 'http://localhost/login.html';

my $usuario = $cgi->param('usuario');
my $passw = $cgi->param('password');
my $correo = $cgi->param('correo');
my $edad = $cgi->param('edad');
my $numero = $cgi->param('celular');

my $query = $db->prepare("INSERT INTO usuarios(usuario, password, correo, edad, celular) VALUES (?, ?, ?, ?, ?)");
$query->execute($usuario, $passw, $correo, $edad, $numero);
print $cgi->redirect($redirect_url);
$db->disconnect;