use strict;
use warnings;
use utf8;
use Encode;

sub get_target_dir {
  my ( $mini_notes_dir, $not_target_file_and_dir ) = @_;
  my @target_dir_list;
  opendir( my $dh, $mini_notes_dir );
  foreach my $name ( readdir ( $dh ) ) {
    if ( $name =~ /^\.{1,2}$/ ) {
      next;
    } elsif ( grep { $_ eq decode( "cp932", $name ) } @$not_target_file_and_dir ) {
      next;
    }
    push ( @target_dir_list, decode( "cp932", $name ) );
  }

  return \@target_dir_list;
}

1;
