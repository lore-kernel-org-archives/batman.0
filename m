Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 23 Jan 2011 04:00:39 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110123030039.GB15942@pandem0nium>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
	<1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
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


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

please see comments inline.


On Sat, Jan 22, 2011 at 02:21:30AM +0100, Linus L=C3=BCssing wrote:
> [...]
> +static int add_router_of_dest(struct dest_entries_list *next_hops,
> +			      uint8_t *dest, struct bat_priv *bat_priv)
> +{
> +	struct dest_entries_list *next_hop_tmp, *next_hop_entry;
> +	struct element_t *bucket;
> +	struct orig_node *orig_node;
> +	struct hashtable_t *hash =3D bat_priv->orig_hash;
> +	struct hlist_node *walk;
> +	struct hlist_head *head;
> +	int i;
> +
> +	next_hop_entry =3D kmalloc(sizeof(struct dest_entries_list), GFP_ATOMIC=
);
> +	if (!next_hop_entry)
> +		return 1;
> +
> +	next_hop_entry->batman_if =3D NULL;
> +	for (i =3D 0; i < hash->size; i++) {
> +		head =3D &hash->table[i];
> +
> +		rcu_read_lock();
> +		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
> +			orig_node =3D bucket->data;
> +
> +			if (memcmp(orig_node->orig, dest, ETH_ALEN))
> +				continue;
> +
Traversing the hash yourself seems pretty redundant. If you need to find a=
=20
specific node, you can just use hash_find().

> +			if (!orig_node->router) {
> +				i =3D hash->size;
> +				break;
> +			}
> +
> +			memcpy(next_hop_entry->dest, orig_node->router->addr,
> +			       ETH_ALEN);
> +			next_hop_entry->batman_if =3D
> +						orig_node->router->if_incoming;
> +			i =3D hash->size;
> +			break;
> +		}
> +		rcu_read_unlock();
> +	}
> [...]
> +static void zero_tracker_packet(struct mcast_tracker_packet *tracker_pac=
ket,
> +				uint8_t *next_hop, struct bat_priv *bat_priv)
> +{
> +	struct tracker_packet_state state;
> +
> +	struct element_t *bucket;
> +	struct orig_node *orig_node;
> +	struct hashtable_t *hash =3D bat_priv->orig_hash;
> +	struct hlist_node *walk;
> +	struct hlist_head *head;
> +	int i;
> +
> +	tracker_packet_for_each_dest(&state, tracker_packet) {
> +		for (i =3D 0; i < hash->size; i++) {
> +			head =3D &hash->table[i];
> +
> +			rcu_read_lock();
> +			hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
> +				orig_node =3D bucket->data;
> +
> +				if (memcmp(orig_node->orig, state.dest_entry,
> +					   ETH_ALEN))
> +					continue;
Same here. Just use hash_find().
> +
> +				/* is the next hop already our destination? */
> +				if (!memcmp(orig_node->orig, next_hop,
> +					    ETH_ALEN))
> +					memset(state.dest_entry, '\0',
> +					       ETH_ALEN);
> +				else if (!orig_node->router)
> +					memset(state.dest_entry, '\0',
> +					       ETH_ALEN);
> +				else if (!memcmp(orig_node->orig,
> +						 orig_node->router->orig_node->
> +						 primary_addr, ETH_ALEN))
> +					memset(state.dest_entry, '\0',
> +					       ETH_ALEN);
> +				/* is this the wrong next hop for our
> +				 * destination? */
> +				else if (memcmp(orig_node->router->addr,
> +						next_hop, ETH_ALEN))
> +					memset(state.dest_entry, '\0',
> +					       ETH_ALEN);
> +
> +				i =3D hash->size;
> +				break;
> +			}
> +			rcu_read_unlock();
> +		}
> +	}
> +}
=20

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk07mdcACgkQrzg/fFk7axagvgCfQVeO2pBWgqjF41Vq4mGj/t+q
gbwAoOhwHULsNZl992hjDeL36iMHLqld
=A01Q
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
