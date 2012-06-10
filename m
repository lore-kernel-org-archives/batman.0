Return-Path: <ordex@autistici.org>
Date: Mon, 11 Jun 2012 01:23:00 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120610232259.GA23542@ritirata.org>
References: <CAHD-aqK3yvVCDi9wucx4nX5jM4OjxbjbUFz3QHG+KzzuoMhz7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <CAHD-aqK3yvVCDi9wucx4nX5jM4OjxbjbUFz3QHG+KzzuoMhz7Q@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv gw_mode and ipv6 router advertisements
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


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guido,

On Sun, Jun 10, 2012 at 08:14:27PM -0300, Guido Iribarren wrote:
> Hello everyone,
> in the deploy of DeltaLibre (a local WCN very similar to EigenNet
> (part of ninux) in Italy) i'm facing a dilemma:
> i'm currently using batman-adv gw_mode client in all nodes, and the
> ones that connect directly to internet through an ISP have gw_mode =3D
> server
> This way, clients have their DHCP requests transparently unicasted to
> the 'best' gateway, and get a corresponding IPv4 and default gw.
> Which is great.

correct.

>=20
> But in IPv6 there's no equivalent functionality. If two routers on the
> same broadcast domain (batman-adv cloud) run radvd and announce two
> different prefixes, all hosts on the network autoconfigure 2 ips, one
> in each prefix. Then, AFAIU, it's up to the client to choose between
> the announced gateways, to send the traffic.
>=20

yes. batman-adv does treat RA packets as normal broadcasts. They are neither
filtered nor handled in any particular way.

> Are there any plans of implementing in batman-adv something analog to
> the mangling done on DHCPv4 packets, to RA packets as well? (the
> mechanism would be the inverse: instead of unicasting queries and
> replies, propagate to clients only 1 RA packet out of all incoming;
> decide which one to propagate based on gw_mode current logic)
>=20

someone proposed the idea on the bugtraq, but no plans about implementation=
 have
been seen so far..

> Or, at least, extend the current mangling done in DHCPv4 packets to
> DHCPv6 packets as well?
>=20

this is already implemented. Gw_mode supports snooping of both dhcpv4 and
dhcpv6 packets. So you could use dhcpv6 instead of radvd (at least for now).

> I would *love* to simply show some code instead of asking 'wishlist'
> questions, but sadly i'm not a programmer :(

you are contributing anyway :-)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJP1SxTAAoJEFMQTLzJFOZFexsIAMAX4vSSUbvR1wYESpHTo9b+
wEhN1VwPzOosy+7wGYMueDfTj0bQDK2RgQnfBHcwYtQ2c1ohq9WsIlP1U95VOnwW
yOC2fvDuD7h02mu9I9xvH8Mg/34ZRBp0zCvJiq9vtowlhxUmi7KojWeF3fXtboJR
ivPvhr2EX3jYMObgcFlMgnl5mNNra1wbMsk84DBo02MxZ96LwQZa5Dsl9v5iezp5
LB3ZgvhyhVoXcaswKd3KiStolKwe6OmiLrevLAkWvGAEm5d9XcxxRUG8kiaFxPLS
2z8dpZQDHIjsyweBsX1Eesoq69iGt4icpE6/Q8N7Ej3bGTX0KrSR/wcpPXK/x1Q=
=MyuC
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
