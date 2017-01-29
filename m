Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 29 Jan 2017 14:10:00 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170129130959.GC6468@otheros>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
 <7073965.bG8vkJTefB@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7073965.bG8vkJTefB@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH 0/6] batman-adv: broadcast packet
 aggregation
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

On Sun, Jan 22, 2017 at 02:08:50PM +0100, Sven Eckelmann wrote:
> On Montag, 19. Dezember 2016 12:25:29 CET Linus Lüssing wrote:
> > Hi,
> > 
> > Here is a first patchset to reintroduce aggregation support for BATMAN V, too.
> > And while at it, for BATMAN VI, VII... etc, as well - in fact, it allows
> > aggregating any batman packet with a broadcast destination ;).
> > 
> > I am sending it as an RFC for now as compat code is still missing. And although
> > it was tested in VMs, I still need to do some stress testing on some
> > embedded routers.
> 
> I have not actually looked at the code. But I would guess that your ultimate
> goal is to reduce the overhead when sending broadcast either over wifi or
> complex setups with things like VPNs (fastd). Did you do some captures on some
> gluon supernodes (or actually only on a link to this supernode) and calculated
> how many packets/bytes were sent over the DSL (up/down), how much overhead was
> added, how many packets would potentially be aggregated by your approach and
> how many packets/bytes would have been send over the DSL (up/down)?

I've just recorded a 20min. capture from the Freifunk Lübeck
network with about 370 nodes and about 410 clients at the time of
recording. This capture is just multicast traffic and after decapsulation
(so from the soft- and not hard-interface). The firmware is Gluon based, so
most multicast from the clients is already filtered before it enters the mesh
(mDNS, LLMNR etc.).

The recording has the following characteristics:

# Input
Number of packets: 32260 pkts
Duration: 1259.047 sec
25.623 pkts/s ave.
78 B / pkt ave. (***)
0.016 MBit/s ave.


Then, in a VM I created a veth-pair and attached a bat0 and a bat1
to it. I disabled BLA, DAT and Multicast Optimizations and IPv6 on
bat0 and bat1. Then I used "tcpreplay" to replay the recording on
bat0. I checked that all 32260 packets came out of bat1 again.

For the aggregation measurement I was measuring on
hard-interfaces, so one end of the veth-pair. The characteristics
there were the following:

# Aggregation: Off
Number of packets: 37377 pkts (*)
Duration: 1301.274 sec (**)
28.723 pkts/s ave.
101 B / pkt ave. (***)
0.023 MBit/s ave.

And after turning aggregation on:

# Aggregation: On
13420 pkts
Duration: 1292.869 sec (**)
10.380 pkts/s
267 B / pkt 
0.022 MBit/s

(*): OGMs and ELP packets are included here, too.
(**): Seems like tcpreplay is a little inaccurate regarding it's
timings.
(***): Larger packet size due to additional batman-adv and
ethernet headers.


## Conclusion

In this example scenario, the number of packets could be reduced
by a factor of 2.79 (37377 vs. 13420) while increasing the average
packet size by a factor of 2.64 (101 bytes vs. 267 bytes). While
in this case the average bitrate stayed about the same
(0.023Mbit/s vs. 0.022MBit/s), in cases of additional
encapsulation (e.g. VPNs) or preambles (802.11), the 2.79  times
less packets should have a noticeable, positive performance
impact. I haven't measured it directly, but we can calculate an
example:

For instance the VPN tool "fastd", would add additional
headers in sizes of up to 86 bytes (40B IPv6 + 46B UDP+fastd) [1].
Therefore reducing the number of broadcast packets by 2.79 should
reduce the effective multicast bitrate of:

 of:	42.97 kbit/s = (101+86)*8*28.723/1000 kbit/s
 to:	29.31 kbit/s = (267+86)*10.380*8/1000)
 => 32% overhead reduction

Note that in practice the relative reduction should be even higher,
as this measurement only considered the aggregation of multicast
packets from 410 clients and OGM+ELP packets from two nodes. In
the real setup the factor of 2.79 should be slightly larger because
the OGMs from the 370 nodes would result in additional
aggregation opportunities.
