Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 9 Sep 2020 16:53:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH maint v2 3/4] batman-adv: mcast: fix duplicate mcast
 packets in BLA backbone from mesh
Message-ID: <20200909145357.GB2391@otheros>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue>
 <20200904182803.8428-4-linus.luessing@c0d3.blue>
 <2973088.WcO1NEu1zB@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2973088.WcO1NEu1zB@prime>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Sep 09, 2020 at 02:06:06PM +0200, Simon Wunderlich wrote:
> >         if (unlikely(atomic_read(&bat_priv->bla.num_requests)))
> >                 /* don't allow broadcasts while requests are in fligh=
t */
> > -               if (is_multicast_ether_addr(ethhdr->h_dest) && is_bca=
st)
> > +               if (is_multicast_ether_addr(ethhdr->h_dest) &&
> > +                   (!is_broadcast_ether_addr(ethhdr->h_dest) || is_b=
cast))
> >                         goto handled;
>=20
> Isn't this exactly the same logic as it was before?
>=20
> is_multicast =3D=3D 0, is_bcast =3D 0 =3D> 0
> is_multicast =3D=3D 0, is_bcast =3D 1 =3D> 0
> is_multicast =3D=3D 1, is_bcast =3D 0 =3D> 0
> is_multicast =3D=3D 1, is_bcast =3D 1 =3D> 1

The 3rd one should be different. Note that "is_bcast" is not the same as
is_broadcast_ether_addr(ethhdr->h_dest). The former refers to the
batman-adv packet header, while the latter refers to the
destination MAC of the inner ethernet header.


> On Friday, September 4, 2020 8:28:02 PM CEST Linus L=C3=BCssing wrote:
> > For DHCPv6: This is even trickier... DHCPv6 potentially uses
> > non-broadcast multicast addresses. However according to RFC8415, sect=
ion
> > 7.1 it seems that currently multicast is only used from a DHCPv6 clie=
nt
> > to a DHCPv6 server, but not the other way round.
> >=20
> > Working through the gateway feature part in batadv_interface_tx() it =
can
> > be inferred that a DHCPv6 packet to a DHCP client would have been the=
 only
> > option for a DHCPv6 multicast packet to be sent via unicast through t=
he
> > gateway feature. Ergo, the newly introduced claim check won't wrongly
> > drop a DHCPv6 packet received via the gateway feature either.
>=20
> I also don't get this part. Maybe it helps if you can explain the two=20
> directions (client -> server, server -> client), and in which cases the=
re can=20
> be multicast, and then describe why your check is sufficient?

Hm, actually it's not just the description that is messed up, I
think. server->client is ok, but client->server isn't...

* DHCPv6 server -> client:
-> Easy, according to RFC8415, section 7.1 this would always be
   unicast. So neither the Gateway nor Multicast feature would
   touch it.

* DHCPv6 client -> server:
-> Actually both the gateway feature and multicast feature can use
   it. I misread the code...

I'm a bit uncertain how to solve the latter now... I see no way to
distinguish gw vs. mcast feature as is. We also have no flags
or reserved space in the batadv_unicast_packet available to make
them distinguishable.

So the only solution I could think of for now is
excluding DHCPv6 from multicast feature in TX of the originator...
(in batadv_mcast_forw_mode_check_ipv6(), adding excludes for
ff02::1:2 and ff05::1:3).

(Even though having the multicast feature handling it would
have been nice(r) as it'd work without needing a user to
set and maintain the gateway mode properly.)
