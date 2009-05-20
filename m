MIME-Version: 1.0
In-Reply-To: <200905210302.22639.lindner_marek@yahoo.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905210010.54489.lindner_marek@yahoo.de>
	<4313f3060905201001u5658c660p5a9be3d63dbff150@mail.gmail.com>
	<200905210302.22639.lindner_marek@yahoo.de>
Date: Wed, 20 May 2009 14:39:45 -0500
Message-ID: <4313f3060905201239i67f6f150q33ebddb9b32f25b8@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Kernel crashes with batgat installed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wed, May 20, 2009 at 2:02 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> I miss a couple of things in your output - do you use the plain sources from
> open-mesh.net or do you apply custom patches ?

I am using OpenWRT, and it doesn't have any patches.  It does get the
source from open-mesh.net.

> Your log indicates that all routes are still present and batman tries to clean
> them up while starting. As you can see here table 68 is not mentioned.
> ....
> Here we lack the message that says we found a new HNA:
> Adding HNA to announce network list: 105.0.0.0/8
> ....
> I could make a patch that produces more debug output to get to the root of it
> but first we have to make sure we run the same code ...

I don't know where the table 68 entries might have gone, or the HNA.

How about using 1269?  Here is the latest -d 4 output:
=========================================
WARNING: You are using the unstable batman branch. If you are
interested in *using* batman get the latest stable release !
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 66 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 66 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 68 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 68 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 65 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 65 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 67 - unknown)
Deleting throw route to 10.255.1.3/32 via 0.0.0.0 (table 67 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
Interface activated: ath0
Using interface ath0 with address 10.0.1.3 and broadcast address 10.0.255.255
Interface activated: eth0
Using interface eth0 with address 10.255.1.3 and broadcast address
10.255.255.255
B.A.T.M.A.N. 0.3.2-beta rv1269 (compatibility version 5)
[        30] Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
[        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1)
[        30] Adding throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0)
debug level: 4
routing class: 2
[        30] schedule_own_packet(): ath0
[        30] schedule_own_packet(): eth0
[        30]
[       940]
[       950] Sending own packet (originator 10.255.1.3, seqno 1, TTL
2) on interface eth0
[       950] schedule_own_packet(): eth0
[       950]
[       950] Received BATMAN packet via NB: 10.255.1.3, IF: eth0
10.255.1.3 (from OG: 10.255.1.3, via old OG: 10.255.1.3, seqno 1, tq
255, TTL 2, V 5, IDF 0)
[       950] Drop packet: received my own broadcast (sender: 10.255.1.3)
[       950]
[      1010]
[      1020] Sending own packet (originator 10.0.1.3, seqno 1, TTL 50,
IDF off) on interface ath0
[      1020] Sending own packet (originator 10.0.1.3, seqno 1, TTL 50,
IDF off) on interface eth0
[      1020] schedule_own_packet(): ath0
[      1020]
[      1020] Received BATMAN packet via NB: 10.0.1.3, IF: ath0
10.0.1.3 (from OG: 10.0.1.3, via old OG: 10.0.1.3, seqno 1, tq 255,
TTL 50, V 5, IDF 0)
[      1020] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      1020]
[      1020] Received BATMAN packet via NB: 10.255.1.3, IF: eth0
10.255.1.3 (from OG: 10.0.1.3, via old OG: 10.0.1.3, seqno 1, tq 255,
TTL 50, V 5, IDF 0)
[      1020] Drop packet: received my own broadcast (sender: 10.255.1.3)
[      1020]
[      1990]
[      2000] Sending own packet (originator 10.255.1.3, seqno 2, TTL
2) on interface eth0
[      2000] schedule_own_packet(): eth0
[      2000] ------------------ DEBUG ------------------
[      2000] Forward list
[      2000]     10.0.1.3 at 2022
[      2000]     10.255.1.3 at 2913
[      2000] Originator list
[      2000]   Originator  (#/255)         Nexthop [outgoingIF]:
Potential nexthops
[      2000] No batman nodes in range ...
[      2000] ---------------------------------------------- END DEBUG
[      2000] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
[      2000] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
[      2000] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
[      2000] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - unknown)
[      2000] Error - can't add throw route to 10.1.3.0/24 via 0.0.0.0
(table 68): File exists
[      2000] Error - can't add throw route to 10.1.3.0/24 via 0.0.0.0
(table 68): File exists
[      2000] Adding throw route to 10.255.1.3/32 via 0.0.0.0 (table 65
- unknown)
[      2000] Adding throw route to 10.255.1.3/32 via 0.0.0.0 (table 66
- unknown)
[      2000] Adding throw route to 10.255.1.3/32 via 0.0.0.0 (table 67
- unknown)
[      2000] Adding throw route to 10.255.1.3/32 via 0.0.0.0 (table 68
- unknown)
[      2010] debugRealloc - invalid magic number in trailer: 78183456,
malloc tag = 15
[      2010] debugRealloc - invalid magic number in trailer: 78183456,
malloc tag = 15
[      2010] Deleting throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
[      2090] Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1)
[      2130] Deleting throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0)
=========================================

> Ok, lets do the malloc stuff first and then we move to the batgat issue.
>
> Just to be clear here: DEBUG_MALLOC is not the problem - it just makes the
> problem visible. Everytime batman allocates memory the debugger will allocate
> more than needed to add its debugging information. Now the debugging
> information gets overwritten and the debugger tells you that (including a
> direction towards the source of the problem). If you deactivate the debugger
> the memory will still be overwritten but you don't notice it!
> It can destroy arbitrary structures in the memory that need hours to lead to a
> crash (if it all). May be it leads to broken routing entries ..

That sounds good to me.  I had just turned it off to see if it was
just giving false errors, and everything ran fine until trying to do
something new with batgat.
