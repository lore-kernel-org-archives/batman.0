From: Axel Neumann <axel@open-mesh.net>
Date: Mon, 27 Aug 2007 13:14:39 +0200
References: <435DF58A933BA74397B42CDEB8145A860F5137E5@ex9.hostedexchange.local>
	<200708261325.55854.axel@open-mesh.net>
	<435DF58A933BA74397B42CDEB8145A860C460189@ex9.hostedexchange.local>
In-Reply-To: <435DF58A933BA74397B42CDEB8145A860C460189@ex9.hostedexchange.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708271314.40816.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] Hops along the way
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
To: Michael Burmeister-Brown <mike@netequality.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

On Sonntag 26 August 2007, Michael Burmeister-Brown wrote:
> Regarding finding gateways:
>
> What I meant was, is there a way for a repeater node to find the current
> route being used from the node to the Gateway?

You can use tools like traceroute or ping -R. But you must use the ip of 
the currently selected GW node as the target address. You can get the
currently selected GW-node with batmand -c -d 2 -b. 
This debugoutput level 2 shows the currently available GWs and the 
currently selected GW. It'll look like:
$ batmand -c -d 2 -b
     Gateway              Router (#/128)
=> 10.1.0.1               10.1.0.1 ( 31), gw_class  2 - 64 KBit (e.g. ISDN), reliability: 0
   10.2.0.1               10.1.0.1 ( 30), gw_class  2 - 64 KBit (e.g. ISDN), reliability: 0

Note that 
10.1.0.1 and 10.2.0.1 is actually one machine with two interfaces. And
10.1.1.1 and 10.2.1.1 is another machine with two interfaces.

Note also that ping and traceroute are sometimes confusing when tracing a node
with multiple IPs.
Then any of the valid IPs on that machine may be returned as the traced hop.


So there are two gateways avilable and 10.1.0.1 is the currently selected one.
The following examples have been executed on node 10.1.1.2

$ ping -R 10.1.0.1 # shows the first 10 hops from source to destination and back
PING 10.1.0.1 (10.1.0.1) 56(124) bytes of data.
64 bytes from 10.1.0.1: icmp_seq=1 ttl=64 time=19.1 ms
RR:     10.1.1.2
        10.2.1.1
        10.1.0.1
        10.1.0.1
        10.1.1.1
        10.1.1.2

$ traceroute 10.1.0.1 # shows only the intermediate hops from source to destination
traceroute to 10.1.0.1 (10.1.0.1), 30 hops max, 40 byte packets
 1  10.1.1.1 (10.1.1.1)  5.103 ms  3.608 ms  3.870 ms
 2  10.1.0.1 (10.1.0.1)  7.762 ms  8.640 ms  7.650 ms

( If you do not have ping or traceroute available or do not have it 
compiled with the desired options (like -R for ping) for your hardware
you can try the pre-compiled binaries at:
http://downloads.open-mesh.net/misc/handy-tools/ )

>
> It would be nice to be able to see how many hops are being used, the
> quality of each link along the way, etc.  Our Google maps (for Merakis)
> will also highlight the route to the gateway, for example.
To get detailed feedback about the quality of each individual hop
you may install a central visualization server using the vis tool:
svn co https://dev.open-mesh.net/batman/browser/trunk/vis/

Then each node must be configured to send information about the 
link qualities to its neighbors to the centralized server. 
( There is no global knowledge at every node about every link , 
thats one of the big differences between batman and link-state-protocols )
Therefore simply start the client nodes with eg.:
batmand -s <IP-of-central-visualization-server> wlan0

ciao,
axel

>
> Thanks again,
>
> Mike
>
