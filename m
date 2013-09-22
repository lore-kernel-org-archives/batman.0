Return-Path: <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 22:47:59 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130922204759.GE3911@neomailbox.net>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-4-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <1378312060-30922-4-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 3/6] batman-adv: split out router from
 orig_node
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


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 06:27:37PM +0200, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> For the network wide multi interface optimization there are different
> routers for each outgoing interface (outgoing from the OGM perspective,
> incoming for payload traffic). To reflect this, change the router and
> associated data to a list of routers.
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---

[...]

> +static void
> +batadv_iv_ogm_process_per_outif(const struct ethhdr *ethhdr,
> +				struct batadv_orig_node *orig_node,
> +				struct batadv_ogm_packet *batadv_ogm_packet,
> +				const unsigned char *tt_buff,
> +				struct batadv_hard_iface *if_incoming,
> +				struct batadv_hard_iface *if_outgoing)
>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
> -	struct batadv_hard_iface *hard_iface;
> -	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
>  	struct batadv_neigh_node *router =3D NULL, *router_router =3D NULL;
>  	struct batadv_neigh_node *orig_neigh_router =3D NULL;
>  	struct batadv_neigh_node_ifinfo *router_ifinfo =3D NULL;
> -	int has_directlink_flag;
> -	int is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;
> -	int is_bidirect;
> -	bool is_single_hop_neigh =3D false;
> -	bool is_from_best_next_hop =3D false;
> -	int sameseq, similar_ttl;
> +	struct batadv_orig_node *orig_neigh_node, *orig_node_tmp;
> +	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
> +	int is_bidirect, sameseq, similar_ttl;
>  	enum batadv_dup_status dup_status;
> -	uint32_t if_incoming_seqno;
>  	uint8_t *prev_sender;
> +	struct batadv_ogm_packet ogm_packet_backup;
> +	bool is_from_best_next_hop =3D false;
> +	bool is_single_hop_neigh =3D false;

Since you have the opportunity, please sort these new declarations by line
length (like you have done 6 lines above).

[...]

> +
> +	sameseq =3D orig_node_ifinfo->last_real_seqno =3D=3D
> +		   ntohl(batadv_ogm_packet->seqno));
> +	similar_ttl =3D (orig_node_ifinfo->last_ttl - 3) <=3D
> +		      batadv_ogm_packet->header.ttl;

you know this is very ugly, right? :-)

you could try to remove sameseq and similar_ttl and use temporary variables=
 for
last_real_seqno, seqno, last_ttl and header.ttl.....

> +	if (is_bidirect && ((dup_status =3D=3D BATADV_NO_DUP) ||
> +			    (sameseq && similar_ttl)))

=2E..then you can try to make them fit this 'if' directly.

> +		batadv_iv_ogm_orig_update(bat_priv, orig_node,
> +					  orig_node_ifinfo, ethhdr,
> +					  batadv_ogm_packet, if_incoming,
> +					  if_outgoing, tt_buff, dup_status);
> +	rcu_read_unlock();
> +
[..]

> +static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
> +				  struct batadv_ogm_packet *batadv_ogm_packet,
> +				  const unsigned char *tt_buff,
> +				  struct batadv_hard_iface *if_incoming)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
> +	struct batadv_hard_iface *hard_iface;
> +	struct batadv_orig_node *orig_neigh_node, *orig_node;
> +	uint32_t if_incoming_seqno;
> +	int has_directlink_flag;
> +	int is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;

Please sort the declarations by line length.

[...]


> diff --git a/network-coding.c b/network-coding.c
> index 173a96e..6d1b659 100644
> --- a/network-coding.c
> +++ b/network-coding.c
> @@ -1010,12 +1010,17 @@ static bool batadv_nc_code_packets(struct batadv_=
priv *bat_priv,
>  	int coded_size =3D sizeof(*coded_packet);
>  	int header_add =3D coded_size - unicast_size;
> =20
> -	router_neigh =3D batadv_orig_node_get_router(neigh_node->orig_node);
> +	/* TODO: do we need to consider the outgoing interface for
> +	 * coded packets?
> +	 */
> +	router_neigh =3D batadv_orig_node_get_router(neigh_node->orig_node,
> +						   NULL);

Perhaps we can consider them like "locally-generated". I think we should ask
Martin to give us his feedback :-)

[...]

> =20
>  /**
> + * batadv_orig_node_get_ifinfo - gets the ifinfo from an orig_node
> + * @orig_node: the orig node to be queried
> + * @if_received: the interface for which the ifinfo should be acquired

Put a blank line here.

> + * Returns: the requested orig_node_ifinfo or NULL if not found

we never use the ':' after Returns (and a . is missing at the end of the
sentence). Please make sure that all the kernel doc you added respect those
guidelines.

[...]

> =20
> +static void batadv_orig_node_ifinfo_free_rcu(struct rcu_head *rcu)

kernel doc?

> +{
> +	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
> +
> +	orig_node_ifinfo =3D container_of(rcu, struct batadv_orig_node_ifinfo,
> +					rcu);
> +	if (orig_node_ifinfo->if_outgoing)
> +		batadv_hardif_free_ref(orig_node_ifinfo->if_outgoing);

Please, be sure this is not creating any race condition during the cleanup =
phase.
We had problems int the past with a RCU callback scheduling another callback
too.

The cleanup code has an rcu_barrier() to ensure everything is done and then
safely free the various structures. What you do here may violate this assum=
ption
and the scheduled callback may generate a General Protection Fault.

[...]

> @@ -291,6 +366,12 @@ static void batadv_orig_node_free_rcu(struct rcu_hea=
d *rcu)
>  		batadv_neigh_node_free_ref(neigh_node);
>  	}
> =20
> +	hlist_for_each_entry_safe(orig_node_ifinfo, node_tmp,
> +				  &orig_node->ifinfo_list, list) {
> +		hlist_del_rcu(&orig_node_ifinfo->list);
> +		call_rcu(&orig_node_ifinfo->rcu,
> +			 batadv_orig_node_ifinfo_free_rcu);

Same here. Please ensure everything is ok when scheduling a callback from
another callback.


[...]

>  /**
> + * batadv_purge_orig_ifinfo - purge ifinfo entries from originator
> + * @bat_priv: the bat priv with all the soft interface information
> + * @orig_node: orig node which is to be checked
> + * Returns: true if any ifinfo entry was purged, false otherwise
> + */
> +static bool
> +batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
> +			 struct batadv_orig_node *orig_node)
> +{
> +	struct hlist_node *node_tmp;
> +	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
> +	bool ifinfo_purged =3D false;
> +	struct batadv_hard_iface *if_outgoing;
> +

sort by line length please.

> +	rcu_read_lock();
> +	spin_lock_bh(&orig_node->neigh_list_lock);

why do you need both the rcu and the neigh_list_lock at the same time?
You acquire and release the two in the same moment (maybe I am overlooking
something?)

[...]

> +/**
>   * batadv_purge_orig_neighbors - purges neighbors from originator
>   * @bat_priv: the bat priv with all the soft interface information
>   * @orig_node: orig node which is to be checked
> @@ -516,6 +643,8 @@ static bool batadv_purge_orig_node(struct batadv_priv=
 *bat_priv,
>  				   struct batadv_orig_node *orig_node)
>  {
>  	struct batadv_neigh_node *best_neigh_node;
> +	struct batadv_hard_iface *hard_iface;
> +	bool changed =3D false;

this is useless and then.....

> =20
>  	if (batadv_has_timed_out(orig_node->last_seen,
>  				 2 * BATADV_PURGE_TIMEOUT)) {
> @@ -525,11 +654,32 @@ static bool batadv_purge_orig_node(struct batadv_pr=
iv *bat_priv,
>  			   jiffies_to_msecs(orig_node->last_seen));
>  		return true;
>  	}
> -	if (!batadv_purge_orig_neighbors(bat_priv, orig_node))
> +	changed =3D changed || batadv_purge_orig_ifinfo(bat_priv, orig_node);

=2E...just do:

changed =3D batadv_purge_orig_ifinfo(...);

[...]

> diff --git a/originator.h b/originator.h
> index 161c1e3..1dce5b4 100644
> --- a/originator.h
> +++ b/originator.h
> @@ -36,7 +36,16 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_i=
face,
>  		      struct batadv_orig_node *orig_node);
>  void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
>  struct batadv_neigh_node *
> -batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
> +batadv_orig_node_get_router(struct batadv_orig_node *orig_node,
> +			    const struct batadv_hard_iface *if_received);
> +void

why void on another line? It should fit in the next one.

> +batadv_orig_node_set_router(struct batadv_orig_node *orig_node,
> +			    struct batadv_hard_iface *if_received,
> +			    struct batadv_neigh_node *router);


Cheers,


--=20
Antonio Quartulli

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSP1d/AAoJEADl0hg6qKeOUIAP/370UtZZRtZhykBK60sNq9O5
p+12usU8o9LinEZVfp+UcuemOSvZTMsMTfFoNnhkmTayHxGaHM5gc38eKbHtaTzQ
+8MgDUKlJ3ggk+65ik/P139vxg4zdbkwajBvfEtYDFzLLR1elbKGUbkYb0SNr5P4
GvTsVK92xlWSFeHS6XIQc3hLrwTtG71V9Mh21kPJflXrGDsdZbFHDsi8Jb+Hwwwd
HfqB8PmSJrCghjPirDk57xw0y9JlGY5nlQRA0ohgXpo/5lFmTe+6Sq9O2Jr5eXaY
mzWk+pWSKEU3sDAVnOR9pSp9hkR5U9aPkQK1GZMtoNMM3DsM1coUti/tdgQJeqc/
31h+7zf8wLeNeREKYpX2kz/03YuL9riffHV9FK6iqANbD2aj3P7E1M25YWna39Kd
WNI0JDuC1BzGAgJN2v78fTj8fCDe9Co3TUahs/pzS3v6yo4JKsKlG9GGJiQ5AZAF
D8GVQOBHSK42LqESPs1e+gfRcVFKD80y4o9Gi/AYqv/vIGKu1CgWOpdHmXNIurP+
c9G5npFJNaOL9cz3w0+Q3to2q3KJgP3ApDs3CSXZ63IhmxSxhiA/J2BDEB+n2hJ4
xXVudWRaZwkXe16f/ylil3Gr2uUhHrkhhAeuTfKZG8S5XR/G1ZceK86N5coivezH
dea8O/lpEmeMeFji29ab
=kgpK
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
