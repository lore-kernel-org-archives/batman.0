Return-Path: <ordex@autistici.org>
Date: Sun, 12 May 2013 00:55:25 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130511225525.GD901@ritirata.org>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <1368293014-30742-2-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Multicast Listener
 Announcements via Translation Table
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


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

here you have some comments inline

On Sat, May 11, 2013 at 07:23:25PM +0200, Linus L=C3=BCssing wrote:
> diff --git a/main.h b/main.h
> index 795345f..39c683d 100644
> --- a/main.h
> +++ b/main.h
> @@ -141,6 +141,14 @@ enum batadv_uev_type {
>  /* Append 'batman-adv: ' before kernel messages */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
> +#define UINT8_MAX 255

I think you should define it as 255U, otherwise it would get the int type a=
nd
may generate warnings somewhere (or also unexpected result sometime..)

> +
> +/* identical to the one used in net/ipv4/igmp.c */
> +#define for_each_pmc_rcu(in_dev, pmc)				\
> +	for (pmc =3D rcu_dereference(in_dev->mc_list);		\
> +	     pmc !=3D NULL;					\
> +	     pmc =3D rcu_dereference(pmc->next_rcu))
> +

Since it is exactly the same code reported in net/ipv4/igmp.c and since it =
is a
define, don't you thin kit is worth trying to send a patch to netdev to mov=
e the
define in a proper header file so that we/everybody can re-use it?

> +
> +/**
> + * batadv_mcast_mla_local_collect - Collects local multicast listeners

please start the description with a small letter (like we do everywhere..ju=
st
keep the same style)

> + * @dev:		The device to collect multicast addresses from

don't put tabs between the name of the arg and the description.
don't use the capital letter. Just:

@dev: the device..

would be nice :)

> +static int batadv_mcast_mla_local_collect(struct net_device *dev,
> +					  struct list_head *mcast_list,
> +					  int num_mla_max) {

The opening parenthesis of a function must go at the beginning of the next =
line.

> +	struct netdev_hw_addr *mc_list_entry, *new;
> +	int num_mla =3D 0, ret =3D 0;
> +
> +	netif_addr_lock_bh(dev);
> +	netdev_for_each_mc_addr(mc_list_entry, dev) {
> +		if (num_mla >=3D num_mla_max) {
> +			pr_warn("Too many local multicast listener announcements here, just a=
dding %i\n",
> +				num_mla_max);

why pr_warn and not just a debug message? Is this a symptom of a possible
malfunctioning?


> +			break;
> +		}
> +
> +		new =3D kmalloc(sizeof(struct netdev_hw_addr), GFP_ATOMIC);

please use sizeof(*new) here. we agreed on this some time ago. This helps
because if we decide to change the type of new in the future then we do not=
 need
to change all the kmalloc invocations.

> +static bool batadv_mcast_mla_is_duplicate(uint8_t *mcast_addr,
> +					  struct list_head *mcast_list)
> +{
> +	struct netdev_hw_addr *mcast_entry;
> +
> +	list_for_each_entry(mcast_entry, mcast_list, list)
> +		if (!memcmp(mcast_entry->addr, mcast_addr, ETH_ALEN))

in main.h we have batadv_compare_eth(), you can re-use it here

> +static void batadv_mcast_mla_tt_clean(struct batadv_priv *bat_priv,
> +				      struct list_head *mcast_list)
> +{
> +	struct netdev_hw_addr *mcast_entry, *tmp;
> +
> +	list_for_each_entry_safe(mcast_entry, tmp, &bat_priv->mcast.mla_list,
> +				 list) {
> +		if (batadv_mcast_mla_is_duplicate(mcast_entry->addr,
> +						  mcast_list))
> +			continue;
> +
> +		batadv_tt_local_remove(bat_priv, mcast_entry->addr,
> +				       "mcast TT outdated", 0);
                                                           ^^^

parameter is bool, please use "false" instead of 0

> +static void batadv_mcast_mla_tt_add(struct net_device *soft_iface,
> +				    struct list_head *mcast_list)
> +{
> +	struct netdev_hw_addr *mcast_entry, *tmp;
> +	struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);

why not simply pass bat_priv as first argument (as you do in all the other
functions) and then use bat_priv->soft_iface when needed ?
(this soft_iface member has been added recently to save code for lazy peopl=
e :))

> +/**
> + * batadv_mcast_mla_tt_update - Updates the own MLAs
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Updates the own multicast listener announcements in the translation

For some reason we agreed on not using the third person while describing the
function. For consistency I'd suggest you to do the same your kernel doc.

> + * table. Also takes care of registering or unregistering the multicast
> + * tvlv depending on whether the user activated or deactivated
> + * multicast optimizations.
> + */
> +void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
> +{
> +	struct batadv_hard_iface *primary_if;
> +	struct net_device *soft_iface;
> +	struct list_head mcast_list;
> +	int ret;
> +	static bool enabled;
> +
> +	INIT_LIST_HEAD(&mcast_list);
> +
> +	primary_if =3D batadv_primary_if_get_selected(bat_priv);
> +	if (!primary_if)
> +		goto out;
> +
> +	soft_iface =3D primary_if->soft_iface;
> +
> +	/* Avoid attaching MLAs, if multicast optimization is disabled
> +	 * or there is a bridge on top of our soft interface (TODO) */

/* comments should
 * be closed
 * like this
 */

 /* not like
  * this */

(this is something checkpatch should also tell you (but I guess only when y=
our
code is in the net/ folder inside the kernel tree...yes it is a netdev rule=
 only
:))

> +/**
> + * batadv_mcast_free - Frees the multicast optimizaitons structures
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +void batadv_mcast_free(struct batadv_priv *bat_priv)
> +{
> +	struct list_head mcast_list;
> +
> +	INIT_LIST_HEAD(&mcast_list);
> +
> +	batadv_mcast_mla_tt_clean(bat_priv, &mcast_list);

can't you make batadv_mcast_mla_tt_clean() take a NULL second argument and =
in
that case skip the check in the loop? would be cleaner I guess? what do you
think?


> diff --git a/translation-table.c b/translation-table.c
> index df6b5cd..37e7d47 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -26,6 +26,7 @@
>  #include "originator.h"
>  #include "routing.h"
>  #include "bridge_loop_avoidance.h"
> +#include "multicast.h"
> =20
>  #include <linux/crc32c.h>
> =20
> @@ -281,7 +282,8 @@ void batadv_tt_local_add(struct net_device *soft_ifac=
e, const uint8_t *addr,
>  	bool roamed_back =3D false;
> =20
>  	tt_local =3D batadv_tt_local_hash_find(bat_priv, addr);
> -	tt_global =3D batadv_tt_global_hash_find(bat_priv, addr);
> +	tt_global =3D is_multicast_ether_addr(addr) ? NULL :
> +		    batadv_tt_global_hash_find(bat_priv, addr);

what about:

tt_global =3D NULL; (you can put this directly in the declaration)
if (!is_multicast_ether_addr(addr))
	tt_global =3D batadv_tt_global_hash_find(bat_priv, addr);

it is a bit easier to read, no?

> =20
>  	if (tt_local) {
>  		tt_local->last_seen =3D jiffies;
> @@ -332,8 +334,10 @@ void batadv_tt_local_add(struct net_device *soft_ifa=
ce, const uint8_t *addr,
>  	tt_local->last_seen =3D jiffies;
>  	tt_local->common.added_at =3D tt_local->last_seen;
> =20
> -	/* the batman interface mac address should never be purged */
> -	if (batadv_compare_eth(addr, soft_iface->dev_addr))
> +	/* the batman interface mac and multicast addresses should never be
> +	 * purged */

comment style like above

> +	if (batadv_compare_eth(addr, soft_iface->dev_addr) ||
> +	    is_multicast_ether_addr(addr))
>  		tt_local->common.flags |=3D BATADV_TT_CLIENT_NOPURGE;
> =20
>  	hash_added =3D batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_=
tt,
> @@ -919,6 +923,10 @@ add_orig_entry:
>  	ret =3D true;
> =20
>  out_remove:
> +	/* Do not remove multicast addresses from the local hash on
> +	 * global additions */
> +	if (is_multicast_ether_addr(tt_addr))
> +		goto out;
> =20
>  	/* remove address from local hash if present */
>  	local_flags =3D batadv_tt_local_remove(bat_priv, tt_addr,
> @@ -2346,6 +2354,9 @@ void batadv_tt_local_commit_changes(struct batadv_p=
riv *bat_priv)
>  {
>  	uint16_t changed_num =3D 0;
> =20
> +	/* Update multicast addresses in local translation table */
> +	batadv_mcast_mla_tt_update(bat_priv);
> +
>  	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
>  		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
>  			batadv_tt_tvlv_container_update(bat_priv);
> diff --git a/types.h b/types.h
> index c84f5cc..5d73a75 100644
> --- a/types.h
> +++ b/types.h
> @@ -473,6 +473,12 @@ struct batadv_priv_dat {
>  };
>  #endif
> =20
> +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> +struct batadv_priv_mcast {
> +	struct list_head mla_list;
> +};
> +#endif
> +
>  /**
>   * struct batadv_priv_nc - per mesh interface network coding private data
>   * @work: work queue callback item for cleanup
> @@ -561,6 +567,9 @@ struct batadv_priv {
>  #ifdef CONFIG_BATMAN_ADV_DAT
>  	atomic_t distributed_arp_table;
>  #endif
> +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> +	atomic_t mcast_group_awareness;
> +#endif
>  	atomic_t gw_mode;
>  	atomic_t gw_sel_class;
>  	atomic_t orig_interval;
> @@ -595,6 +604,9 @@ struct batadv_priv {
>  #ifdef CONFIG_BATMAN_ADV_DAT
>  	struct batadv_priv_dat dat;
>  #endif
> +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> +	struct batadv_priv_mcast mcast;
> +#endif
>  #ifdef CONFIG_BATMAN_ADV_NC
>  	atomic_t network_coding;
>  	struct batadv_priv_nc nc;
> --=20
> 1.7.10.4


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRjsxdAAoJEADl0hg6qKeODgoP/jD5+76q7STa2woxfqX/MYnw
5fFzZF6yEVvSCHlRz2NyQz5eB5QFbXH8FASE5LXZb2sP3yuLb1WPsrlcd2J5oyzz
N//mtcbLvr6YzUcgy5pUBx5JYsb0UUjkze3bxrB2k4jxGaxpc2LRUI4u1ig/TFFf
UfIDikES/jIxlkLUa/QBt7qQ4IcsLIso/HP9h/u5FlYL9gNCDI/uD477DS4sfT5M
esuiWtI/SzMVuckxa5PQldXLxP+xKLh2xYKmFTLpLtn/z3iAYnP5aLGrF30O0To3
xttfU+E8sqdZxSGm7eWPdk2+XJ4GCbQ3QL8J110uC+ANpyECOjUSpIT5LOajheqY
eNnbGkqzroyuKLqr/l0auXE/vAzDiIT9GgEk0rAzQNqDLmJuX+9qVv+gqTB39/lS
jcdAyoOxIvrKSkDKcDBbQKmteXoBfyEsA0rms7FpZ+ayh5kDs3AqHG5WgcVUv7nS
MRUj8yvIfyH9vnBdwO5csMxD5hKX753dQNlV1oIrZZ9Z9rj0ybthp0jdtk68YCqE
BsShZeaHtNZuND1DpMfhK1vLEnLDMVnPhMcGevjCaN02xZ5qja/DyYx25Ms6FUCr
mGuYSXde/wcncXtK3BFH2ywRFKQ6qZ1D9FSAQdIITRZw7l5KYFQcg3NLyA8wsqW9
5e6zzZBSLsMgu3eAW5Ju
=NEjP
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
