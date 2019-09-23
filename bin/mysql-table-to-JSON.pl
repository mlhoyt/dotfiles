#!/usr/bin/env perl

$foundColumns = 0;
@COLUMNS = ();
@DATA = ();

# Parse input TABLE MySQL SELECT syntax
while(<>) {
  next if( /^\s*$/ || /^\+\-+/ );

  # Strip leading / trailing table boundary
  s/^\s*\|\s*//;
  s/\s*\|\s*$//;

  if ( !$foundColumns ) {
    @COLUMNS = split( /\s*\|\s*/ );
    $foundColumns = 1;
  }
  else {
    @fields = split( /\s*\|\s*/ );

    my @json_items = ();
    for ( my $i=0; $i < (scalar @COLUMNS); $i++ ) {
      push @json_items, sprintf("\"%s\":\"%s\"", $COLUMNS[$i], $fields[$i]);
    }

    push @DATA, sprintf("{%s}", join(", ", @json_items));
  }
}

# Output JSON syntax
printf("[%s]\n", join(", ", @DATA));
