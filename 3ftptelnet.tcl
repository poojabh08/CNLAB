set val(stop) 10.0 ;

#create Simulator
set ns [new Simulator]

#Open Trace and NAM Trace File
set ntrace [open out.tr w]
$ns trace-all $ntrace
set namfile [open out.nam w]
$ns namtrace-all $namfile


#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]


#Create links between the nodes
$ns duplex-link $n0 $n2 100Mb 10ms DropTail
$ns queue-limit $n0 $n2 50
$ns duplex-link $n1 $n2 100Mb 10ms DropTail
$ns queue-limit $n1 $n2 50
$ns duplex-link $n2 $n3 100Mb 10ms DropTail
$ns queue-limit $n2 $n3 50
$ns duplex-link $n3 $n4 100Mb 10ms DropTail
$ns queue-limit $n3 $n4 50
$ns duplex-link $n3 $n5 100Mb 10ms DropTail
$ns queue-limit $n3 $n5 50


$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient righ
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n3 $n5 orient right-down


#Set TCP Connection 
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink2 [new Agent/TCPSink]
$ns attach-agent $n4 $sink2
$ns connect $tcp0 $sink2
$tcp0 set packetSize_ 1500



#Set TCP Connection 
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink3 [new Agent/TCPSink]
$ns attach-agent $n5 $sink3
$ns connect $tcp1 $sink3
$tcp1 set packetSize_ 1500


#Attach FTP Application over TCP
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 10.0 "$ftp0 stop"

#Attach FTP Application over TCP
set ftp1 [new Application/Telnet]
$ftp1 attach-agent $tcp1
$ns at 1.0 "$ftp1 start"
$ns at 10.0 "$ftp1 stop"

#Finish Procedure
proc finish {} {
global ns ntrace namfile
$ns flush-trace
close $ntrace
close $namfile

#exec awk -f 3ftp.awk out.tr > temp1

#exec awk -f 3telnet.awk out.tr > temp2

#Execute the nam animation file
exec nam out.nam &
exit 0
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" :$ns halt"

$ns run
