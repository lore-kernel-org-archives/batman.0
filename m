Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Jun 2014 12:53:20 +0800
Message-ID: <6992822.ghf2EUPW9C@diderot>
In-Reply-To: <20140617222414.GG29033@Linus-Debian>
References: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
 <1982917.uLe1stfMfi@diderot> <20140617222414.GG29033@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart31191660.vWVaamfveI";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast optimization
	support for bridged setups
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


--nextPart31191660.vWVaamfveI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 18 June 2014 00:24:14 Linus L=FCssing wrote:
> A batman-adv node needs to know on/behind which other batman-adv
> node a multicast listener exists to be able to know where it needs
> to forward multicast packets to. A multicast listener can either
> sit on bat0, on a bridge on top of bat0. Or in this case, that's
> what "mla_bridge_get" is for, behind the bridge.
>=20
> We usually don't have direct access to the kernel of weird Windows
> machines behind a bridge. Luckily a protocol, Multicast Listener
> Discovery, exists to detect such multicast listeners.
>=20
> The bridge code has multicast snooping already, so it already
> memorizes what multicast listeners it has behind it's bridge.
> That's what we are fetching here. To add these to our local TT to
> announce them through the mesh.

Thanks for the clarifications but that does not address my question. To=
 be=20
more precise: In batadv_mcast_mla_update() your code is calling=20
batadv_mcast_mla_softif_get() which queries the bridge interface (if br=
idged).=20
A couple of lines later batadv_mcast_mla_bridge_get() is called (if bri=
dged).=20
It looks to me the code queries the bridge twice ?

Then, I am comparing the kernel doc to get the difference but I see non=
e:

 * batadv_mcast_mla_softif_get - get softif multicast listeners
 * @dev: the device to collect multicast addresses from
 * @mcast_list: a list to put found addresses into
 *
 * Collect multicast addresses of the local multicast listeners
 * on the given soft interface, dev, in the given mcast_list.
 *
 * If there is a bridge interface on top of dev, collect from that one
 * instead.

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * batadv_mcast_mla_bridge_get - get bridged-in multicast listeners
 * @dev: a bridge slave whose bridge to collect multicast addresses fro=
m
 * @mcast_list: a list to put found addresses into
 *
 * Collects multicast addresses of the bridged-in multicast listeners
 * from the bridge on top of the given soft interface, dev, in the
 * given mcast_list.

What is the difference between these calls and why doesn't the code exp=
lain=20
that difference ?

Cheers,
Marek

--nextPart31191660.vWVaamfveI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJToRtDAAoJEFNVTo/uthzAwbsH/02L0tHl6fE6fMYp2y0q0T40
ISddiS+8Y5PUhvQOHGj1lZHGwQSjXHK3gEuqerAySmJKj6k3mwMtOCplYxC02xJO
pRjIG6GQpxqCwharynfexzvFx7aOooRcHMybxmDgtRvpIq+aaPd3fVZhCToO8wSz
UpmA8chGydn3hDL5KVyFNTXcZ/A7lHRQUCC1NklN1VjGtRJCOyjdLrmI31nRPw7K
/Bpk6fMztzE8eJA2RMBZn1L5cbex5Nij1VYtQFjfbmq3Y8EBKR0HDSZu7MrFAVs1
DuD8FgFkE5L5dIqh4kkf2hRWytMq3cX/ZniHsZD27mX68Yc6W5IJHfQWwUYzt+Q=
=El0V
-----END PGP SIGNATURE-----

--nextPart31191660.vWVaamfveI--

