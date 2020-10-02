Return-Path: <sd@queasysnail.net>
Date: Fri, 2 Oct 2020 11:07:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net 00/12] net: iflink and link-netnsid fixes
Message-ID: <20201002090703.GD3565727@bistromath.localdomain>
References: <cover.1600770261.git.sd@queasysnail.net>
 <20201001142538.03f28397@hermes.local>
MIME-Version: 1.0
In-Reply-To: <20201001142538.03f28397@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>

2020-10-01, 14:25:38 -0700, Stephen Hemminger wrote:
> On Thu,  1 Oct 2020 09:59:24 +0200
> Sabrina Dubroca <sd@queasysnail.net> wrote:
>=20
> > In a lot of places, we use this kind of comparison to detect if a
> > device has a lower link:
> >=20
> >   dev->ifindex !=3D dev_get_iflink(dev)
>=20
>=20
> Since this is a common operation, it would be good to add a new
> helper function in netdevice.h
>=20
> In your patch set, you are copying the same code snippet which
> seems to indicate that it should be a helper.
>=20
> Something like:
>=20
> static inline bool netdev_has_link(const struct net_device *dev)
> {
> =09const struct net_device_ops *ops =3D dev->netdev_ops;
>=20
> =09return ops && ops->ndo_get_iflink;
> }

Good idea, I'll add that in v2.

--=20
Sabrina

