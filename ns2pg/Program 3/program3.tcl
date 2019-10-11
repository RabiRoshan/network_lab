#Rabi Roshan
#NS2 program 3
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
$ns duplex-link $n0 $n2 3Mb 10ms DropTail
$ns duplex-link $n1 $n3 3Mb 10ms DropTail

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns connect $tcp0 $sink0

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns connect $tcp1 $sink1

set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns connect $tcp2 $sink2

set tcp3 [new Agent/TCP]
$ns attach-agent $n3 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n0 $sink3
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ns connect $tcp3 $sink3

set tcp4 [new Agent/TCP]
$ns attach-agent $n0 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n2 $sink4
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ns connect $tcp4 $sink4

set tcp5 [new Agent/TCP]
$ns attach-agent $n1 $tcp5
set sink5 [new Agent/TCPSink]
$ns attach-agent $n3 $sink5
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp5
$ns connect $tcp5 $sink5

$ns rtmodel-at 1.0 down $n0 $n1
$ns rtmodel-at 3.0 down $n2 $n3

$ns rtproto DV

$ns at 0.1 "$ftp0 start"
$ns at 0.1 "$ftp1 start"
$ns at 0.1 "$ftp2 start"
$ns at 0.1 "$ftp3 start"
$ns at 0.1 "$ftp4 start"
$ns at 0.1 "$ftp5 start"

$ns at 10.0 "$ftp0 stop"
$ns at 10.0 "$ftp1 stop"
$ns at 10.0 "$ftp2 stop"
$ns at 10.0 "$ftp3 stop"
$ns at 10.0 "$ftp4 stop"
$ns at 10.0 "$ftp5 stop"
$ns at 10.1 "finish"
$ns run
