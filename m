Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 3 Oct 2013 22:39:17 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131003203917.GA9172@pandem0nium>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-3-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20130913132354.GA3231@neomailbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20130913132354.GA3231@neomailbox.net>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 2/6] batman-adv: split tq information in
 neigh_node struct
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


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

thanks a lot for the review. I'll make changes according to your suggestion=
s,
and will comment on stuff which I don't change or which require more discus=
sion:

On Fri, Sep 13, 2013 at 03:23:54PM +0200, Antonio Quartulli wrote:
> On Wed, Sep 04, 2013 at 06:27:36PM +0200, Simon Wunderlich wrote:
> > @@ -1134,17 +1193,20 @@ out:
> >   * @ethhdr: ethernet header of the packet
> >   * @batadv_ogm_packet: OGM packet to be considered
> >   * @if_incoming: interface on which the OGM packet was received
> > + * @if_outgoing: interface for which the retransmission should be cons=
idered
> >   *
> >   * Returns duplicate status as enum batadv_dup_status
> >   */
> >  static enum batadv_dup_status
> >  batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
> >  			    const struct batadv_ogm_packet *batadv_ogm_packet,
> > -			    const struct batadv_hard_iface *if_incoming)
> > +			    const struct batadv_hard_iface *if_incoming,
> > +			    struct batadv_hard_iface *if_outgoing)
>=20
> why isn't this const as well? It is not going to be changed or what, so k=
eeping
> the const qualifier is good imho.
>=20

This can't be const - batadv_neigh_node_get_ifinfo() is called within this
function, and this might change the refcounter in the if_outgoing interface.

> > @@ -1597,34 +1677,50 @@ next:
> >   * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
> >   * @neigh1: the first neighbor object of the comparison
> >   * @neigh2: the second neighbor object of the comparison
> > + * @if_outgoing: outgoing interface for the comparison
> >   *
> >   * Returns a value less, equal to or greater than 0 if the metric via =
neigh1 is
> >   * lower, the same as or higher than the metric via neigh2
> >   */
> >  static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
> > -				   struct batadv_neigh_node *neigh2)
> > +				   struct batadv_neigh_node *neigh2,
> > +				   struct batadv_hard_iface *if_outgoing)
>=20
> To make this API really generic, wouldn't it better to specify an if_outg=
oing1
> and an if_outgoing2 (one per neigh)?
> The use cases we have now would invoke this
> function passing the same iface as both arguments, but if we want to make=
 this
> API generic enough and avoid changing it in the future I'd suggest this c=
hange.
>=20
> Theoretically we could use this function by passing the same neigh and two
> different interfaces...no? In this way we decide which is the best outgoi=
ng
> interface (what I described does not sound like the best approach...I thi=
nk I
> will understand how you do this in the next patches...)

I agree - so far we only can use it for the bonding case later, but maybe t=
here
are other use cases. In most cases we will use the same outgoint interface,=
 but
it doesn't really hurt having two parameters.

>=20
> [...]
>=20
> >  /**
> > - * batadv_iv_ogm_neigh_is_eob - check if neigh1 is equally good or bet=
ter than
> > - *  neigh2 from the metric prospective
> > - * @neigh1: the first neighbor object of the comparison
> > - * @neigh2: the second neighbor object of the comparison
> > + * batadv_iv_ogm_neigh_is_eob - check if neigh1_ifinfo is equally good=
 or\
> > + *  better than neigh2_ifinfo from the metric prospective
> > + * @neigh1_ifinfo: the first neighbor ifinfo object of the comparison
> > + * @neigh2_ifinfo: the second neighbor ifinfo object of the comparison
> >   *
> > - * Returns true if the metric via neigh1 is equally good or better tha=
n the
> > - * metric via neigh2, false otherwise.
> > + * Returns true if the metric via neigh1_ifinfo is equally good or bet=
ter than
> > + * the metric via neigh2_ifinfo, false otherwise.
> >   */
> > -static bool batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh=
1,
> > -				       struct batadv_neigh_node *neigh2)
> > +static bool
> > +batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node_ifinfo *neigh1_ifi=
nfo,
> > +			   struct batadv_neigh_node_ifinfo *neigh2_ifinfo)
>=20
> We could do the same as the previous function (..neigh1, iface1, neigh2, =
iface2).
> In this way we would not need to get the ifinfo objects outside but we ca=
n leave
> the duty to this function (and reduce code).

Yup.

> > @@ -173,6 +191,55 @@ batadv_orig_node_get_router(struct batadv_orig_nod=
e *orig_node)
> >  }
> > =20
> >  /**
> > + * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
> > + * @neigh_node: the neigh node to be queried
> > + * @if_outgoing: the interface for which the ifinfo should be acquired
> > + *
> > + * Note: this function must be called under rcu lock
> > + *
> > + * Returns the requested neigh_node_ifinfo or NULL if not found
> > + */
> > +struct batadv_neigh_node_ifinfo *
> > +batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
> > +			     struct batadv_hard_iface *if_outgoing)
> > +{
> > +	struct batadv_neigh_node_ifinfo *neigh_ifinfo =3D NULL,
> > +					*tmp_neigh_ifinfo;
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(tmp_neigh_ifinfo, &neigh->ifinfo_list,
> > +				 list) {
> > +		if (tmp_neigh_ifinfo->if_outgoing !=3D if_outgoing)
> > +			continue;
> > +
> > +		neigh_ifinfo =3D tmp_neigh_ifinfo;
> > +	}
> > +	if (neigh_ifinfo)
> > +		goto out;
> > +
> > +	neigh_ifinfo =3D kzalloc(sizeof(*neigh_ifinfo), GFP_ATOMIC);
> > +	if (!neigh_ifinfo)
> > +		goto out;
> > +
> > +	if (if_outgoing && !atomic_inc_not_zero(&if_outgoing->refcount)) {
> > +		kfree(neigh_ifinfo);
> > +		neigh_ifinfo =3D NULL;
> > +		goto out;
> > +	}
> > +
> > +	INIT_HLIST_NODE(&neigh_ifinfo->list);
> > +	neigh_ifinfo->if_outgoing =3D if_outgoing;
> > +
> > +	spin_lock_bh(&neigh->bat_iv.lq_update_lock);
> > +	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
> > +	spin_unlock_bh(&neigh->bat_iv.lq_update_lock);
>=20
> These batman iv attributes should be initialised in a batman-iv-private f=
unction,
> otherwise we are back with to code (something that has been partly solved=
 by
> my previous patchset)...

Yes, you are right ... I've renamed this to neigh->ifinfo_lock because this=
 lock
is now used for ifinfo_list and its members.
>=20
> [..]
>=20
> > +	bool (*bat_neigh_ifinfo_is_equiv_or_better)
> > +		(struct batadv_neigh_node_ifinfo *neigh1_ifinfo,
> > +		 struct batadv_neigh_node_ifinfo *neigh2_ifinfo);
>=20
> really ugly! but I don't know how we should re-arrange this... :(

Yep, but I don't know how to fix that. This function is still way too long,=
 maybe
rename it to eob instead of equiv_or_better?
>=20
>=20
> Cheers,
>=20
> --=20
> Antonio Quartulli
>=20
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara



--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJN1fUACgkQrzg/fFk7axZ2LQCgwvzbebPkGRSpqVTM4PsyjmQl
CV0AoKdhKmv7TUYAJSVVUz6FfVa2dxFh
=GJau
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
