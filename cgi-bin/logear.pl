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

if ($cgi->param('submit')) {
    my $usuario = $cgi->param('usuario');
    my $password = $cgi->param('password');
    if ($usuario =~ /^[a-zA-Z0-9]+$/ && $password =~ /^[a-zA-Z0-9]+$/) {
        my $query = $db->prepare("SELECT * FROM usuarios WHERE usuario = ? AND password = ?");
        $query->execute($usuario,$password);
        if(my $sth = $query->fetchrow_hashref){
            print $cgi->redirect('http://localhost/main.html');
            exit;
        }
    }
    $redirect_url = '../login.html';
}

print $cgi->redirect($redirect_url);
exit;

$db->disconnect;