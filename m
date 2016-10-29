Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 09:05:40 +0200
Message-ID: <2107339.Rp9OU1LqBM@sven-edge>
In-Reply-To: <20161029023240.GD7448@otheros>
References: <1468782245-12985-1-git-send-email-sven@narfation.org>
 <20161029023240.GD7448@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8850970.DuG8TguNOQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: use consume_skb for
	non-dropped packets
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

--nextPart8850970.DuG8TguNOQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 29. Oktober 2016 04:32:40 CEST Linus L=FCssing wrote:
> On Sun, Jul 17, 2016 at 09:04:00PM +0200, Sven Eckelmann wrote:
> > kfree_skb assumes that an skb is dropped after an failure and notes tha=
t.
> > consume_skb should be used in non-failure situations. Such information =
is
> > important for dropmonitor netlink which tells how many packets were=20
dropped
> > and where this drop happened.
>=20
> Just a few, curious questions regarding why a kfree_skb()  was
> chosen instead of a consume_skb() in a few places.
>=20
> Especially so that I hopefully know which one best to use when
> rebasing the "batman-adv: fix race conditions on interface
> removal" patch :-).
>=20
> >=20
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> >  net/batman-adv/bat_iv_ogm.c     | 13 ++++++++-----
> >  net/batman-adv/fragmentation.c  | 20 ++++++++++++++------
> >  net/batman-adv/network-coding.c | 24 +++++++++++++++---------
> >  net/batman-adv/send.c           | 27 +++++++++++++++++++--------
> >  net/batman-adv/send.h           |  3 ++-
> >  net/batman-adv/soft-interface.c |  2 +-
> >  6 files changed, 59 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index a40cdf2..baf3d72 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -1786,8 +1787,10 @@ static void=20
batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
> >  	hlist_del(&forw_packet->list);
> >  	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> > =20
> > -	if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_DEACTIVATIN=
G)
> > +	if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_DEACTIVATIN=
G) {
> > +		dropped =3D true;
> >  		goto out;
> > +	}
>=20
> Is this reallly a failure case?

Hm, I would say it is not an extreme form of failure. But it is not a succe=
ss
either. So I've decided to use kfree_skb. The documentation is not really
clear about it (or I missed the correct documentation). So this is my
interpretation of it (which might be wrong).

>=20
> > diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/
fragmentation.c
> > index 0934730..461b77d 100644
> > --- a/net/batman-adv/fragmentation.c
> > +++ b/net/batman-adv/fragmentation.c
> > @@ -42,17 +42,23 @@
> > @@ -73,7 +79,7 @@ void batadv_frag_purge_orig(struct batadv_orig_node=20
*orig_node,
> >  		spin_lock_bh(&chain->lock);
> > =20
> >  		if (!check_cb || check_cb(chain)) {
> > -			batadv_frag_clear_chain(&chain->head);
> > +			batadv_frag_clear_chain(&chain->head, true);
> >  			chain->size =3D 0;
> >  		}
>=20
> Hm, have you chosen kfree_skb() over consume_skb() because it
> cannot easily be determined whether this call was from a failure
> case or not?

My interpretation was that batadv_frag_purge_orig means that the fragments
weren't successfully assembled. So it is some kind of soft failure.

>=20
> > diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-
coding.c
> > index 293ef4f..e924256 100644
> > --- a/net/batman-adv/network-coding.c
> > +++ b/net/batman-adv/network-coding.c
> > @@ -611,7 +617,7 @@ static bool batadv_nc_sniffed_purge(struct batadv_p=
riv=20
*bat_priv,
> > =20
> >  	/* purge nc packet */
> >  	list_del(&nc_packet->list);
> > -	batadv_nc_packet_free(nc_packet);
> > +	batadv_nc_packet_free(nc_packet, true);
> > =20
> >  	res =3D true;
>=20
> I could imagine, that with promiscious sniffing for coded packets,
> outdated, coded packets happen frequently and is not necessarilly
> a failure per se but to be expected.
>=20
> On the other hand, missing a coding opportunity could have
> happened due to some failure elsewhere (a broken wifi driver, a
> noisy environment, ...).
>=20
> In such an ambiguous case, should kfree_skb() be prefered over
> consume_skb()?
>=20
>=20
> > diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
> > index 8d4e1f5..4f44ee2 100644
> > --- a/net/batman-adv/send.c
> > +++ b/net/batman-adv/send.c
> > @@ -610,6 +616,7 @@ static void=20
batadv_send_outstanding_bcast_packet(struct work_struct *work)
> >  	struct sk_buff *skb1;
> >  	struct net_device *soft_iface;
> >  	struct batadv_priv *bat_priv;
> > +	bool dropped =3D false;
> > =20
> >  	delayed_work =3D to_delayed_work(work);
> >  	forw_packet =3D container_of(delayed_work, struct batadv_forw_packet,
> > @@ -621,11 +628,15 @@ static void=20
batadv_send_outstanding_bcast_packet(struct work_struct *work)
> >  	hlist_del(&forw_packet->list);
> >  	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
> >=20
>=20
> > -	if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_DEACTIVATIN=
G)
> > +	if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_DEACTIVATIN=
G) {
> > +		dropped =3D true;
> >  		goto out;
> > +	}
>=20
> Same as above, why is this considered a failure case?

Because it wasn't successful at fulfilling its task.

> > -	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
> > +	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet)) {
> > +		dropped =3D true;
> >  		goto out;
> > +	}
>=20
> Why is this a failure? Isn't DAT supposed to drop things to avoid
> a failure case (that is duplicate broadcast packets on the client
> side)?

Hm, good question. I think my idea behind it was that the original packet
wasn't submitted.

>=20
> > @@ -699,7 +710,7 @@ batadv_purge_outstanding_packets(struct batadv_priv=
=20
*bat_priv,
> > =20
> >  		if (pending) {
> >  			hlist_del(&forw_packet->list);
> > -			batadv_forw_packet_free(forw_packet);
> > +			batadv_forw_packet_free(forw_packet, true);
> >  		}
> >  	}
> >  	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
> > @@ -726,7 +737,7 @@ batadv_purge_outstanding_packets(struct batadv_priv=
=20
*bat_priv,
> > =20
> >  		if (pending) {
> >  			hlist_del(&forw_packet->list);
> > -			batadv_forw_packet_free(forw_packet);
> > +			batadv_forw_packet_free(forw_packet, true);
> >  		}
> >  	}
>=20
> These two above, again, why signaling a failure if it is a legitimate
> shutdown process?

Because the packet was not successfully forwarded.

Kind regards,
	Sven

--nextPart8850970.DuG8TguNOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYFEpEAAoJEF2HCgfBJntGCeUP/1WvhIpAGivO5L9HNfoGm9VO
p+3My+Ev5BBuyTUTciX48LpUEulIpCRIYyiEhFjr7rwX8Nkf1RQrIRqvaFxgNnq4
e4wS1xeax8YKBTntywbQ867FLnjbIbKLkQqZDa9T2iCzLIAF0IrgNsVp9rOM7AG/
TXgXvO36L03VXMHiBJJxrodfctLu5tBJyIK9jjt3gb9N8lUTqCIZ9SYA0hbDQlVN
pCqcOnm6lrrTBsiWfht2zNOYJQokj8YK4GMjLamQu7rak6buRNSae66zWVxSBHCc
sxHbJpE4Zr7mTJqgu4rrK/xRfAxDVJNbnDg+/3+lK/6LX1qAeYU2Vzo5diEbVOId
rxZnGfglYfGmgbgZQoCjUt3NU014U41AkBV6IiaMEG2iMcpKwBBDKaWEsUU7DBQk
7U2K0ksAJYorUOVcrSOFD9+8IhbRxMl00XtD3cbaez9liA3lC5pv7jajrvJs/BWo
RkBotIOD03WPcgAI+qMUDDy7MqX4xTSqNewpsGh4F0rQIcbDjsmqSN/VZW5/iO/z
KbA15jPVk+EUuwZgT6lhJGEpsF/dxD+tupQmwhhPMqdRCw/QgwkMqJ5DGnrq7pfR
Ns7n5dOqIPnvPy0haJXUGmy0/vXLpYNeScYcHVsVLjfvpJ1IkdsX++COx87lBCy0
HbRw+qkIYpaSeK1TOAh0
=0KAC
-----END PGP SIGNATURE-----

--nextPart8850970.DuG8TguNOQ--

