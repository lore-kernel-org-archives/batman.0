Return-Path: <bittorf@bluebottle.com>
Date: Sun, 3 Nov 2013 10:18:32 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131103091832.GR6252@medion.lan>
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net>
 <20131101143305.GO6252@medion.lan>
 <20131101143903.GX970@neomailbox.net>
 <20131101151626.GP6252@medion.lan>
 <5275F6CC.9080009@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5275F6CC.9080009@altermundi.net>
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

* Gui Iribarren <gui@altermundi.net> [03.11.2013 09:52]:
> >Each node has a macvlan called 'gateway0' which has the IP 192.168.0.1/32
> >This is just an IP which every DHCP-Client gets for "default-gateway".
> >(so the gateway is the node itself and not the internet-offering-node).
> >This looks like this:
> >
> >root@node222hybrid:~ ip address show dev gateway0
> >15: gateway0@br-mybridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
> >qdisc noqueue state UNKNOWN group default
> >     link/ether 02:00:c0:ca:c0:1a brd ff:ff:ff:ff:ff:ff
> 
> if this mac (02:00:c0:ca:c0:1a) exists on several different nodes
> that are not connected by a real ethernet backbone (and BLA2 enabled)
> then batman goes mushroom tripping, since it 'sees' that MAC as a
> non-mesh-client that is everywhere at the same time, and tries to
> roam it around, creating funny symptoms (like DUPs and such)

BINGO! thank you Gui - if i read the old mails, i can even see it
i the transglobal table. if i look into the mesh, it pop's up on
random nodes with random originators. yes: mushroom tripping 8-)

i will try the ebtables approach, but i dont like it.
IMHO it's more elegant to just 'ignore' this mac by the
daemon itself:

To the devs: is this possible?

bye, bastian
