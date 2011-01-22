Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 22 Jan 2011 23:00:50 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110122220050.GA11480@pandem0nium>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
	<1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/19] batman-adv: Prepare and send
	own	multicast tracker packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

please see some comments inline.

On Sat, Jan 22, 2011 at 02:21:30AM +0100, Linus L=C3=BCssing wrote:
> [...]
> =20
> +static inline int find_mca_match(struct orig_node *orig_node,
> +		int mca_pos, uint8_t *mc_addr_list, int num_mcast_entries)
> +{
> +	int pos;
> +
> +	for (pos =3D 0; pos < num_mcast_entries; pos++)
> +		if (!memcmp(&mc_addr_list[pos*ETH_ALEN],
> +			    &orig_node->mca_buff[ETH_ALEN*mca_pos], ETH_ALEN))
> +			return pos;
> +	return -1;
> +}

A comment explaining this function find_mca_match() would be nice.

> +
> +/**
> + * Prepares a multicast tracker packet on a multicast member with all its
> + * groups and their members attached. Note, that the proactive tracking
> + * mode does not differentiate between multicast senders and receivers,
> + * resulting in tracker packets between each node.
> + *
> + * Returns NULL if this node is not a member of any group or if there are
> + * no other members in its groups.
> + *
> + * @bat_priv:		bat_priv for the mesh we are preparing this packet
> + */
> +static struct mcast_tracker_packet *mcast_proact_tracker_prepare(
> +			struct bat_priv *bat_priv, int *tracker_packet_len)
> +{
> +	struct net_device *soft_iface =3D bat_priv->primary_if->soft_iface;
> +	uint8_t *mc_addr_list;
> +	MC_LIST *mc_entry;
> +	struct element_t *bucket;
> +	struct orig_node *orig_node;
> +	struct hashtable_t *hash =3D bat_priv->orig_hash;
> +	struct hlist_node *walk;
> +	struct hlist_head *head;
> +	int i;
> +
> +	/* one dest_entries_list per multicast group,
> +	 * they'll collect dest_entries[x] */
> +	int num_mcast_entries, used_mcast_entries =3D 0;
> +	struct list_head *dest_entries_list;
> +	struct dest_entries_list dest_entries[UINT8_MAX], *dest, *tmp;

This will reserve 256 * 18 =3D 4608 byte on the stack, which=20
is too much for 4k stacks. Please allocate this somewhere else.


> +	int num_dest_entries, dest_entries_total =3D 0;
> +
> +	uint8_t *dest_entry;
> +	int pos, mca_pos;
> +	struct mcast_tracker_packet *tracker_packet =3D NULL;
> +	struct mcast_entry *mcast_entry;
> +
> +	if (!hash)
> +		goto out;
> +
> +	/* Make a copy so we don't have to rush because of locking */
> +	netif_addr_lock_bh(soft_iface);
> +	num_mcast_entries =3D netdev_mc_count(soft_iface);
> +	mc_addr_list =3D kmalloc(ETH_ALEN * num_mcast_entries, GFP_ATOMIC);
> +	if (!mc_addr_list) {
> +		netif_addr_unlock_bh(soft_iface);
> +		goto out;
> +	}
> +	pos =3D 0;
> +	netdev_for_each_mc_addr(mc_entry, soft_iface) {
> +		memcpy(&mc_addr_list[pos * ETH_ALEN], mc_entry->MC_LIST_ADDR,
> +		       ETH_ALEN);
> +		pos++;
> +	}
> +	netif_addr_unlock_bh(soft_iface);
> +
> +	if (num_mcast_entries > UINT8_MAX)
> +		num_mcast_entries =3D UINT8_MAX;
> +	dest_entries_list =3D kmalloc(num_mcast_entries *
> +					sizeof(struct list_head), GFP_ATOMIC);
> +	if (!dest_entries_list)
> +		goto free;
> +
> +	for (pos =3D 0; pos < num_mcast_entries; pos++)
> +		INIT_LIST_HEAD(&dest_entries_list[pos]);
> +

dest_entries[...].list should be initialized here too, shouldn't they?
BTW, the names a re a little bit confusing (dest_entries_list vs. dest_entr=
ies),
other names and an explanation would be helpful.

> +	/* fill the lists and buffers */
> +	for (i =3D 0; i < hash->size; i++) {
> +		head =3D &hash->table[i];
> +
> +		rcu_read_lock();
> +		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
> +			orig_node =3D bucket->data;
> +			if (!orig_node->num_mca)
> +				continue;
> +
> +			num_dest_entries =3D 0;
> +			for (mca_pos =3D 0; mca_pos < orig_node->num_mca &&
> +			     dest_entries_total !=3D UINT8_MAX; mca_pos++) {
> +				pos =3D find_mca_match(orig_node, mca_pos,
> +					mc_addr_list, num_mcast_entries);
> +				if (pos > UINT8_MAX || pos < 0)

Shouldn't this rather be=20
	if (pos >=3D num_mcast_entries || pos < 0)

(it is used for dest_entries_list after all).

> +					continue;
> +				memcpy(dest_entries[dest_entries_total].dest,
> +				       orig_node->orig, ETH_ALEN);
> +				list_add(
> +					&dest_entries[dest_entries_total].list,
> +					&dest_entries_list[pos]);
> +
> +				num_dest_entries++;
num_dest_entries is obsolete IMHO, it is only increase but never used.

> +				dest_entries_total++;
> +			}
> +		}
> +		rcu_read_unlock();
> +	}
> +
> +	/* Any list left empty? */
> +	for (pos =3D 0; pos < num_mcast_entries; pos++)
> +		if (!list_empty(&dest_entries_list[pos]))
> +			used_mcast_entries++;
> +
> +	if (!used_mcast_entries)
>=20

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk07U5IACgkQrzg/fFk7axZIywCgoHtbCOHrk/C01OY7XBB0xcjd
7wkAnRv6JAP5ugMRnRmpbn+3MkhBVSta
=Pil0
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
