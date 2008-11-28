Message-ID: <49302F8E.2040502@web.de>
Date: Fri, 28 Nov 2008 19:51:10 +0200
From: "Chris W." <chris-wy@web.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
References: <492DDC20.7090900@web.de>
	<200811280043.26990.lindner_marek@yahoo.de>
In-Reply-To: <200811280043.26990.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: chris-wy@web.de
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

Marek Lindner schrieb:
> Hey,
> 
>> thought I'd just let you know what I experienced when testing rv1152 on
>> an outdoor network with atheroses and broadcoms, olsr in parallel.
>> Interfaces are started with
>> ifconfig eth1:1 10.4.2.29 netmask 255.255.0.0 broadcast 10.4.255.255
>>
>> The batman test area looks something like this:
>> http://preveli.gr/mesh/bat-228-2b.gif
> 
> wow - looks pretty good.
> 
It is, alltogether it's about 50 nodes. This vis is geopraphically more
accurate: http://preveli.gr/mesh/bat-228-3.gif

Now rv1161 is on, the reduced test area is
http://preveli.gr/mesh/bat-228-3b.gif

> 
>> -1- gateway:
>> Adding default route to 10.4.2.2 (gw_flags: 40, tq: 181, gw_product: 0)
>> Gateway client - got IP (169.254.0.1) from gateway: 10.4.2.2
>> Adding default route via gate0 (table 68)
>>
>> gateway log:
>> Gateway - assigned 169.254.0.1 to client: 10.4.2.29
>> Gateway - assigned 169.254.0.1 to client: 10.4.2.29
>> Gateway - assigned 169.254.0.1 to client: 10.4.2.29
> 
> You probably experience the same issue as Derek. You could verify whether it 
> is related to endianess or not by looking in the dmesg output on the gateway. 
> Such seldom errors are reported in the kernel log (on OpenWRT you may use 
> logread to access it). We are looking for messages like: "Error - got packet 
> from unknown client ..."
> 
Yes, looks similar to Derek's.
Not to mess with endian issues, I tested on broadcom only with no
atheros connected. The tunnel builds up but isn't stable.

Gateway client - gateway (10.4.2.2) says: IP (169.254.0.1) is invalid
(maybe expired)
Deleting default route via gate0 (table 68)
Adding default route to 10.4.2.71 (gw_flags: 40, tq: 188, gw_product:
2747168)
Gateway client - got IP (169.254.0.1) from gateway: 10.4.2.71
Adding default route via gate0 (table 68)

The node itself can connect through the tunnel. Everything else which
doesn't come from the nodes IP can't pass, the gateway logs:

Nov 28 16:51:59 (none) kern.err batmand[18644]: Error - got packet from
unknown client: 10.4.2.50 (virtual ip 10.2.50.99)

Same error with olsr traffic which has dropped into the tunnel.

> 
>> -?- What is batgat for, does it disannounce a gateway which in fact is
>> down e.g due to dsl-failure ?
> 
> The batman daemon maintains a tunnel connection to every "batman internet 
> client". Every packet that goes to the internet or comes back has to go 
> through this tunnel. As it is a user space tunnel a lot of copying between 
> user space and kernel land is necessary. Depending on the number of clients 
> and the CPU power available this might be a bottleneck.
> The batgat kernel module tries to overcome this limitation. Once loaded the 
> batman daemon will detect its presence automatically on startup. The daemon 
> will activate the kernel module to let it handle the tunneling, hence avoiding 
> the expensive copy operations. There is no difference between the daemon 
> tunneling and the kernel tunneling other than that.
> 
> I will put this into our FAQ.
> 
Thank you for the explanation. Is this module available for OpenWrt 0.9
broadcom somewhere ?

Another point is that
even if a gateway's internet connection is down, but announced, it is
chosen as tunnel endpoint. Something similar to the olsrd-dyn-gw would
be great.

> 
>> -2- together with olsrd.
>>  From a gateway node running olsrd in parallel the route to an announced
>> network drops out towards the internet, the node itself is reachable:
> 
> Sorry, I don't understand this. Can you explain a bit more ?
> 
The described effects may be due to routing problems and things like
that on batman, olsr's routing is last so it takes all the rest. I'd
better not describe this in detail as it may occur due to the following
point.
> 
>> -3- previously announced networks are not deleted (8.106), the routing
>> table collects multiple entries for the same destination
> 
> Thanks for the hint. Fixed in revision 1159.
> 
Yes, no multiple entries anymore in 1161.

The announced network of 2.72 gets lost after some minutes on all nodes.
Logs show
Nov 28 17:13:43 (none) kern.err batmand[18641]: Error - can't add route
to 10.2.72.0/24 via 10.4.2.95 (table 65): File exists
Nov 28 17:13:43 (none) kern.err batmand[18641]: Error - can't add route
to 10.2.72.1/32 via 10.4.2.95 (table 65): File exists

root@10.4.2.72:~# ip ro sh ta 65
10.2.50.0/24 via 10.4.2.50 dev eth1  proto static  src 10.4.2.72

root@10.4.2.50:~# ip ro sh ta 65
throw 10.2.50.0/24  proto static


Node 2.2 knows the route but 2.72 doesn't route on to its subnet.

root@10.4.2.2:~# ip ro sh ta 65
10.2.72.1 via 10.4.2.95 dev eth1  proto static  src 10.4.2.2
10.2.50.0/24 via 10.4.2.95 dev eth1  proto static  src 10.4.2.2
10.2.72.0/24 via 10.4.2.95 dev eth1  proto static  src 10.4.2.2

root@10.4.2.2:~# traceroute 10.2.72.1
traceroute to 10.2.72.1 (10.2.72.1), 30 hops max, 40 byte packets
  1  10.4.2.95 (10.4.2.95)  74.843 ms  7.151 ms  28.312 ms
  2  10.4.2.71 (10.4.2.71)  5.363 ms  7.632 ms  3.652 ms
  3  * * *
  4


The announced network of 2.50 is reachable.

root@10.4.2.2:~# traceroute 10.2.50.1
traceroute to 10.2.50.1 (10.2.50.1), 30 hops max, 40 byte packets
  1  10.4.2.95 (10.4.2.95)  52.299 ms  7.063 ms  26.876 ms
  2  10.4.2.72 (10.4.2.72)  24.764 ms  4.44 ms  43.759 ms
  3  10.2.50.1 (10.2.50.1)  15.334 ms  6.379 ms  22.462 ms

The laptop (10.2.50.99) connected to 2.50 cannot be reached:

root@10.4.2.50:~# ip ro sh ta 66
10.4.2.95 via 10.4.2.72 dev ath0  proto static  src 10.4.2.50
10.4.2.72 dev ath0  proto static  scope link  src 10.4.2.50
10.4.2.71 via 10.4.2.72 dev ath0  proto static  src 10.4.2.50
10.4.2.2 via 10.4.2.72 dev ath0  proto static  src 10.4.2.50
throw 10.2.50.0/24  proto static

root@10.4.2.50:~# ip ro sh ta 67
throw 10.2.50.0/24  proto static
unreachable default  proto static


> 
>> Well, I'll keep on testing ;-)
> 
> Cool ! Many thanks for your hints - we are waiting for feedback.  :-)
> 
thank you too for the protocol ...

> Regards,
> Marek
> 
bye,
Christian
> 
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 

