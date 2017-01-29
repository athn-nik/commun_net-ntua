#Create a simulator object
set ns [new Simulator]

#Open the nam trace file
set nf [open lab5.nam w]
$ns namtrace-all $nf
set trf [open lab5.tr w]
$ns trace-all $trf

#Define a 'finish' procedure
proc finish {} {
	global ns nf trf
	$ns flush-trace
	#close the trace file
	close $nf
	close $trf
	exit 0
}

#Create two nodes
set n(0) [$ns node]
set n(1) [$ns node]

#Create a duplex link between the nodes
$ns duplex-link $n(0) $n(1) 100Mb 150ms DropTail

#Set queue limits
$ns queue-limit $n(0) $n(1) 200
$ns queue-limit $n(1) $n(0) 200

$ns duplex-link-op $n(0) $n(1) orient right

#Create TCP agent
set tcp0 [new Agent/TCP/Reno]
#Set window size
$tcp0 set window_ 151
$tcp0 set windowInit_ 151
$tcp0 set syn_ false
$tcp0 set packetSize_ 5003
$ns attach-agent $n(0) $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n(1) $sink0
$ns connect $tcp0 $sink0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns at 0.0 "$n(0) label SRP_sender"
$ns at 0.0 "$n(1) label SRP_receiver"
$ns at 0.5 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"
$ns at 5.0 "finish"

$ns run