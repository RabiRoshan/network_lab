set ns [new Simulator]
set nf [open trace1.tr w]
$ns trace-all $nf
set nr [open out.nam w]
$ns namtrace-all $nr
proc finish {} {
global ns nf nr
$ns flush-trace
close $nf
close $nr
exec  nam out.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 3Mb 10ms DropTail
$ns duplex-link $n1 $n2 3Mb 10ms DropTail
$ns duplex-link $n2 $n0 3Mb 10ms DropTail

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$ns connect $tcp0 $sink0
$ns at 0.1 "$ftp0 start"
$ns at 10.0 "$ftp0 stop"
$ns at 10.1 "finish"
$ns run
