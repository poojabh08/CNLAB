set ns [new Simulator]
#open tracefile in write mode
set tf [open cnlab2.tr w]
$ns trace-all $tf
#open network animation file in write mode
set nf [open cnlab2.nam w]
$ns namtrace-all $nf
#procedure to execute on finishing i.e. at 10.0 sec
proc finish {} {
    #declare global variables
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam cnlab2.nam &
    exec awk -f cnlab2.awk cnlab2.tr &
    exit 0
}

#Creation of nodes

set s1 [$ns node]
set s2 [$ns node]
set r1 [$ns node]
set r2 [$ns node]
set s3 [$ns node]
set s4 [$ns node]

#labelling

$s1 label "TCP Source"
$s2 label "UDP Source"
$r1 label "r1"
$r2 label "r2"
$s3 label "UDP Sink"
$s4 label "TCP Sink"

#Create duplex links

$ns duplex-link $s1 $r1 1Mb 20ms DropTail
$ns duplex-link $s2 $r1 1Mb 20ms DropTail
$ns duplex-link $r1 $r2 0.6Mb 10ms DropTail
$ns duplex-link $r2 $s4 1Mb 20ms DropTail
$ns duplex-link $r2 $s3 1Mb 20ms DropTail

#$ns queue-limit $s1 $s2 100
#$ns queue-limit $r1 $s2 10
#$ns queue-limit $s2 $s3 5
#$ns queue-limit $s3 $s4 2
#$ns queue-limit $s3 $r2 2

#Create Agents
#Create UDP agent
set udp [new Agent/UDP]
set null [new Agent/Null]

$ns attach-agent $s2 $udp
$ns attach-agent $s3 $null

$ns connect $udp $null

#Create TCP agent
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $s1 $tcp
$ns attach-agent $s4 $sink

$ns connect $tcp $sink

#Create Application
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

#Start the traffic
$ns at 0.2 "$cbr start"
$ns at 0.5 "$ftp start"
$ns at 3.0 "$ftp stop"
$ns at 3.0 "$cbr stop"
$ns at 3.0 "finish"

$ns run


