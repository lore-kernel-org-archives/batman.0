Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sun, 10 Jun 2012 20:14:27 -0300
Message-ID: <CAHD-aqK3yvVCDi9wucx4nX5jM4OjxbjbUFz3QHG+KzzuoMhz7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] batman-adv gw_mode and ipv6 router advertisements
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

Hello everyone,
in the deploy of DeltaLibre (a local WCN very similar to EigenNet
(part of ninux) in Italy) i'm facing a dilemma:
i'm currently using batman-adv gw_mode client in all nodes, and the
ones that connect directly to internet through an ISP have gw_mode =
server
This way, clients have their DHCP requests transparently unicasted to
the 'best' gateway, and get a corresponding IPv4 and default gw.
Which is great.

But in IPv6 there's no equivalent functionality. If two routers on the
same broadcast domain (batman-adv cloud) run radvd and announce two
different prefixes, all hosts on the network autoconfigure 2 ips, one
in each prefix. Then, AFAIU, it's up to the client to choose between
the announced gateways, to send the traffic.

Are there any plans of implementing in batman-adv something analog to
the mangling done on DHCPv4 packets, to RA packets as well? (the
mechanism would be the inverse: instead of unicasting queries and
replies, propagate to clients only 1 RA packet out of all incoming;
decide which one to propagate based on gw_mode current logic)

Or, at least, extend the current mangling done in DHCPv4 packets to
DHCPv6 packets as well?

I would *love* to simply show some code instead of asking 'wishlist'
questions, but sadly i'm not a programmer :(

Thanks a lot,

Guido

pd. I'm pretty new to ipv6, so It's possible that i'm overlooking
'obvious' concepts in my questions: in that case you can politely tell
me to RTFM :)
