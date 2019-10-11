#Rabi Roshan
#NS2 Program 2

set ns [new Simulator]
set nf [open tracel.tr w]
$ns trace-all $nf
set nr [open out.nam w]

$ns namtrace-all $nr

proc finish {} {
global ns nf nr
$ns flush-trace
exec nam out.nam &
close $nf
close $nr
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
$ns duplex-link $n0 $n1 3Mb 10ms DropTail
$ns duplex-link $n1 $n2 3Mb 10ms DropTail
$ns duplex-link $n2 $n3 3Mb 10ms DropTail
$ns duplex-link $n3 $n0 3Mb 10ms DropTail
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0

set udp0 [new Agent/UDP]
$ns attach-agent $n2 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns connect $tcp0 $sink0

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$ns connect $udp0 $null0

$ns at 0.1 "$ftp0 start"
$ns at 0.1 "$cbr0 start"
$ns at 10.0 "$ftp0 stop"
$ns at 10.0 "$cbr0 stop"
$ns at 10.1 "finish"
$ns run
