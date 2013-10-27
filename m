Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Oct 2013 18:27:30 +0800
Message-ID: <1625153.CDEY5RvPtE@diderot>
In-Reply-To: <1381323938-26931-7-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1381323938-26931-7-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9881610.PCFk2o3Kks";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: add bonding again
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


--nextPart9881610.PCFk2o3Kks
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 09 October 2013 15:05:37 Simon Wunderlich wrote:
> --- a/routing.c
> +++ b/routing.c
> @@ -407,16 +407,104 @@ static int batadv_check_unicast_packet(struct
> batadv_priv *bat_priv, struct batadv_neigh_node *
>  batadv_find_router(struct batadv_priv *bat_priv,
>  		   struct batadv_orig_node *orig_node,
> -		   const struct batadv_hard_iface *recv_if)
> +		   struct batadv_hard_iface *recv_if)
>  {
> -	struct batadv_neigh_node *router;
> +	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
> +	struct batadv_neigh_node *first_candidate_router = NULL;
> +	struct batadv_neigh_node *next_candidate_router;
> +	struct batadv_neigh_node *router, *cand_router;
> +	struct batadv_orig_node_ifinfo *cand, *first_candidate = NULL;
> +	struct batadv_orig_node_ifinfo *next_candidate = NULL;
> +	bool last_candidate_found = false;
> 
>  	if (!orig_node)
>  		return NULL;
> 
>  	router = batadv_orig_node_get_router(orig_node, recv_if);
> 
> -	/* TODO: fill this later with new bonding mechanism */
> +	/* only consider bonding for recv_if == NULL (first hop) and if
> +	 * activated.
> +	 */
> +	if (recv_if || !atomic_read(&bat_priv->bonding) || !router)
> +		return router;
> +
> +	/* bonding: loop through the list of possible routers found
> +	 * for the various outgoing interfaces and find a candidate after
> +	 * the last chosen bonding candidate (next_candidate). If no such
> +	 * router is found, use the first candidate found (the last chosen
> +	 * bonding candidate might have been the last one in the list).
> +	 * If this can't be found either, return the previously choosen
> +	 * router - obviously there are no other candidates.
> +	 */
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
> +		cand_router = rcu_dereference(cand->router);
> +		if (!cand_router)
> +			continue;
> +
> +		if (!atomic_inc_not_zero(&cand_router->refcount))
> +			continue;
> +
> +		/* alternative candidate should be good enough to be
> +		 * considered
> +		 */
> +		if (!bao->bat_neigh_is_equiv_or_better(cand_router,
> +						       cand->if_outgoing,
> +						       router, recv_if))
> +			goto next;
> +
> +		/* don't use the same router twice */
> +		if (orig_node->last_bonding_candidate &&
> +		    (orig_node->last_bonding_candidate->router ==
> +		     cand_router))
> +				goto next;

Again, this if-statement won't pass.


> +		/* check if already passed the next candidate ... this function
> +		 * should the next candidate AFTER the last used bonding
> +		 * candidate.
> +		 */
> +		if (!orig_node->last_bonding_candidate ||
> +		    last_candidate_found) {
> +			next_candidate = cand;
> +			next_candidate_router = cand_router;
> +			break;
> +		}

The comment above would benefit from additional love. :)


> +	if (next_candidate) {
> +		/* found a possible candidate after the last chosen bonding
> +		 * candidate, return it.
> +		 */
> +		batadv_neigh_node_free_ref(router);
> +		if (first_candidate)
> +			batadv_neigh_node_free_ref(first_candidate_router);
> +		router = next_candidate_router;
> +		orig_node->last_bonding_candidate = next_candidate;
> +	} else if (first_candidate) {
> +		/* found no possible candidate after the last candidate, return
> +		 * the first candidate if available, or the already selected
> +		 * router otherwise.
> +		 */
> +		batadv_neigh_node_free_ref(router);
> +		router = first_candidate_router;
> +		orig_node->last_bonding_candidate = first_candidate;
> +	} else {
> +		orig_node->last_bonding_candidate = NULL;
> +	}

It is not safe to hold a pointer to first_candidate or next_candidate without 
having a refcounter protecting it.

Cheers,
Marek

--nextPart9881610.PCFk2o3Kks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSbOqWAAoJEFNVTo/uthzAv5MIAJHhUZ9YI50ovVeXrG8vUKhR
5opqWJU++K00n0+jolXlpWXQOg9AdahEPK8bbGSfLkXA+bOFmjssG85o+r36CB37
BxoTZGs4NBygVmqteWwuWZ6rWw10QhcaFSeSO+5kFXRIXf1sNp8nqJRgmjQVNKxR
Z+D/Qra/D8f+KpM48/CRXzMtrqR6opOUlmYRoqbkUuRML+giMCmF6aAGbN75hNNX
51izAdhDLVUcerDnaBtQO492JwcSelejBYZgfpBmOgEFT1RDbiC2Lynv4Egp+YNH
fagy3+Q3Zxrf0sJ11w6seansHxul9MNPhOBrQ/Uluw8NosVEVim2nrUdlrLxxNI=
=6dis
-----END PGP SIGNATURE-----

--nextPart9881610.PCFk2o3Kks--

