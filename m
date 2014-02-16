Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:32:43 +0800
Message-ID: <2129858.6hlNT8CZE3@diderot>
In-Reply-To: <1392482874-9024-7-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-7-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1651822.kPfhneRkYr";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 6/6] batman-adv: Send multicast
	packets to nodes with a WANT_ALL flag
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1651822.kPfhneRkYr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:54 Linus L=FCssing wrote:
> With this patch a node sends IPv4 multicast packets to nodes which
> have a BATADV_MCAST_WANT_ALL_IPV4 flag set and IPv6 multicast packets=

> to nodes which have a BATADV_MCAST_WANT_ALL_IPV6 flag set, too.
>=20
> Why is this needed? There are scenarios involving bridges where
> multicast report snooping and multicast TT announcements are not
> sufficient, which would lead to packet loss for some nodes otherwise:=

>=20
> MLDv1 and IGMPv1/IGMPv2 have a suppression mechanism
> for multicast listener reports. When we have an MLDv1/IGMPv1/IGMPv2
> querier behind a bridge then our snooping bridge is potentially not
> going to see any reports even though listeners exist because accordin=
g
> to RFC4541 such reports are only forwarded to multicast routers:
>=20
> -----------------------------------------------------------
>             ---------------
> {Querier}---|Snoop. Switch|----{Listener}
>             ---------------
>                        \           ^
>                       -------
>                       | br0 |  <  ???
>                       -------
>                           \
>                      _-~---~_
>                  _-~/        ~-_
>                 ~   batman-adv  \-----{Sender}
>                 \~_   cloud    ~/
>                    -~~__-__-~_/
>=20
> I)  MLDv1 Query:  {Querier}  -> flooded
> II) MLDv1 Report: {Listener} -> {Querier}
>=20
> -> br0 cannot detect the {Listener}
> =3D> Packets from {Sender} need to be forwarded to all
>    detected listeners and MLDv1/IGMPv1/IGMPv2 queriers.
>=20
> -----------------------------------------------------------
>=20
> Note that we do not need to explicitly forward to MLDv2/IGMPv3 querie=
rs,
> because these protocols have no report suppression: A bridge has no
> trouble detecting MLDv2/IGMPv3 listeners.
>=20
> Even though we do not support bridges yet we need to provide the
> according infrastructure already to not break compatibility later.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  main.c           |    2 +
>  multicast.c      |  178
> +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> packet.h         |    4 ++
>  send.c           |    1 +
>  soft-interface.c |    2 +
>  types.h          |   14 ++++-
>  6 files changed, 198 insertions(+), 3 deletions(-)

Applied in revision 02705e4.

Thanks,
Marek

--nextPart1651822.kPfhneRkYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFuLAAoJEFNVTo/uthzA5pkH/3piNljQdMuqmSp4tQuiM1YN
wDNWJgl4huBlJbsw9GLJJgFJA6ExPRwjK1vzM4SXhIQbGoSYs8thz6ejodNedyl0
bhk5useoDnIQxlZ11NNk9Il9kR8GMdq9mCH3rklFtxWGIy1eXBtcCkF1wonz7HpU
2NRqM+SbRdpiWcdpLap4TEkUsuCzKT18QMVecsX58C40F8vDZIFX3bG40bX6nBQp
+qG7Cx0SA7MBaHe82ojsLAOlbh6V9fQCFTYfi6Ru5Xs+GJAlCwAVjFg1GZdNwzOC
m3ovad87ZCRw+bnD5vPQsc/QzpcY/y/OL2wue3tbzi2lu7gxCTTTBMA7lbWO6dc=
=8dOd
-----END PGP SIGNATURE-----

--nextPart1651822.kPfhneRkYr--

