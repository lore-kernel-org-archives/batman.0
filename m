Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 03:03:55 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201020355.GG24115@ritirata.org>
References: <cover.1354287613.git.martin@hundeboll.net>
 <18b535aef6c8db0d0dfcd55a9dfde6c7bb62e2c7.1354287613.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <18b535aef6c8db0d0dfcd55a9dfde6c7bb62e2c7.1354287613.git.martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Buffer unicast packets
 before forward.
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Fri, Nov 30, 2012 at 04:08:32PM +0100, Martin Hundeb=C3=B8ll wrote:
> diff --git a/network-coding.c b/network-coding.c
> index d9a601d..85288f2 100644
> --- a/network-coding.c
> +++ b/network-coding.c

[...]

>  int batadv_nc_init(struct batadv_priv *bat_priv)
>  {
> +	bat_priv->nc.timestamp_fwd_flush =3D jiffies;
> +
> +	if (bat_priv->nc.coding_hash)
> +		return 0;
> +
> +	bat_priv->nc.coding_hash =3D batadv_hash_new(128);
> +	if (!bat_priv->nc.coding_hash)
> +		goto err;
> +
> +	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
> +				   &batadv_nc_coding_hash_lock_class_key);
> +
>  	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
>  	batadv_nc_start_timer(bat_priv);
> -
>  	return 0;

ehm..why removing this blank line now? Either you leave it there or you don=
't
introduce it at all in the previous patch.

> +
> +err:
> +	return -ENOMEM;
>  }
> =20
>  /**
> @@ -56,6 +74,7 @@ void batadv_nc_init_bat_priv(struct batadv_priv *bat_pr=
iv)
>  {
>  	atomic_set(&bat_priv->network_coding, 1);
>  	bat_priv->nc.min_tq =3D 200;
> +	bat_priv->nc.max_fwd_delay =3D 10;

Maybe it's just my taste, but I would rather prefer to have all these const=
ants
defined somewhere (main.h ?) instead of throwing numbers directly in the co=
de. I
personally find much easier to change default parameters directly in a sing=
le
file instead of digging into the code (especially if I didn't write it :-))

[...]

> +static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_pr=
iv,
> +					      struct batadv_nc_path *nc_path)
> +{
> +	if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACTIVE)
> +		return true;
> +
> +	/* purge the path when no packets has been added for 10 times the
> +	 * max_fwd_delay time
> +	 */
> +	return batadv_has_timed_out(nc_path->last_valid,
> +				    bat_priv->nc.max_fwd_delay*10);

operands should be separated from the operator               ^^^


[...]

> +			/* purging an non-empty nc_path should never happen and
> +			 * leaks memory, so warn about it
> +			 */
> +			if (!unlikely(list_empty(&nc_path->packet_list))) {
> +				net_ratelimited_function(printk,
> +							 KERN_WARNING
> +							 "Skipping free of non-empty nc_path (%pM -> %pM)!\n",
> +							 nc_path->prev_hop,
> +							 nc_path->next_hop);

I don't have a clear overview of the whole thing, so this comment might be
wrong: here you state that if this condition occurs we are going to leak me=
mory,
so why not freeing all the packets in the list here?
If this is not really possible and this situation is a real "bug" (meaning =
the
code should never enter this if-loop) then I think it is worth a WARN_ON().


> +/**
> + * batadv_nc_hash_compare - comparing function used in the network codin=
g hash
> + *  tables
> + * @node: node in the local table
> + * @data2: second object to compare the node to
> + *
> + * Returns 1 if the two entry are the same, 0 otherwise
> + */
> +static int batadv_nc_hash_compare(const struct hlist_node *node,
> +				  const void *data2)
> +{
> +	const struct batadv_nc_path *nc_path1, *nc_path2;
> +
> +	nc_path1 =3D container_of(node, struct batadv_nc_path, hash_entry);
> +	nc_path2 =3D data2;
> +
> +	/* Return true if the two keys are identical */

you are returning 1/0, not true/false

[...]

> +/**
> + * batadv_nc_fwd_flush - Checks whether the given nc packet has hit its =
forward
> + *  timeout. If so, the packet is no longer delayed, immediately sent an=
d the
> + *  entry deleted from the queue. Has to be called with the appropriate =
locks.

This is supposed to be a short description (if needed it can span multiple
lines, but I would suggest to keep it simple). You can move big part of the=
 description
(don't remove it! It is very useful) below, together with the rest of the l=
ong
description (yes, the one
below the args is the long description; it is not supposed to contain the
returns value only)

> + * @bat_priv: the bat priv with all the soft interface information
> + * @nc_path: the nc path the packet belongs to
> + * @nc_packet: the nc packet to be checked
> + *
> + * Returns false as soon as the entry in the fifo queue has not been tim=
ed out
> + * yet and true otherwise.
> + */
> +static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
> +				struct batadv_nc_path *nc_path,
> +				struct batadv_nc_packet *nc_packet)
> +{

[...]

> +/**
> + * batadv_nc_process_nc_paths - traverse given nc packet pool and
> + * @bat_priv: the bat priv with all the soft interface information
> + * @hash: to be processed hash table
> + * process_fn: Function called to process given nc packet. Should return=
 true
> + *	       to encourage this function to proceed with the next packet.
> + *	       Otherwise the rest of the current queue is skipped.

missing @ and please align the second/third line right below the beginning =
of
the first (refer to Documentation/kernel-doc-nano-HOWTO.txt for more detail=
s)

> + */
> +static void
> +batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
> +			   struct batadv_hashtable *hash,
> +			   bool (*process_fn)(struct batadv_priv *,
> +					      struct batadv_nc_path *,
> +					      struct batadv_nc_packet *))
> +{
> +	struct hlist_node *node;
> +	struct hlist_head *head;
> +	spinlock_t *packet_list_lock; /* Protects lists in hash table */
> +	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
> +	struct batadv_nc_path *nc_path;
> +	bool ret;
> +	int i;
> +
> +	if (!hash)
> +		return;
> +
> +	/* Loop hash table bins */
> +	for (i =3D 0; i < hash->size; i++) {
> +		head =3D &hash->table[i];
> +
> +		/* Loop coding paths */
> +		rcu_read_lock();
> +		hlist_for_each_entry_rcu(nc_path, node, head, hash_entry) {
> +			packet_list_lock =3D &nc_path->packet_list_lock;
> +

Please remove this blank line right after the opening bracket.

> +			/* Loop packets */
> +			spin_lock_bh(packet_list_lock);
> +			list_for_each_entry_safe(nc_packet, nc_packet_tmp,
> +						 &nc_path->packet_list, list) {
> +

same here

> +				ret =3D process_fn(bat_priv, nc_path, nc_packet);
> +				if (!ret)
> +					break;
> +			}
> +			spin_unlock_bh(packet_list_lock);
> +		}
> +		rcu_read_unlock();
> +	}
> +}

[...]

> =20
>  /**
> -<<<<<<< HEAD
> -=3D=3D=3D=3D=3D=3D=3D

mh..interesting ;-)

[...]

> +
> +	/* Add nc_path to hash table */
> +	hash_added =3D batadv_hash_add(hash, batadv_nc_hash_compare,
> +				     batadv_nc_hash_choose,
> +				     (void *)&nc_path_key,

you don't need to cast to (void *)



Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQuWWLAAoJEADl0hg6qKeO8xMQAKIATCaDmg96r2ta0C+2smGZ
r6eL9kIjapBwsVo2qhNWjwsPlD748Ef+ly1c4GoZ14B+kfD4hKEeMVlupcbQQOrA
eaL0TZjHG9U8etZn1s6T9ZEG3HrrKfEFqyKT1Nm4RqHcHFwuBHs2ynQc2JFqqa1Y
pFQ/7NhQm06Bn2vppfTiyn8/mBOK8hKwSIaiJcAwOnr/wTW7L7iOUB06G+Er0vFj
3dr4B1v7qkE+zAGnoiWgl50IaML/c3XwIUMP1XIfwKMXeembD667gaUkytJeZTm2
S8cFGa4YFl2KMiu1/GkcMzJtN37c1okuNaaY5NTbpAhDzSq/vPtVBsMiIj26puh5
FDaG1aTAc3woYZQX6vN2sipzy3agO0P87Qa8GSrSTVopenZDbq5O15l06ndzeR/B
rEfQzzr9zQKqqcr24xddqIGJ0AHsONLESd+1Ds+8aiF7y78XQn0iUaDQoeZmInB/
kPhuIUHWKoxG3qq/EZxhzJY/fAWyK9llLDCNtusxMswlvkPXEd8r8hj0CzgWFMgR
COOvNnLZnHHrrr7mKf5K4KnDU5tGe6/ooVQ/yGXoVQCoR9oGhd+UUULmnDNg4aWP
UMf85Cuyy3bMh+uB8zsjabOe0i3tlqi8aVFMKlsDS0Q/s+Cs8yDBB0/BuZ7VoN/x
Ldr0FJ+sq7zacxb1i2hp
=Tv2o
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
