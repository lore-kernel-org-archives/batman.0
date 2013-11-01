Return-Path: <bittorf@bluebottle.com>
Date: Fri, 1 Nov 2013 15:33:05 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131101143305.GO6252@medion.lan>
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131101123610.GR970@neomailbox.net>
Subject: Re: [B.A.T.M.A.N.] lost connection to a client / Q:
	transglobal-table
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

* Antonio Quartulli <antonio@meshcoding.com> [01.11.2013 13:53]:
> > here the transglobal-table in the master, my laptop is '00:21:6a:32:7c:1c'
> 
> what is master?

the node which has internet connectitvity / default gateway.

> 
> > the interesting thing is, that my laptop seems to be reachable via
> > *:02:22 and *:00:13 - the 2nd entry has no hash (?), but 'batctl t 00:21:6a:32:7c:1c'
> > outputs *:00:13 as originator. from the topology, it is impossible to be
> > near this node, so no roaming can happen AND i can see on my laptop,
> > that there was no roaming. the situation recovers without interaction after some
> > minutes. the transglobal table does not change, but 'batctl t 00:21:6a:32:7c:1c' 
> > outputs the correct *:02:22
> > 
> 
> Here[1] you have an explanation about the translation table output.

thanks, this help: so [.W.] means:
"this client is connected to the node through a wireless device"

      Client        (TTVN)       Originator      (Curr TTVN) (CRC   )   Flags
* 00:21:6a:32:7c:1c  (  4) via 02:00:ca:b1:02:22     (  5)   (0x6456) * [.W.]
+ 00:21:6a:32:7c:1c  (  5) via 02:00:ca:b1:00:13     (  5)   [.W.]

but i can be sure, that may laptop "00:21:6a:32:7c:1c" was never connected to '02:00:ca:b1:00:13'.
both nodes are not connected via cable and are nodes in hybrid-mode (ap+adhoc).
no special tricks, 'only' macvlan. BLA2 is active on all nodes.

the again: why does batman-adv think, that the client (my laptop) is/was
reachable over 02:00:ca:b1:00:13 - the laptop was never there? a hash-collision?

what i also see now:
a laptop is connected via wifi to NodeA, but i ask the 'transglobal'
table, batman-adv says it is on another location and 'batctl tr $lapop'
also works. explaining it:

NodeA = 192.168.99.1/16   ~~~ Laptop with 192.168.222.51/16

(air)

NodeB = 192.168.222.1/16

The Laptop is connected to Node A, but has an IP from Node B.
batman-adv thinks that the Laptop is on NodeB, but in fact it
is on NodeA. Why is this? On Node A 'wlan0' is bridged to bat0.

I can also see via pinging from Laptop 'dups' (2 answers).

bye, bastian
