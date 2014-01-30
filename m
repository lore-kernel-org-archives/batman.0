Return-Path: <antonio@meshcoding.com>
Message-ID: <52EA5AAB.8080101@meshcoding.com>
Date: Thu, 30 Jan 2014 14:59:07 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <20140130125206.GA23793@elgon.mountain>
In-Reply-To: <20140130125206.GA23793@elgon.mountain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iAn5WD4J4x1fdwoI8uFHM2lEfbIJUCqmJ"
Subject: Re: [B.A.T.M.A.N.] question about min_t() casting in
	batadv_hardif_min_mtu()
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
To: dan.carpenter@oracle.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iAn5WD4J4x1fdwoI8uFHM2lEfbIJUCqmJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Dan,


On 30/01/14 13:52, Dan Carpenter wrote:
> Hello Batman devs,
>=20
> I always worry when I see people do min_t(int, foo, bar) and there are
> a couple cases which concern me in batman.
>=20
> Changing the mtu is allowed for people who have admin rights in their
> namespace.  In other words we check:
> 	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> as opposed to:
> 	if (!capable(net->user_ns, CAP_NET_ADMIN))
> So mtu has security implications.
>=20

Thanks for sharing your concern and opinions

> net/batman-adv/hard-interface.c
>    240  int batadv_hardif_min_mtu(struct net_device *soft_iface)
>    241  {
>    242          struct batadv_priv *bat_priv =3D netdev_priv(soft_iface=
);
>    243          const struct batadv_hard_iface *hard_iface;
>    244          int min_mtu =3D ETH_DATA_LEN;
>    245 =20
>    246          rcu_read_lock();
>    247          list_for_each_entry_rcu(hard_iface, &batadv_hardif_list=
, list) {
>    248                  if ((hard_iface->if_status !=3D BATADV_IF_ACTIV=
E) &&
>    249                      (hard_iface->if_status !=3D BATADV_IF_TO_BE=
_ACTIVATED))
>    250                          continue;
>    251 =20
>    252                  if (hard_iface->soft_iface !=3D soft_iface)
>    253                          continue;
>    254 =20
>    255                  min_mtu =3D min_t(int, hard_iface->net_dev->mtu=
, min_mtu);
>                                         ^^^
> Ok.  This is fine because dev_set_mtu() will not allow negative mtus.
>=20
>    256          }
>    257          rcu_read_unlock();
>    258 =20
>    259          atomic_set(&bat_priv->packet_size_max, min_mtu);
>    260 =20
>    261          if (atomic_read(&bat_priv->fragmentation) =3D=3D 0)
>    262                  goto out;
>    263 =20
>    264          /* with fragmentation enabled the maximum size of inter=
nally generated
>    265           * packets such as translation table exchanges or tvlv =
containers, etc
>    266           * has to be calculated
>    267           */
>    268          min_mtu =3D min_t(int, min_mtu, BATADV_FRAG_MAX_FRAG_SI=
ZE);
>                                 ^^^
> Still fine.
>=20
>    269          min_mtu -=3D sizeof(struct batadv_frag_packet);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> I worry that this could be negative.

Practically this "should" not happen because sizeof(struct
batadv_frag_packet) is 20 bytes and the smallest MTU over all the
interfaces that batman-adv is using should be not less than 68bytes (at
least this is what a sane Ethernet driver would allow).

Is there any Ethernet driver that allows the MTU to be smaller than 68?
Well, excluding all the broken ones :)

However this is a very good point! If we want to be on the safe side we
should check for min_mtu being always larger than a certain threshold
(e.g. 68 :-)).

>=20
>    270          min_mtu *=3D BATADV_FRAG_MAX_FRAGMENTS;
>    271          atomic_set(&bat_priv->packet_size_max, min_mtu);
>                                                        ^^^^^^^
> Could a negative cause problems here?

Mh..I think this can generate an endless loop in
batadv_tt_local_resize_to_mtu()...

>=20
>    272 =20
>    273          /* with fragmentation enabled we can fragment external =
packets easily */
>    274          min_mtu =3D min_t(int, min_mtu, ETH_DATA_LEN);
>                 ^^^^^^^
> min_mtu would still be negative here.
>=20
>    275 =20
>    276  out:
>    277          return min_mtu - batadv_max_header_len();
>    278  }
>=20
> regards,
> dan carpenter
>=20

But why don't dev_set_mtu() check for the argument to be larger than
68bytes? Isn't that a general requirement?

Cheers,


--=20
Antonio Quartulli


--iAn5WD4J4x1fdwoI8uFHM2lEfbIJUCqmJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS6lqwAAoJEEKTMo6mOh1VwB8P/Ama7TiJaHbjhyFrRq+aTmrR
A9+y6QtJNJx+qPG6ezDjJQW3T2MobSoNYatH4VnHuqjkehrwfHUJTBAQTQvSSkD7
+F9bH+tnJwnO7m3tf18M/9x99i/0m+z2YF4U/1woolcgJE1j7RFl9NALqJFS1uZB
0M89ElzH643N5AfirZEf0usnM2g0Hl5/22bP+z+NNko+v/NbWBD23E5SjPLCEcbb
aAQtjzyRKxVy2fN6g+T5gUkxLHKD20kwRDsPRtaNd1O/3Q1miFxH5nRorX4ZMdzN
eB+Q6Ovzj+pbKJYoLTSds6O8v6oSNJnoF5uLUYha2lWaZF7+JT5Gqf92VS1nyUeh
nPhmEQ4dhoHKuOVR0wrtrtSTNKMqrhXJDDxKf+w+DZGgZdmH0NtioWTsA5hEvPxX
gwiRnQwIIqYG0H5fBdW324ck6G/A6ekfRuZ/0WdCAP64ES93IvNsGrlmtC/6jMvk
853LHdPIrlthpTGFTb0bGtSUJRsv4jvOIDHlA9xMpMt/SOVF8tGxM9etIJBFRDYd
4Mgv4hvELTqhII+JLfGgfLwMr27NmQ39XQDnDgopgUxbfuHQCbK6uafh39D7TxDI
Dw8no+669RowCVNTlTZCBcQLbJGz2kbnWk7fY9wxNb/0Op9DgINnFaIKyY/Dm6WR
+rqh1+5KkhBTS4rwDWdb
=/ooZ
-----END PGP SIGNATURE-----

--iAn5WD4J4x1fdwoI8uFHM2lEfbIJUCqmJ--
