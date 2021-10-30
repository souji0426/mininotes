use strict;
use warnings;
use utf8;
use Encode;
use Data::Dumper;
use Config::Tiny;
#iniファイルを処理するのに使っている

use lib "./";
use common_subroutines;
#共通関数の呼び出し

main();

sub main {
  my $setting_ini_path = "./setting.ini";
  my $setting = Config::Tiny->read( $setting_ini_path );
  my $mini_notes_dir = $setting->{"common"}->{"mini_notes_dir"};

  my @not_target_file_and_dir = split( ",", decode( "utf8", $setting->{"common"}->{"ignore_list"} ) );
  my $target_dir_list = get_target_dir(  $mini_notes_dir, @not_target_file_and_dir );

  make_all_run_bat( $mini_notes_dir, $target_dir_list );
}

sub make_all_run_bat {
  my ( $mini_notes_dir, $target_dir_list ) = @_;
  my $all_run_bat_file_path = encode( "cp932", $mini_notes_dir . "/全てのbatを実行する.bat" );
  open ( my $fh, ">", $all_run_bat_file_path );
  foreach my $dir_name ( @$target_dir_list ) {
    print $fh "cd ./${dir_name}\n\n";
    print $fh "start note.bat\n\n";
    print $fh "cd ../\n\n";
  }
  close $fh;
}
