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
  my $target_dir_list = get_target_dir(  $mini_notes_dir, \@not_target_file_and_dir );

  make_bat( $mini_notes_dir, $target_dir_list );
}

sub make_bat {
  my ( $mini_notes_dir, $target_dir_list ) = @_;
  my $num_of_dir = @$target_dir_list;
  my $counter = 0;
  foreach my $dir_name ( @$target_dir_list ) {
    my $target_file_path = $mini_notes_dir . "/" . $dir_name . "/note.bat";
    open ( my $fh, ">", encode( "cp932", $target_file_path ) );
    my $scale_factor =  ( $num_of_dir - $counter ) / $num_of_dir;
    print $fh "mode " . int( 130 * $scale_factor ) . "," . int( 30 * $scale_factor ) . "\n\n";
    print_common_code( $fh );
    my $text_for_copy = 'copy /Y "./note.pdf" "./' . $dir_name . '.pdf"' . "\n\n";
    my $text_for_backup = 'copy /Y "./' . $dir_name . '.pdf" "C:/Googleドライブ共有用フォルダ/PDFフォルダ/' . $dir_name . '.pdf"' . "\n\n";
    print $fh encode( "cp932", $text_for_copy );
    print $fh encode( "cp932", $text_for_backup );
    print $fh 'del "./note.pdf"' . "\n\n";
    print $fh "exit";
    close $fh;
    $counter++;
  }
}

sub print_common_code {
  my ( $fh ) = @_;
  print $fh <<'EOS'
platex note.tex

pbibtex note -kanji=sjis

platex note.tex

pbibtex note -kanji=sjis

platex note.tex

mendex -S note.idx

mendex -S note.idx

platex note.tex

dvipdfmx note.dvi

del "./note.aux"

del "./note.bbl"

del "./note.idx"

del "./note.ind"

del "./note.log"

del "./note.ilg"

del "./note.out"

del "./note.toc"

del "./note.dvi"

del "./note.blg"

EOS
}

1;
