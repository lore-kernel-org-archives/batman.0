Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jun 2015 10:52:13 +0200
Message-ID: <4830012.jBltC4KZcc@bentobox>
In-Reply-To: <1392482874-9024-6-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-6-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1520967.CMUzMLn37S";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 5/6] batman-adv: Add IPv4
	link-local/IPv6-ll-all-nodes multicast support
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


--nextPart1520967.CMUzMLn37S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:53 Linus L=FCssing wrote:
> +static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat=
_priv,
> +=09=09=09=09=09     struct batadv_orig_node *orig,
> +=09=09=09=09=09     uint8_t mcast_flags)
> +{
> +=09/* switched from flag unset to set */
> +=09if (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
> +=09    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES)) {
> +=09=09atomic_inc(&bat_priv->mcast.num_want_all_unsnoopables);
> +
> +=09=09spin_lock_bh(&bat_priv->mcast.want_lists_lock);
> +=09=09hlist_add_head_rcu(&orig->mcast_want_all_unsnoopables_node,
> +=09=09=09=09   &bat_priv->mcast.want_all_unsnoopables_list);
> +=09=09spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> +=09/* switched from flag set to unset */
> +=09} else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) &&=

> +=09=09   orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) {
> +=09=09atomic_dec(&bat_priv->mcast.num_want_all_unsnoopables);
> +
> +=09=09spin_lock_bh(&bat_priv->mcast.want_lists_lock);
> +=09=09hlist_del_rcu(&orig->mcast_want_all_unsnoopables_node);
> +=09=09spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> +=09}

Looks unsafe. How do you make sure that it is still in the list and not=
=20
already already removed in the meantime? hlist_del_rcu does not re-init=
ialize=20
the pointers (only POISON them when CONFIG_DEBUG_LIST is activated). Th=
us=20
calling hlist_del_rcu again on an object not in the list either kills o=
ther=20
data structures or causes an Oops.

There are more *list_del* related problems of that type in your code. T=
his is=20
just one example I've picked.

See http://www.open-mesh.org/issues/217#note-5

Kind regards,
=09Sven
--nextPart1520967.CMUzMLn37S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVd/rAAAoJEF2HCgfBJntGRE4QANKKhn/EUoOJd9bqctkenFWw
J5HEAgVF9Wc2G6vdDSrQXxp5/K3bqEKzXemrN31snC8OLzmA+S4k96+WAOI5rMEm
KmXlvGgVE2K+3C5+85di/EpLsMnG/lXISERLgNHKOD958VXxBLBXAa2Jya+GGaYT
P+bVhlyfcqzM0X3t/x2MKJ8jCIpa6KmvkQD6bAY8fAZ2DKQyDnpjnuA9BSjfAgzK
m2CWw277MyAVMltWZC35uCnE3loWL0mEvMRuPh74NKxXCR2AzPkMBHKqywYUR/ld
rhAPwOASgZDYi4GTuBMYNHxSsYOeOoSfpCwTulyybLyBwX877ADOU0P/9pEq4Cxw
VJfvZj/tV/ESPYQ/RAhSHypFw0MbBanHvcF2p3tY4gRe3DcwC0KNDZTa9ns9OW2Y
B8xM6lkpdmVIfD99JR7p8q5F5Oc4Yzh80+mSqNlqa/GeZH0Qdw02ddspWhTIjUlA
aNE2fBfhDE8SORfZQ7oDQJWezMESkpBRtyQnrgT33nR60+0EICLFneaNAVuCH+1U
Bdz77jFxAG8byrF3ZB6QFOv0xsrAJ9pecnEM03NNqyKQShGi/ERlA+XxzuiK6ZCY
RrDr/YQG85+YhmOkYW4QrbZyWhqVxsRJWQIc5WUYerEeyi3V9AsGO+x+h8jHzs7y
OJg0nnAfIi/Cfp8Id4Wu
=jxKM
-----END PGP SIGNATURE-----

--nextPart1520967.CMUzMLn37S--

