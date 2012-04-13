Return-Path: <andrew@lunn.ch>
Date: Fri, 13 Apr 2012 07:59:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120413055947.GH7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Mitar <mitar@tnode.com>

On Thu, Apr 12, 2012 at 11:08:48PM +0200, Mitar wrote:
> Hi!
> 
> On Thu, Apr 12, 2012 at 5:37 PM, Jernej Kos <k@jst.sm> wrote:
> > Since from layer 3, the batman mesh looks just like a big LAN, any node
> > could simply add a route saying "prefix A via gateway B dev bat0" where
> > B is a mesh node known to batman via its L2 identifier, no?
> 
> So I have almost convinced Kostko that we could switch to Batman, but
> he does not want to run multiple routing daemons on nodes. So could
> Batman support announcing also L3 prefixes?

A few points here:

1) You need, in your head, a clear separation between L3 and L2.  Your
   L3 gateways need routes. Your L2 only nodes don't need routes,
   except the default route, to the gateway out of the current L2
   mesh.

   Just think about plain old Ethernet networking, and you won't go
   too far wrong. In an Ethernet based network, you have maybe 2 nodes
   which are gateways, and run L3 routing protocols. All the rest of
   the devices are L2 only and have a default route pointing it one of
   the two gateways out of the Ethernet to the rest of the world.

2) BATMAN is not a daemon. Its a kernel module. Hence it cannot play
   around with routes, even if it wanted to. Also, adding/removing
   routes is policy, and the Linux/Unix view of the world is that user
   space is responsible for deciding policy.

> For example, that in the
> node configuration you could define that that node (let say it has IP
> 10.10.10.10) should announce also some L3 subnet. Like
> 192.168.42.0/24. And when that node would be reachable from other
> node, that other node would run:
> 
> ip route add prefix 192.168.42.0/24 via gateway 10.10.10.10 dev bat0
> 
> Doable? Because to run additional routing daemon just to rediscover
> which nodes are around and announce things ... when Batman already
> knows all this ...

Nope. BATMAN has no idea. That is a L3 address. BATMAN is L2, it only
knows L2 Addresses. All it knows is that MAC address 02:01:02:03:04:05
can be reached by sending packets towards the next hop
02:06:07:08:09:0A.

Here is a rather boring example of that BATMAN knows, from a real
device:

root@tmn4:~# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: br0/00:80:48:6b:9d:36 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
00:80:48:6b:9d:35    0.084s   (255) 00:80:48:6b:9d:35 [       wlan0]: 00:80:48:6b:9d:3a (166) 00:80:48:6b:9d:35 (255)
00:80:48:6b:9d:3a    0.352s   (216) 00:80:48:6b:9d:35 [       wlan0]: 00:80:48:6b:9d:35 (216) 00:80:48:6b:9d:3a (181)


So:
In order to reach 00:80:48:6b:9d:35, send packets to 00:80:48:6b:9d:35
In order to reach 00:80:48:6b:9d:3a, send packets to 00:80:48:6b:9d:35

This comes back to:

     You need, in your head, a clear separation between L3 and L2.

     Andrew
