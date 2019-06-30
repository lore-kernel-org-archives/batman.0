Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 30 Jun 2019 18:56:01 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [RFC net-next] net: dsa: add support for MC_DISABLED attribute
Message-ID: <20190630165601.GC2500@otheros>
References: <20190620235639.24102-1-vivien.didelot@gmail.com>
 <5d653a4d-3270-8e53-a5e0-88ea5e7a4d3f@gmail.com>
 <20190621172952.GB9284@t480s.localdomain>
 <20190623070949.GB13466@splinter>
 <20190623072605.2xqb56tjydqz2jkx@shell.armlinux.org.uk>
 <20190623074427.GA21875@splinter> <20190629162945.GB17143@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190629162945.GB17143@splinter>
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
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>, nikolay@cumulusnetworks.com, Ido Schimmel <idosch@mellanox.com>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org

On Sat, Jun 29, 2019 at 07:29:45PM +0300, Ido Schimmel wrote:
> I would like to avoid having drivers take the querier state into account
> as it will only complicate things further.

I absolutely share your pain. Initially in the early prototypes of
multicast awareness in batman-adv we did not consider the querier state.
And doing so later did indeed complicate the code a good bit in batman-adv
(together with the IGMP/MLD suppression issues). I would have loved to
avoid that.


> Is there anything we can do about it? Enable the bridge querier if no
> other querier was detected? Commit c5c23260594c ("bridge: Add
> multicast_querier toggle and disable queries by default") disabled
> queries by default, but I'm only suggesting to turn them on if no other
> querier was detected on the link. Do you think it's still a problem?

As soon as you start becoming the querier, you will not be able to reliably
detect anymore whether you are the only querier candidate.

If any random Linux host using a bridge device were potentially becoming
a querier, that would cause quite some trouble when this host is
behind some bad, bottleneck connection. This host will receive
all multicast traffic, not just IGMP/MLD reports. And with a
congested connection and then unreliable IGMP/MLD, multicast would
become unreliable overall in this domain. So it's important that
your querier is not running in the "dark, remote, dusty closet" of
your network (topologically speaking).

> On Sun, Jun 23, 2019 at 10:44:27AM +0300, Ido Schimmel wrote:
> > See commit b00589af3b04 ("bridge: disable snooping if there is no
> > querier"). I think that's unfortunate behavior that we need because
> > multicast snooping is enabled by default. If it weren't enabled by
> > default, then anyone enabling it would also make sure there's a querier
> > in the network.

I do not quite understand that point. In a way, that's what we
have right now, isn't it? By default it's disabled, because by
default there is no querier on the link. So anyone wanting to use
multicast snooping will need to make sure there's a querier in the
network.


Overall I think the querier (election) mechanism in the standards could
need an update. While the lowest-address first might have
worked well back then, in uniform, fully wired networks where the
position of the querier did not matter, this is not a good
solution anymore in networks involving wireless, dynamic connections.
Especially in wireless mesh networks this is a bit of an issue for
us. Ideally, the querier mechanism were dismissed in favour of simply
unsolicited, periodic IGMP/MLD reports...

But of course, updating IETF standards is no solution for now. 

While more complicated, it would not be impossible to consider the
querier state, would it? I mean you probably already need to
consider the case of a user disabling multicast snooping during
runtime, right? So similarly, you could react to appearing or
disappearing queriers?

Cheers, Linus
