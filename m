Return-Path: <antonio@meshcoding.com>
Date: Tue, 1 Oct 2013 11:24:19 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131001092419.GE1448@neomailbox.net>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-7-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <1378312060-30922-7-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 6/6] batman-adv: add bonding again
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 06:27:40PM +0200, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> With the new interface alternating, the first hop may send packets
> in a round robin fashion to it's neighbors because it has multiple
> valid routes built by the multi interface optimization. This patch
> enables the feature if bonding is selected. Note that unlike the
> bonding implemented before, this version is much simpler and may
> even enable multi path routing to a certain degree.

y0! :)

>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  routing.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  routing.h |    2 +-
>  types.h   |    2 ++
>  3 files changed, 104 insertions(+), 4 deletions(-)
>=20
> diff --git a/routing.c b/routing.c
> index 304e44b..013958f 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -407,16 +407,114 @@ static int batadv_check_unicast_packet(struct bata=
dv_priv *bat_priv,

[..]

>  {
> -	struct batadv_neigh_node *router;
> +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
> +	struct batadv_neigh_node *router, *cand_router,
> +				 *first_candidate_router =3D NULL,
> +				 *next_candidate_router;

Can you avoid this strange declaration style? :)
One variable (with its type) per line.

> +	struct batadv_neigh_node_ifinfo *router_ifinfo, *cand_ifinfo;
> +	struct batadv_orig_node_ifinfo *cand, *first_candidate =3D NULL,
> +				       *next_candidate =3D NULL;

here too.

[...]

> +	/* bonding: loop through the list of possible routers found
> +	 * for the various outgoing interfaces and find a candidate after
> +	 * the last chosen bonding candidate (next_candidate). If no such
> +	 * router is found, use the first candidate found (the last chosen
> +	 * bonding candidate might have been the last one in the list).
> +	 * If this can't be found either, return the previously choosen
> +	 * router - obviously there are no other candidates.
> +	 */
> +	rcu_read_lock();
> +	router_ifinfo =3D batadv_neigh_node_get_ifinfo(router, recv_if);
> +	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
> +		cand_router =3D rcu_dereference(cand->router);
> +		if (!cand_router)
> +			continue;
> +
> +		if (!atomic_inc_not_zero(&cand_router->refcount))
> +			continue;
> +
> +		cand_ifinfo =3D batadv_neigh_node_get_ifinfo(cand_router,
> +							   cand->if_outgoing);
> +		if (!cand_ifinfo)
> +			goto next;
> +
> +		/* alternative candidate should be good enough to be
> +		 * considered
> +		 */
> +		if (!bao->bat_neigh_ifinfo_is_equiv_or_better(cand_ifinfo,
> +							      router_ifinfo))
> +			goto next;
> +
> +		/* don't use the same router twice */
> +		if (orig_node->last_bonding_candidate &&
> +		    (orig_node->last_bonding_candidate->router =3D=3D
> +		     cand_router))
> +				goto next;
> +
> +		/* mark the first possible candidate */
> +		if (!first_candidate) {
> +			atomic_inc(&cand_router->refcount);
> +			first_candidate =3D cand;
> +			first_candidate_router =3D cand_router;
> +		}
> +

What if you change this:

> +		/* check if already passed the next candidate ... this function
> +		 * should get the next candidate AFTER the last used bonding
> +		 * candidate.
> +		 */
> +		if (orig_node->last_bonding_candidate) {
> +			if (orig_node->last_bonding_candidate =3D=3D cand) {
> +				last_candidate_found =3D true;
> +				goto next;
> +			}
> +
> +			if (!last_candidate_found)
> +				goto next;
> +		}
> +
> +		next_candidate =3D cand;
> +		next_candidate_router =3D cand_router;
> +		break;
> +next:
> +		batadv_neigh_node_free_ref(cand_router);

to this:

if (!orig_node->last_bonding_candidate || last_candidate_found) {
	next_candidate =3D cand;
	next_candidate_router =3D cand_router;
	break;
}

if (orig_node->last_bonding_candidate =3D=3D cand)
	last_candidate_found =3D true;

batadv_neigh_node_free_ref(cand_router);


? (I hope the two are equivalent..I took some time to fully get the flow of=
 your
if/else block)

Removing the "goto next" makes me look at it in a more linear way (and we a=
lso
reduce the max indentation by one tab).

> +	}
> +
> +	if (next_candidate) {
> +		/* found a possible candidate after the last chosen bonding
> +		 * candidate, return it.
> +		 */
> +		batadv_neigh_node_free_ref(router);
> +		if (first_candidate)
> +			batadv_neigh_node_free_ref(first_candidate_router);
> +		router =3D next_candidate_router;
> +		orig_node->last_bonding_candidate =3D next_candidate;
> +	} else if (first_candidate) {
> +		/* found no possible candidate after the last candidate, return
> +		 * the first candidate if available, or the already selected
> +		 * router otherwise.
> +		 */
> +		batadv_neigh_node_free_ref(router);
> +		router =3D first_candidate_router;
> +		orig_node->last_bonding_candidate =3D first_candidate;
> +	} else {
> +		orig_node->last_bonding_candidate =3D NULL;
> +	}
> +

Also this if/else block could be simplified a little bit? But still it is
readable and understandable :)

> +	rcu_read_unlock();
> =20
>  	return router;
>  }

[..]

> diff --git a/types.h b/types.h
> index 7255500..fa58a14 100644
> --- a/types.h
> +++ b/types.h
> @@ -173,6 +173,7 @@ struct batadv_orig_bat_iv {
>   * @orig: originator ethernet address
>   * @primary_addr: hosts primary interface address
>   * @ifinfo_list: list for routers per outgoing interface
> + * @last_bonding_candidate: pointer to last ifinfo of last used router
>   * @batadv_dat_addr_t:  address of the orig node in the distributed hash
>   * @last_seen: time when last packet from this node was received
>   * @bcast_seqno_reset: time when the broadcast seqno window was reset
> @@ -213,6 +214,7 @@ struct batadv_orig_node {
>  	uint8_t orig[ETH_ALEN];
>  	uint8_t primary_addr[ETH_ALEN];
>  	struct hlist_head ifinfo_list;
> +	struct batadv_orig_node_ifinfo *last_bonding_candidate;

Do you think it is not needed to set this field to NULL when disabling bond=
ing
mode? Can an old value trigger some strange behaviour when bonding is turne=
d on
again? Maybe not..just wondering..

Cheers,
--=20
Antonio Quartulli

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSSpTDAAoJEADl0hg6qKeOR30P/3CwQq3hm8ep6kZN0mGYj5Ph
sN6rm++agPqb35aKtgHrMVuy9K4MhGXAIKqyASgTe3/T9VqcLEVXXe+Q705+bwuL
WsToX3lJKOy62emMUywryBcfu4DeHBAX1lViy1x9qqUqrL8IHeVaK+3Cm/OsDYDO
H0njZZyryV7xu+k9lgfWoe2jEutt/nJbuesTnpibUQKe0ouCJ5hgNyt9O1Exrrt6
Ah2xJk8bRk1PsCFkACAq6aTKpmlq6kIsqxlFspb8BJnOwCz1UfoVyBmbWqzm5lvF
5K7CQcxHdkPMjmlPDM4IuDc4Ywvf+ov1FZMCJxJugXo6piQ3wCVfA9MSY53P32Vm
YxKahYHHcbJpznKIprpfOq9c9vnl4WzaXFD/WW05Jyk+/1ljYHfKGGtfVtYPOweb
Wmm4iNIiCEZrCWatxw91zTRiQXIZdQoHvQcNbJlTnySw1vZrR3YjQLH2wVFwz0WM
yV/Mo0ykFm+v+hbqFzXbpLotAkDhv8BBDaDgIvRaCMH7O27Ah35Im6WZQuoatVeL
fhFvk2n2J2hy1OM3QwvjaVWRch9wtaiSHT1TqYryK/g0KbWMGhNt88iyo+GnZzeP
KqTZr6pDV0geibFFwOxmxC0Hw0ejK/9+ABJKbICXtY2WqkQPfSQZQNaDoqU7A5+e
51qY/xAqqcltOKlEJfDt
=WaKo
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
