set val(stop) 10.0 ;

#create Simulator
set ns [new Simulator]

#Open Trace and NAM Trace File
set tracefile [open out.tr w]
$ns trace-all $tracefile
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
$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns queue-limit $n0 $n2 5
$ns duplex-link $n1 $n2 100Mb 10ms DropTail
$ns queue-limit $n1 $n2 50
$ns duplex-link $n2 $n3 100Mb 10ms DropTail
$ns queue-limit $n2 $n3 50
$ns duplex-link $n3 $n4 100Mb 10ms DropTail
$ns queue-limit $n3 $n4 50
$ns duplex-link $n3 $n5 0.5Mb 10ms DropTail
$ns queue-limit $n3 $n5 5


$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient righ
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n3 $n5 orient right-down


#Set TCP Connection 
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500



#Set TCP Connection 
set udp2 [new Agent/UDP]
$ns attach-agent $n1 $udp2
set null3 [new Agent/Null]
$ns attach-agent $n5 $null3
$ns connect $udp2 $null3
$udp2 set packetSize_ 1500

set err [new ErrorModel]
$ns lossmodel $err $n2 $n3
$err set rate_ 0.5



#Attach FTP Application over TCP
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 10.0 "$ftp0 stop"

#Attach CBR Application over UDP
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp2
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1.0Mb
$cbr1 set random_ null

$ns at 1.0 "$cbr1 start"
$ns at 10.0 "$cbr1 stop"

#Finish Procedure
proc finish {} {
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile

#exec awk -f 4awk.awk out.tr
#Execute the nam animation file
exec nam out.nam &
exit 0
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" :$ns halt"

$ns run
