Return-Path: <antonio@meshcoding.com>
Date: Fri, 13 Sep 2013 15:23:54 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130913132354.GA3231@neomailbox.net>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-3-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1378312060-30922-3-git-send-email-siwu@hrz.tu-chemnitz.de>
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 06:27:36PM +0200, Simon Wunderlich wrote:
> @@ -897,22 +904,39 @@ static void batadv_iv_ogm_schedule(struct batadv_ha=
rd_iface *hard_iface)
>  		batadv_hardif_free_ref(primary_if);
>  }
> =20
> +/**
> + * batadv_iv_ogm_orig_update - use OGM to update corresponding data in an
> + *  originator
> + * @bat_priv: the bat priv with all the soft interface information
> + * @orig_node: the orig node who originally emitted the ogm packet
> + * @orig_node_ifinfo: ifinfo for the according outgoing interface

where is this argument in the function declaration?

> + * @ethhdr: Ethernet header of the OGM
> + * @@batadv_ogm_packet: the ogm packet

too many '@' :)

> + * @if_incoming: interface where the packet was received
> + * @if_outgoing: interface for which the retransmission should be consid=
ered
> + * @tt_buff: pointer to the tt buffer
> + * @dup_status: the duplicate status of this ogm packet.
> + */
>  static void
>  batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
>  			  struct batadv_orig_node *orig_node,
>  			  const struct ethhdr *ethhdr,
>  			  const struct batadv_ogm_packet *batadv_ogm_packet,
>  			  struct batadv_hard_iface *if_incoming,
> +			  struct batadv_hard_iface *if_outgoing,
>  			  const unsigned char *tt_buff,
>  			  enum batadv_dup_status dup_status)
>  {
>  	struct batadv_neigh_node *neigh_node =3D NULL, *tmp_neigh_node =3D NULL;
>  	struct batadv_neigh_node *router =3D NULL;
>  	struct batadv_orig_node *orig_node_tmp;
> +	struct batadv_neigh_node_ifinfo *neigh_ifinfo =3D NULL,
> +					*tmp_neigh_ifinfo,
> +					*router_ifinfo;

we have never used this kind of style for declaration. I'd prefer you to
re-write the variable type on each line, please.

>  	int if_num;
>  	uint8_t sum_orig, sum_neigh;
>  	uint8_t *neigh_addr;
> -	uint8_t tq_avg;
> +	uint8_t tq_avg, *tq_recv, *tq_index;
> =20
>  	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
>  		   "update_originator(): Searching and updating originator entry of re=
ceived packet\n");

[...]

> @@ -1134,17 +1193,20 @@ out:
>   * @ethhdr: ethernet header of the packet
>   * @batadv_ogm_packet: OGM packet to be considered
>   * @if_incoming: interface on which the OGM packet was received
> + * @if_outgoing: interface for which the retransmission should be consid=
ered
>   *
>   * Returns duplicate status as enum batadv_dup_status
>   */
>  static enum batadv_dup_status
>  batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
>  			    const struct batadv_ogm_packet *batadv_ogm_packet,
> -			    const struct batadv_hard_iface *if_incoming)
> +			    const struct batadv_hard_iface *if_incoming,
> +			    struct batadv_hard_iface *if_outgoing)

why isn't this const as well? It is not going to be changed or what, so kee=
ping
the const qualifier is good imho.

>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
>  	struct batadv_orig_node *orig_node;
> -	struct batadv_neigh_node *tmp_neigh_node;
> +	struct batadv_neigh_node *neigh_node;
> +	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
>  	int is_dup;
>  	int32_t seq_diff;
>  	int need_update =3D 0;
> @@ -1171,15 +1233,20 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *=
ethhdr,
>  	}
> =20
>  	rcu_read_lock();
> -	hlist_for_each_entry_rcu(tmp_neigh_node,
> +	hlist_for_each_entry_rcu(neigh_node,
>  				 &orig_node->neigh_list, list) {

maybe this line can be rearranged now that the first parameter is shorter t=
han
before?

> -		neigh_addr =3D tmp_neigh_node->addr;
> -		is_dup =3D batadv_test_bit(tmp_neigh_node->bat_iv.real_bits,
> +		neigh_ifinfo =3D batadv_neigh_node_get_ifinfo(neigh_node,
> +							    if_outgoing);
> +		if (WARN_ON(!neigh_ifinfo))
> +			continue;
> +
> +		neigh_addr =3D neigh_node->addr;
> +		is_dup =3D batadv_test_bit(neigh_ifinfo->bat_iv.real_bits,
>  					 orig_node->last_real_seqno,
>  					 seqno);
> =20
>  		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
> -		    tmp_neigh_node->if_incoming =3D=3D if_incoming) {
> +		    neigh_node->if_incoming =3D=3D if_incoming) {
>  			set_mark =3D 1;
>  			if (is_dup)
>  				ret =3D BATADV_NEIGH_DUP;

[...]

> @@ -1597,34 +1677,50 @@ next:
>   * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
>   * @neigh1: the first neighbor object of the comparison
>   * @neigh2: the second neighbor object of the comparison
> + * @if_outgoing: outgoing interface for the comparison
>   *
>   * Returns a value less, equal to or greater than 0 if the metric via ne=
igh1 is
>   * lower, the same as or higher than the metric via neigh2
>   */
>  static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
> -				   struct batadv_neigh_node *neigh2)
> +				   struct batadv_neigh_node *neigh2,
> +				   struct batadv_hard_iface *if_outgoing)

To make this API really generic, wouldn't it better to specify an if_outgoi=
ng1
and an if_outgoing2 (one per neigh)?
The use cases we have now would invoke this
function passing the same iface as both arguments, but if we want to make t=
his
API generic enough and avoid changing it in the future I'd suggest this cha=
nge.

Theoretically we could use this function by passing the same neigh and two
different interfaces...no? In this way we decide which is the best outgoing
interface (what I described does not sound like the best approach...I think=
 I
will understand how you do this in the next patches...)

[...]

>  /**
> - * batadv_iv_ogm_neigh_is_eob - check if neigh1 is equally good or bette=
r than
> - *  neigh2 from the metric prospective
> - * @neigh1: the first neighbor object of the comparison
> - * @neigh2: the second neighbor object of the comparison
> + * batadv_iv_ogm_neigh_is_eob - check if neigh1_ifinfo is equally good o=
r\
> + *  better than neigh2_ifinfo from the metric prospective
> + * @neigh1_ifinfo: the first neighbor ifinfo object of the comparison
> + * @neigh2_ifinfo: the second neighbor ifinfo object of the comparison
>   *
> - * Returns true if the metric via neigh1 is equally good or better than =
the
> - * metric via neigh2, false otherwise.
> + * Returns true if the metric via neigh1_ifinfo is equally good or bette=
r than
> + * the metric via neigh2_ifinfo, false otherwise.
>   */
> -static bool batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh1,
> -				       struct batadv_neigh_node *neigh2)
> +static bool
> +batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node_ifinfo *neigh1_ifinf=
o,
> +			   struct batadv_neigh_node_ifinfo *neigh2_ifinfo)

We could do the same as the previous function (..neigh1, iface1, neigh2, if=
ace2).
In this way we would not need to get the ifinfo objects outside but we can =
leave
the duty to this function (and reduce code).

[...]

> @@ -287,8 +303,11 @@ void batadv_gw_check_election(struct batadv_priv *ba=
t_priv,
>  {
>  	struct batadv_orig_node *curr_gw_orig;
>  	struct batadv_neigh_node *router_gw =3D NULL, *router_orig =3D NULL;
> +	struct batadv_neigh_node_ifinfo *router_gw_tq =3D NULL,
> +					*router_orig_tq =3D NULL;

as before.

[...]

> @@ -173,6 +191,55 @@ batadv_orig_node_get_router(struct batadv_orig_node =
*orig_node)
>  }
> =20
>  /**
> + * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
> + * @neigh_node: the neigh node to be queried
> + * @if_outgoing: the interface for which the ifinfo should be acquired
> + *
> + * Note: this function must be called under rcu lock
> + *
> + * Returns the requested neigh_node_ifinfo or NULL if not found
> + */
> +struct batadv_neigh_node_ifinfo *
> +batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
> +			     struct batadv_hard_iface *if_outgoing)
> +{
> +	struct batadv_neigh_node_ifinfo *neigh_ifinfo =3D NULL,
> +					*tmp_neigh_ifinfo;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(tmp_neigh_ifinfo, &neigh->ifinfo_list,
> +				 list) {
> +		if (tmp_neigh_ifinfo->if_outgoing !=3D if_outgoing)
> +			continue;
> +
> +		neigh_ifinfo =3D tmp_neigh_ifinfo;
> +	}
> +	if (neigh_ifinfo)
> +		goto out;
> +
> +	neigh_ifinfo =3D kzalloc(sizeof(*neigh_ifinfo), GFP_ATOMIC);
> +	if (!neigh_ifinfo)
> +		goto out;
> +
> +	if (if_outgoing && !atomic_inc_not_zero(&if_outgoing->refcount)) {
> +		kfree(neigh_ifinfo);
> +		neigh_ifinfo =3D NULL;
> +		goto out;
> +	}
> +
> +	INIT_HLIST_NODE(&neigh_ifinfo->list);
> +	neigh_ifinfo->if_outgoing =3D if_outgoing;
> +
> +	spin_lock_bh(&neigh->bat_iv.lq_update_lock);
> +	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
> +	spin_unlock_bh(&neigh->bat_iv.lq_update_lock);

These batman iv attributes should be initialised in a batman-iv-private fun=
ction,
otherwise we are back with to code (something that has been partly solved by
my previous patchset)...

[..]

> +	bool (*bat_neigh_ifinfo_is_equiv_or_better)
> +		(struct batadv_neigh_node_ifinfo *neigh1_ifinfo,
> +		 struct batadv_neigh_node_ifinfo *neigh2_ifinfo);

really ugly! but I don't know how we should re-arrange this... :(


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSMxHqAAoJEADl0hg6qKeOEyoP/1sjngyt+VeR2dkd+qa3lTRe
S/g7ZekamqahAO7GKJoMp7UUavrdVD0mUkRWwr64UEtr4e788SVnAF+/hY/5kPWJ
PC0nH9spwlW+iPfckn2OxFRS1B0SASFJuyYIxBISzrMpCJEMJ7M0oHBcCZEraiuk
w8LKPwrvT7c3Q+tq/BxzO+18NdsCoIqams1QgkcWEl8HSGsRUF5B7lO5fqK9/0aT
/2LPLmwAXjVEYeyJY58bIhnKF23rWx3jIFXhNHOBnLx1GJsdzPtwVyoyEwQBqGCH
wPRP1jj/o/z/XE+y1Rtnuv8R6jENxjy2M+cF7FcsN4IsutjGNLQHWNpJNiJj3NXu
G/HLaMvhHyyqJ1Z9H+C2h48sriR+Adv7YdIxHCZg75gUbGlDGH8Ny0y16SvIrHMo
KNiBjQRx3M7RpsQ35rN/bIuvNqqdHnMMvEfWLfz3Z0Bbmqts6nohcv0jXbVLJutK
7D8TQFy2IxDA+lJewAt2keQHMzY3sVDoOdtsQZLqAQcZeXhTnAPAi2oHND7YOOTa
mo9bu3iq0XQQwgxDm6V5G8xB6oiJYlksl8UWjuq7FYJAPSwcWg4CpEoWPMwpG8oU
jD39R1rOx8czvVEVnr4lq6UUIotPPa1LqG7peZ5CCakB9adSwPijPfhNMAxaQpXV
kibHYWoqqBxraktoOaM0
=rrix
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
