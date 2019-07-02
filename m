Return-Path: <idosch@idosch.org>
Date: Tue, 2 Jul 2019 20:11:58 +0300
From: Ido Schimmel <idosch@idosch.org>
Subject: Re: [RFC net-next] net: dsa: add support for MC_DISABLED attribute
Message-ID: <20190702171158.GA7182@splinter>
References: <20190620235639.24102-1-vivien.didelot@gmail.com>
 <5d653a4d-3270-8e53-a5e0-88ea5e7a4d3f@gmail.com>
 <20190621172952.GB9284@t480s.localdomain>
 <20190623070949.GB13466@splinter>
 <20190623072605.2xqb56tjydqz2jkx@shell.armlinux.org.uk>
 <20190623074427.GA21875@splinter> <20190629162945.GB17143@splinter>
 <20190630165601.GC2500@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190630165601.GC2500@otheros>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>, nikolay@cumulusnetworks.com, Ido Schimmel <idosch@mellanox.com>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org

On Sun, Jun 30, 2019 at 06:56:01PM +0200, Linus L=FCssing wrote:
> > On Sun, Jun 23, 2019 at 10:44:27AM +0300, Ido Schimmel wrote:
> > > See commit b00589af3b04 ("bridge: disable snooping if there is no
> > > querier"). I think that's unfortunate behavior that we need because
> > > multicast snooping is enabled by default. If it weren't enabled by
> > > default, then anyone enabling it would also make sure there's a queri=
er
> > > in the network.
>=20
> I do not quite understand that point. In a way, that's what we
> have right now, isn't it? By default it's disabled, because by
> default there is no querier on the link. So anyone wanting to use
> multicast snooping will need to make sure there's a querier in the
> network.

Hi Linus,

Querier state is not reflected to drivers ATM, so drivers believe the
bridge is multicast aware and unregistered multicast packets are only
flooded to mrouter ports. Hosts that are silent (because there is no
querier) never get the traffic addressed to them (f.e., IPv6 neighbour
solicitation).

> Overall I think the querier (election) mechanism in the standards could
> need an update. While the lowest-address first might have
> worked well back then, in uniform, fully wired networks where the
> position of the querier did not matter, this is not a good
> solution anymore in networks involving wireless, dynamic connections.
> Especially in wireless mesh networks this is a bit of an issue for
> us. Ideally, the querier mechanism were dismissed in favour of simply
> unsolicited, periodic IGMP/MLD reports...
>=20
> But of course, updating IETF standards is no solution for now.=20
>=20
> While more complicated, it would not be impossible to consider the
> querier state, would it? I mean you probably already need to
> consider the case of a user disabling multicast snooping during
> runtime, right?=20

Sure, this is implemented.

> So similarly, you could react to appearing or disappearing queriers?

Yes, but it's a bit more complicated since we need to differentiate
between IPv4 and IPv6. If the bridge is multicast aware, but there is
only IPv4 querier on the link, then:

1. All the IPv6 MDB entries need to be removed from the device. At least
in mlxsw, we do not have a way to ignore only IPv6 entries. From the
device's perspective, an MDB entry is just a multicast DMAC with a
bitmap of ports packets should be replicated to.

2. We need to split the flood tables used for IPv4 and IPv6 unregistered
multicast packets. For IPv4, packets should only be flooded to mrouter
ports whereas for IPv6 packets should be flooded to all the member
ports.

Do you differentiate between IPv4 and IPv6 in batman-adv?

> Cheers, Linus

Thanks for the feedback!
