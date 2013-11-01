Return-Path: <bittorf@bluebottle.com>
Date: Fri, 1 Nov 2013 16:16:26 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131101151626.GP6252@medion.lan>
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net>
 <20131101143305.GO6252@medion.lan>
 <20131101143903.GX970@neomailbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131101143903.GX970@neomailbox.net>
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

* Antonio Quartulli <antonio@meshcoding.com> [01.11.2013 16:04]:
> > both nodes are not connected via cable and are nodes in hybrid-mode (ap+adhoc).
> > no special tricks, 'only' macvlan. BLA2 is active on all nodes.
> > 
> > the again: why does batman-adv think, that the client (my laptop) is/was
> > reachable over 02:00:ca:b1:00:13 - the laptop was never there? a hash-collision?
> 
> No. This happens when bat0 on one node and bat0 on the other are bridged
> together. The common scenario for this is that you have the two nodes connected
> to an Ethernet switch and you have bat0 bridged into this LAN. At this point the
> "two bat0s" will get in touch with each other. Like the first picture in this
> page[1].
> 
> The "only" macvlan thing is probably something we should try to investigate
> further :-)
> You are the first reporting strange issues like this and the fact that this
> happens quite often means that there is something in the network setup that is
> triggering this problem.

All nodes are in 'hybrid' mode, so adhoc+ap on 1 or more radio's.
Each interface, e.g. LAN/WAN/ADHOC is an batman-adv interface, each
AP-Mode/hostapd-interfaces is bridged to bat0, so it looks like:

root@node15hybrid:~ batctl interface
eth0.1: active		# LAN
eth0.2: active		# WAN
wlan0-1: active		# adhoc-2.4ghz
wlan1-1: active		# adhoc-5ghz

root@node15hybrid:~ brctl show
bridge name     bridge id               STP enabled     interfaces
br-mybridge     7fff.460a753cf247       no              bat0
                                                        wlan0	# AP-2.4ghz
                                                        wlan1	# AP-5ghz

A few number of nodes are coupled via wire (this works).
Each node has an IP of 192.168.x.1/16 where X is a uniq number.

Each node has a macvlan called 'gateway0' which has the IP 192.168.0.1/32
This is just an IP which every DHCP-Client gets for "default-gateway".
(so the gateway is the node itself and not the internet-offering-node).
This looks like this:

root@node222hybrid:~ ip address show dev gateway0
15: gateway0@br-mybridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
qdisc noqueue state UNKNOWN group default 
    link/ether 02:00:c0:ca:c0:1a brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.1/32 scope global gateway0
       valid_lft forever preferred_lft forever
    inet6 fe80::c0ff:feca:c01a/64 scope link 
       valid_lft forever preferred_lft forever

Each node is a batman-adv gateway, so 'batctl gwl' outputs every node.
(so DHCP-questions are not forwarded but ansered locally).

The backbone-table seems to be empty on every node.

Does this help? bye, bastian
