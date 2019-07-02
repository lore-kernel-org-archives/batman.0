Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 3 Jul 2019 01:13:08 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [RFC net-next] net: dsa: add support for MC_DISABLED attribute
Message-ID: <20190702231308.GA2414@otheros>
References: <20190620235639.24102-1-vivien.didelot@gmail.com>
 <5d653a4d-3270-8e53-a5e0-88ea5e7a4d3f@gmail.com>
 <20190621172952.GB9284@t480s.localdomain>
 <20190623070949.GB13466@splinter>
 <20190623072605.2xqb56tjydqz2jkx@shell.armlinux.org.uk>
 <20190623074427.GA21875@splinter> <20190629162945.GB17143@splinter>
 <20190630165601.GC2500@otheros> <20190702171158.GA7182@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702171158.GA7182@splinter>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, nikolay@cumulusnetworks.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>, Ido Schimmel <idosch@mellanox.com>, Vivien Didelot <vivien.didelot@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org

Hi Ido,

> Do you differentiate between IPv4 and IPv6 in batman-adv?

For most things, yes: The querier state is kept separately for
IPv4 and IPv6. And we do have something like a "router node"
flag to signalize that a node needs all multicast traffic, which
is split into IPv4 and IPv6.

The "MDB" equivalent in batman-adv (multicast entries in our "TT",
translation table) are on MAC address base right now, not on an IP
address base yet, so that sounds similar to what you do in mlxsw?

Regarding querier state, we periodically ask the
bridge via "br_multicast_has_querier_anywhere(dev, ETH_P_IP)"
and "br_multicast_has_querier_anywhere(dev, ETH_P_IPV6)".

(Something more event based with handler functions would probably
be nicer, but this was the easier thing to start with.)


> 1. All the IPv6 MDB entries need to be removed from the device. At least
> in mlxsw, we do not have a way to ignore only IPv6 entries. From the
> device's perspective, an MDB entry is just a multicast DMAC with a
> bitmap of ports packets should be replicated to.

Ah, I see, yes. We had a similar "issue". Initially we just always
added any multicast entry into our translation table offered by
the IP stack or bridge, no matter what a querier state or "router
node" state said. Which would have led to a node receiving two
copies of a multicast packet if it were both a querier or router
and were also having a listener announced via IGMP/MLD.

So there we also just recently changed that, to filter out
IPv6 multicast TT entries if this node were also announcing itself as
an MLD querier or IPv6 router. And same, independently for
IPv4/IGMP.

> 2. We need to split the flood tables used for IPv4 and IPv6 unregistered
> multicast packets. For IPv4, packets should only be flooded to mrouter
> ports whereas for IPv6 packets should be flooded to all the member
> ports.

This one I do not fully understand yet. Why don't you apply the
"flood to all ports" (in the no IGMP querier present case)
for IPv4, too?

Sure, for IPv4 nothing "essential" will break, as IPv4 unicast
does not rely on multicast (contrary to IPv6, due to NDP, as you
mentioned). But still there would be potential multicast packet loss
for a 239.x.x.x listener on the local link, for instance, wouldn't
there?


If I'm not mistaken, we do not apply differing behaviour for IPv4
vs. IPv6 in the bridge either and would flood on all ports for IPv4
with no querier present, too.

Regards, Linus
