# parseCcJason.pl
# usage: todo
#
# explanation todo
#

use strict;
use warnings;
use JSON qw( from_json );
use File::Basename;
use Data::Dumper;

my $json_file = $ARGV[0];
my $grades_file = $ARGV[1];
my $cc_file = $ARGV[2];

my $json_text = do {
    open(my $json_fh, "<:encoding(UTF-8)", $json_file)
        or die("Can't open \$json_file\": $!\n");
    local $/;
    <$json_fh>
};

open (my $grade_fh, '>', $grades_file) or die "Could not open \$grades_file: $!\n";
open (my $cc_fh, '>', $cc_file) or die "Could not open \$cc_file $!\n";

my $json = JSON->new;
##kh: $data should be array reference
my $data = $json->decode($json_text);

##keep a count of A's thru F's
my %grade_counts;

my %file_max_complexity;

foreach my $pyfile (sort {basename($a) cmp basename($b)} keys $data) {
    #print $pyfile . "\n";
    for ( @{$data->{$pyfile}} ) {
        #print $_->{type} . " " . $_->{rank} . " " . $_->{complexity} . "\n";
        $grade_counts{$_->{rank}}++;
        if ($file_max_complexity{$pyfile} && $_->{complexity} > $file_max_complexity{$pyfile}) {
            $file_max_complexity{$pyfile} = $_->{complexity};
        } else {
            $file_max_complexity{$pyfile} = $_->{complexity};
        }
    }
}

foreach my $pyfile (sort {$file_max_complexity{$a} <=> $file_max_complexity{$b}} keys %file_max_complexity) {
    print $cc_fh "$pyfile, $file_max_complexity{$pyfile}\n";
}

print $grade_fh "Grades: ", join(", ", (sort keys %grade_counts)), "\n";

foreach my $grade (sort keys %grade_counts) {
    #print "$grade: $grade_counts{$grade}\n" if $grade_counts{$grade};
    print $grade_fh "$grade_counts{$grade}\n" if $grade_counts{$grade};
}
