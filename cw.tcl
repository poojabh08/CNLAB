
set ns [new Simulator]


set tracefile [open out.tr w]
$ns trace-all $tracefile


set namfile [open out.nam w]
$ns namtrace-all $namfile

set winFile0 [open WinFile0 w]

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 5.0Mb 20ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link $n1 $n2 0.5Mb 100ms DropTail
$ns queue-limit $n1 $n2 5
$ns duplex-link $n2 $n3 5.0Mb 20ms DropTail
$ns queue-limit $n2 $n3 50

$ns duplex-link-op $n1 $n2 queuePos 0.5


$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right



Agent/TCP set nam_tracevar_ true
Agent/TCP set window_ 10
Agent/TCP set ssthresh_ 10

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500


set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 0.1 "$ftp0 start"
$ns at 0.1 "PlotWindow $tcp0 $winFile0"
$ns at 8.0 "$ftp0 stop"


$ns add-agent-trace $tcp0 tcp
$ns monitor-agent-trace $tcp0
$tcp0 tracevar cwnd_
$tcp0 tracevar ssthresh_


proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
proc PlotWindow {tcpSource file} {
	global ns
	set time 0.1
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $file "$now $cwnd"
	$ns at [expr $now+$time] "PlotWindow $tcpSource $file"
}

$ns at 10.0 "finish"
$ns run
