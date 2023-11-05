#!/usr/bin/env perl

@data = ();

$cpu_util = -1;
$mem_usage = -1;
while(<>) {
  if (/\bautomation\b/) {
    local @fields = split(/\s+/);
    $cpu_util = $fields[2];
    $cpu_util =~ s/%$//;

    $mem_usage = $fields[3];
    $mem_usage =~ s/MiB$//;

    # printf("cpu_util=%f mem_usage=%f\n", $cpu_util, $mem_usage);
  } elsif (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$/) {
    local $timestamp = $_;
    chomp($timestamp);
    $timestamp =~ s/Z$//;
    # printf("timestamp=%s\n", $timestamp);

    push @data, {
      timestamp => $timestamp,
      cpu_util => $cpu_util,
      mem_usage => $mem_usage,
    };
  }
}

# printf("read %d data points\n", $#data);

$xrange_min = $data[0]->{"timestamp"};
$xrange_max = $data[-1]->{"timestamp"};

printf("#!/usr/bin/env gnuplot\n");
printf("set xlabel 'time';\n");
printf("set format x '%H:%M';\n");
printf("set grid;\n");
printf("set term png size 800,380;\n");
printf("set output 'output.png';\n");
printf("set xdata time;\n");
printf("set timefmt '%Y-%m-%%dT%H:%M:%S';\n");
printf("set xrange ['%s':'%s'];\n", $xrange_min, $xrange_max);
printf("\$data << EOD\n");
foreach my $point (@data) {
  printf("%s %f %f\n", $point->{"timestamp"}, $point->{"cpu_util"}, $point->{"mem_usage"});
}
printf("EOD\n");
printf("set ytics nomirror;\n");
printf("set y2tics;\n");
printf("set ylabel 'CPU%';\n");
printf("set yrange [0:100];\n");
printf("set y2label 'MEM(MiB)';\n");
printf("set y2range [0:256];\n");
printf("plot \\\n");
printf("  \"\$data\" using 1:2 notitle axes x1y1 with lines linecolor 1, \\\n");
printf("  \"\$data\" using 1:3 notitle axes x1y2 with lines linecolor 2;\n");
