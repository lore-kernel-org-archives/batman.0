Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 4 Oct 2013 00:53:17 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131003225317.GC9172@pandem0nium>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-7-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20131001092419.GE1448@neomailbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20131001092419.GE1448@neomailbox.net>
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


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 11:24:19AM +0200, Antonio Quartulli wrote:
> > +	/* bonding: loop through the list of possible routers found
> > +	 * for the various outgoing interfaces and find a candidate after
> > +	 * the last chosen bonding candidate (next_candidate). If no such
> > +	 * router is found, use the first candidate found (the last chosen
> > +	 * bonding candidate might have been the last one in the list).
> > +	 * If this can't be found either, return the previously choosen
> > +	 * router - obviously there are no other candidates.
> > +	 */
> > +	rcu_read_lock();
> > +	router_ifinfo =3D batadv_neigh_node_get_ifinfo(router, recv_if);
> > +	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
> > +		cand_router =3D rcu_dereference(cand->router);
> > +		if (!cand_router)
> > +			continue;
> > +
> > +		if (!atomic_inc_not_zero(&cand_router->refcount))
> > +			continue;
> > +
> > +		cand_ifinfo =3D batadv_neigh_node_get_ifinfo(cand_router,
> > +							   cand->if_outgoing);
> > +		if (!cand_ifinfo)
> > +			goto next;
> > +
> > +		/* alternative candidate should be good enough to be
> > +		 * considered
> > +		 */
> > +		if (!bao->bat_neigh_ifinfo_is_equiv_or_better(cand_ifinfo,
> > +							      router_ifinfo))
> > +			goto next;
> > +
> > +		/* don't use the same router twice */
> > +		if (orig_node->last_bonding_candidate &&
> > +		    (orig_node->last_bonding_candidate->router =3D=3D
> > +		     cand_router))
> > +				goto next;
> > +
> > +		/* mark the first possible candidate */
> > +		if (!first_candidate) {
> > +			atomic_inc(&cand_router->refcount);
> > +			first_candidate =3D cand;
> > +			first_candidate_router =3D cand_router;
> > +		}
> > +
>=20
> What if you change this:
>=20
> > +		/* check if already passed the next candidate ... this function
> > +		 * should get the next candidate AFTER the last used bonding
> > +		 * candidate.
> > +		 */
> > +		if (orig_node->last_bonding_candidate) {
> > +			if (orig_node->last_bonding_candidate =3D=3D cand) {
> > +				last_candidate_found =3D true;
> > +				goto next;
> > +			}
> > +
> > +			if (!last_candidate_found)
> > +				goto next;
> > +		}
> > +
> > +		next_candidate =3D cand;
> > +		next_candidate_router =3D cand_router;
> > +		break;
> > +next:
> > +		batadv_neigh_node_free_ref(cand_router);
>=20
> to this:
>=20
> if (!orig_node->last_bonding_candidate || last_candidate_found) {
> 	next_candidate =3D cand;
> 	next_candidate_router =3D cand_router;
> 	break;
> }
>=20
> if (orig_node->last_bonding_candidate =3D=3D cand)
> 	last_candidate_found =3D true;
>=20
> batadv_neigh_node_free_ref(cand_router);
>=20
>=20
> ? (I hope the two are equivalent..I took some time to fully get the flow =
of your
> if/else block)
>=20
> Removing the "goto next" makes me look at it in a more linear way (and we=
 also
> reduce the max indentation by one tab).
>=20

Yup, that should work too, good suggestion. We need to keep the next label =
though.
I'll change it according to your suggestion.

> > diff --git a/types.h b/types.h
> > index 7255500..fa58a14 100644
> > --- a/types.h
> > +++ b/types.h
> > @@ -173,6 +173,7 @@ struct batadv_orig_bat_iv {
> >   * @orig: originator ethernet address
> >   * @primary_addr: hosts primary interface address
> >   * @ifinfo_list: list for routers per outgoing interface
> > + * @last_bonding_candidate: pointer to last ifinfo of last used router
> >   * @batadv_dat_addr_t:  address of the orig node in the distributed ha=
sh
> >   * @last_seen: time when last packet from this node was received
> >   * @bcast_seqno_reset: time when the broadcast seqno window was reset
> > @@ -213,6 +214,7 @@ struct batadv_orig_node {
> >  	uint8_t orig[ETH_ALEN];
> >  	uint8_t primary_addr[ETH_ALEN];
> >  	struct hlist_head ifinfo_list;
> > +	struct batadv_orig_node_ifinfo *last_bonding_candidate;
>=20
> Do you think it is not needed to set this field to NULL when disabling bo=
nding
> mode? Can an old value trigger some strange behaviour when bonding is tur=
ned on
> again? Maybe not..just wondering..

Hmm, maybe, can't say now but will look into that.

Thanks for all your suggestions!
	Simon

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJN9V0ACgkQrzg/fFk7axYoeACghEXr1/O7bBJDk4MUXrHf2G9X
YXcAn0iIElWuponW3yrwp1fvpBH1I/6F
=XITY
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
