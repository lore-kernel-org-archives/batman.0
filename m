Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 15:51:38 +0200
Message-ID: <5043296.Tdbbob6tg4@bentobox>
In-Reply-To: <13645415.zRDBnAsdL4@bentobox>
References: <1350473910-27496-1-git-send-email-linus.luessing@web.de>
 <13645415.zRDBnAsdL4@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2902214.lkt7fXmPbV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix broadcast packet CRC
	calculation
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


--nextPart2902214.lkt7fXmPbV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 17 October 2012 15:50:50 Sven Eckelmann wrote:
> On Wednesday 17 October 2012 13:38:30 Linus L=FCssing wrote:
> > So far the crc16 checksum for a batman-adv broadcast data packet, r=
eceived
> > on a batman-adv hard interface, was calculated over zero bytes of i=
ts
> > content leading to many incoming broadcast data packets wrongly bei=
ng
> > dropped.
> >=20
> > This patch fixes this issue by calculating the crc16 over the actua=
l,
> > complete broadcast payload.
> >=20
> > The issue is a regrission introduced by
> > e5cf86d30a9b32feccb6b866a3f23b0e0483a3b0.
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> > ---
> > It led to about 60-80% broadcast packet loss to a direct neighbor
> > with a ping6 with a 1s interval in our scenario, but about no
> > packet loss with an interval smaller than 0.2s.
> >=20
> > Also see: https://projects.universe-factory.net/issues/65 (German)
> >=20
> >  bridge_loop_avoidance.c |    8 ++++----
> >  routing.c               |    8 +++++++-
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> > index 6705d35..e7b5777 100644
> > --- a/bridge_loop_avoidance.c
> > +++ b/bridge_loop_avoidance.c
> > @@ -1205,8 +1205,8 @@ int batadv_bla_init(struct batadv_priv *bat_p=
riv)
> >=20
> >  /**
> > =20
> >   * batadv_bla_check_bcast_duplist
> >   * @bat_priv: the bat priv with all the soft interface information=

> >=20
> > - * @bcast_packet: originator mac address
> > - * @hdr_size: maximum length of the frame
> > + * @bcast_packet: encapsulated broadcast frame plus batman header
> > + * @bcast_packet_len: length of encapsulated broadcast frame plus =
batman
> > header *
> >=20
> >   * check if it is on our broadcast list. Another gateway might
> >   * have sent the same packet because it is connected to the same
> >   backbone,
> >=20
> > @@ -1219,14 +1219,14 @@ int batadv_bla_init(struct batadv_priv *bat=
_priv)
> >=20
> >   */
> > =20
> >  int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
> > =20
> >  =09=09=09=09   struct batadv_bcast_packet *bcast_packet,
> >=20
> > -=09=09=09=09   int hdr_size)
> > +=09=09=09=09   int bcast_packet_len)
> >=20
> >  {
> > =20
> >  =09int i, length, curr;
> >  =09uint8_t *content;
> >  =09uint16_t crc;
> >  =09struct batadv_bcast_duplist_entry *entry;
> >=20
> > -=09length =3D hdr_size - sizeof(*bcast_packet);
> > +=09length =3D bcast_packet_len - sizeof(*bcast_packet);
> >=20
> >  =09content =3D (uint8_t *)bcast_packet;
> >  =09content +=3D sizeof(*bcast_packet);
> >=20
> > diff --git a/routing.c b/routing.c
> > index bc2b88b..f861b7c 100644
> > --- a/routing.c
> > +++ b/routing.c
> > @@ -1136,8 +1136,14 @@ int batadv_recv_bcast_packet(struct sk_buff =
*skb,
> >=20
> >  =09spin_unlock_bh(&orig_node->bcast_seqno_lock);
> >=20
> > +=09/* keep skb linear for crc calculation */
> > +=09if (skb_linearize(skb) < 0)
> > +=09=09goto out;
> > +
> > +=09bcast_packet =3D (struct batadv_bcast_packet *)skb->data;
> > +
> >=20
> >  =09/* check whether this has been sent by another originator befor=
e */
> >=20
> > -=09if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, hdr_=
size))
> > +=09if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, skb-=
>len))
> >=20
> >  =09=09goto out;
> >  =09
> >  =09/* rebroadcast packet */
>=20
> Btw. why should renaming the hdr_size to bcast_packet_len help to get=
 a
> different value than 0?

Ok, Marek just noticed the skb->len :D

> Kind regards,
> =09Sven
--nextPart2902214.lkt7fXmPbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQfrfqAAoJEF2HCgfBJntGDRsQANfi4mv2CcEJxeP9MchvoYmN
B79C45oMk79kI8dxC8UEkCJWMx3WsSDspWSuYScZ64AxxO49N+/zSCZ0TsQOd64o
WXCsFUNyvapkf5z3dunxMOmlHVC+trzviiAmE5B+KmZkp0lMwpIarQCdp3vimP+Z
6mXHgBxcor1KzrUaqP1rmzXXNPBzoeNjW8SVixvQIbmjdnsepMn4pxZghv1dwKC8
eZgVED81nCuRv0egGdio2z+iDpIn7kpSCA8nSJFtfRZTiozVwkG5UkD8nGngOk4y
ueN5qWFaRlrYlo9jOnr8fl6oorri6pitlaCJYWpumQMNDVKyLh7rkwz4QElB/zeT
/0SUiVaIxd2FHE+qbLtD34d4fkw+X7K4v1cNztUrYqlSCxxsL+DOHOYKdGWQPzHN
Udo7j8N0FGeQXI/1Mnk+1HdZQQYYXJsa2OFAVljLoteDOpqmCJFoHjZ9DEa3b3Fp
hBX3JQlvDmJ24Fc/xjAnWSEEcs1caQtztZNl+SUbygYB3pWY0fekNsdL1g2a45Q9
b8/OKfZAXjkNcu0mnRIxdusNTSlIQUwT5bZYQ7BaMxkf3ykmcAO62jOTbVIPIeGe
R0uzTN4+W4VPh7k/BTU9EOgx0WtYnzDn823vN76f1ogF9Oet99R0LZ4z+MzjyZI+
kMQSDMc97yaum8pMl9UJ
=ITDo
-----END PGP SIGNATURE-----

--nextPart2902214.lkt7fXmPbV--

