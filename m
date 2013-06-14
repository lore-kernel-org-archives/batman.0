Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 14 Jun 2013 16:30:28 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130614143028.GA26907@pandem0nium>
References: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
 <1371200525-2011-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1371200525-2011-4-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/3] batman-adv: Modified forwarding
 behaviour for multicast packets
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


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2013 at 11:02:05AM +0200, Linus L=C3=BCssing wrote:
 =20
>  /**
> + * batadv_tt_orig_entries_count - count the number of originators
> + * @head: a list of originators
> + *
> + * Return the number of originator entries in the given list.
> + *
> + * The caller needs to hold the rcu_read_lock().
> + */
> +static int batadv_tt_orig_entries_count(struct hlist_head *head)
> +{
> +	struct batadv_tt_orig_list_entry *orig_entry;
> +	int count =3D 0;
> +
> +	hlist_for_each_entry_rcu(orig_entry, head, list) {
> +		if (!atomic_read(&orig_entry->refcount))
> +			continue;
> +
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
> +/**
> + * batadv_tt_global_hash_count - count the number of orig entries
> + * @hash: hash table containing the tt entries
> + * @addr: the mac address of the client to count entries for
> + * @vid: VLAN identifier
> + *
> + * Return the number of originators advertising the given address/data
> + * (excluding ourself).
> + */
> +int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
> +				const uint8_t *addr, unsigned short vid)
> +{
> +	struct hlist_head *head, *orig_list;
> +	struct batadv_tt_common_entry to_search, *tt_common_entry;
> +	struct batadv_tt_global_entry *tt_global_entry;
> +	uint32_t index;
> +	int count =3D 0;
> +
> +	if (!bat_priv->tt.global_hash)
> +		goto out;
> +
> +	memcpy(to_search.addr, addr, ETH_ALEN);
> +	to_search.vid =3D vid;
> +
> +	index =3D batadv_choose_tt(&to_search, bat_priv->tt.global_hash->size);
> +	head =3D &bat_priv->tt.global_hash->table[index];
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
> +		if (!batadv_compare_eth(tt_common_entry, addr))
> +			continue;
> +
> +		if (!atomic_read(&tt_common_entry->refcount))
> +			continue;
> +
> +		tt_global_entry =3D container_of(tt_common_entry,
> +					       struct batadv_tt_global_entry,
> +					       common);
> +		orig_list =3D &tt_global_entry->orig_list;
> +		count =3D batadv_tt_orig_entries_count(orig_list);
> +		break;
> +	}
> +	rcu_read_unlock();
> +
> +out:
> +	return count;
> +}
> +
> +/**

I've been thinking about this part ... it is not good to iterate over the w=
hole
hash for every multicast packet - this is the fastpath after all, so it's c=
ritical.

Can't you just use batadv_tt_global_hash_find(), count the list entries wit=
hin
struct batadv_tt_global_entry (or find out if it is empty, one entry or more
than one entry) and be done? This should be much faster.

Apart from that, the patch series appears to be pretty mature now, I've done
some more testing in my VMs and it looks good. Should be (hopefully) the la=
st
thing from my side. :)

Cheers,
	Simon

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlG7KQQACgkQrzg/fFk7axbFjACffLUDOyA+1orDsOdBs3DVT8O7
cNMAn0OtXWLWvk5Hq/1+ZX+/YJXJDg3f
=Uo2+
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
