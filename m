Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
Date: Fri, 30 Mar 2012 11:18:06 -0600
Message-ID: <CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
	batman-adv router?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

sorry if I wasnt clear, ill explain in-line:

>If i got your setup right, you plan to flash openwrt on all the
>nanostations that belong to the supernode, but install batman-adv only
>on the 'central' router, with a single eth nic.
>In that case, batman-adv has no (manual or automatic) way of
>alternating the different paths (or even knowing which packet came
>trough which radio).

ok, this is where I was unclear. You are correct that only the router
that is part of the 'supernode' runs batman-adv (at least in the
described scenario).  I didn't know if batman-adv was tracking
connections to each node or tracking interfaces.


>You should use vlans for that (i'm not sure about the performance), or
>run batman-adv on each individual radio, including both the wlan and
>eth0 in bat0.

ok, this is an option I had considered, but I'm worried that link
alternation wont be an option as the radios only have a single radio
and the alternate path is through a completely different radio/device
connected via ethernet.

As far as vlans are concerned, are you saying to have a vlan on the
router for each attached picostation and then set the picostations
ethernet interface to match that vlan?  Then I can add all the vlans
to bat0?  Alternatively, some of my options for the router have enough
ethernet ports to forgo the vlans.

>This last choice will allow packets being relayed along the backbone
>to skip passing through every central router on hops. They would
>instead get switched directly between nanostations belonging to the
>same supernode (unless, of course, the packet's destination is indeed
>that 'central' router)

sure, but by hoping through individual nanostations, the packets are
going to take a single channel.  Then the second link between nodes is
really just failover, right?

maybe if you could clarify this for me.  for link alternating, do the
two nodes need to be one hop neighbors?

according to docs, link alternating works in this scenario, where both
links are good:
node1_Link1------------node2_Link1
node1_Link2------------node2_Link2

but what about this:
node1_Link1------node3_Link1------node2_Link1
node1_Link2------node4_Link2------node2_Link2

will node1 and node2 still have link alternation?  This is basically
what the central router + picostations with the picostations running
batman-adv would look like


supernode1-------picostation1---------picostation1--------supernode2
supernode1-------picostation2---------picostation2--------supernode2

so supernode2 is then a 3 hop neighbor to supernode1.  So will link
alternation work here?  Lets just say that supernode1 has the backhaul
and supernode2 has nothing except it's link to supernode1.  Ideally,
SN2 gets the faster, dual link connection to SN1.  If not, then back
to the dedicated ports/vlan option

supernode1-bat0-vlan1-----vlan1-picostation1---------picostation1-vlan1-----vlan1-bat0-supernode2
supernode1-bat0-vlan2-----vlan2-picostation2---------picostation2-vlan2-----vlan2-bat0-supernode2
(vlan1 and vlan2 are interchangable with eth1 and eth2 in this example)

now SN1 sees SN2 is a single hop neighbor, and then I would expect
that link alternating would work.


in the scenario with dedicated ethernet ports or vlans are used to
connect the picostations, the supernode acts like a single device as
far as the mesh is concerned
in the scenario where the picostations run batman-adv as well as the
router (which might just be a switch at that point) then the supernode
is just a node cluster where ethernet is the L2 transport instead of
adhoc wireless.
