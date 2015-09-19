#!/usr/bin/perl -w

use threads; 
use Thread::Queue; 
use threads::shared;

my $q = Thread::Queue->new(); 

sub produce { 
	my $name = shift; 
	my $cnt = 5;
	while($cnt--) { 
		my $r = int(rand(100)); 
		$q->enqueue($r, $r+10); 
		# @_ = 1..4;
		# $q->enqueue(\@_); 
		printf("$name produce $r\n"); 
		sleep(int(rand(3))); 
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

while(1){
if ($producer1->is_joinable()) { $producer1->join() ; print "1\n";}
if ($producer2->is_joinable()) { $producer2->join() ; print "2\n";}
if ($consumer1->is_joinable()) { $consumer1->join() ;  print "3\n";}
sleep 1;
}