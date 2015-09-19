#!/usr/bin/perl -w

use threads; 
use Thread::Queue; 
use threads::shared;

my $q = Thread::Queue->new(); 

sub produce { 
	my $name = shift; 
	while(1) { 
		my $r = int(rand(100)); 
		$q->enqueue($r, $r+10); 
		# @_ = 1..4;
		# $q->enqueue(\@_); 
		printf("$name produce $r\n"); 
		sleep(int(rand(30))); 
	} 
} 

sub consume { 
my $name = shift; 
	while(my $r = $q->dequeue()) { 
		printf("consume $r\n"); 
		# printf("consume @$r\n"); 
	} 
} 

# my $thr2 = async { foreach (@ARGV) { print"$_\n"; sleep 5;} };   #通过async使用匿名子例程创建线程
# $thr2->join();

my $producer1 = threads->create(\&produce, "producer1"); 
my $producer2 = threads->create(\&produce, "producer2"); 
my $consumer1 = threads->create(\&consume, "consumer2"); 

$producer1->join(); 
$producer2->join(); 
$consumer1->join();