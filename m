Return-Path: <ordex@autistici.org>
Date: Sun, 12 May 2013 01:29:29 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130511232929.GF901@ritirata.org>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <1368293014-30742-4-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Modified forwarding
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


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2013 at 07:23:27PM +0200, Linus L=C3=BCssing wrote:
> With this patch a multicast packet is not always simply flooded anymore,
> the bevahiour for the following cases is changed to reduce
> unnecessary overhead:
>=20
> If all nodes within the horizon of a certain node have signalized
> multicast listener announcement capability
> (BATADV_MCAST_LISTENER_ANNOUNCEMENT) then an IPv6 multicast packet
> with a destination of IPv6 link-local scope coming from the upstream
> of this node...
>=20
> * ...is dropped if there is no according multicast listener in the
>   translation table.
> * ...is forwarded via unicast if there is a single node with interested
>   multicast listeners.
>=20

othwerwise? Does it get flooded like now if there is more than one receiver?

> =20
>  /**
> + * batadv_mcast_flood - Checks on how to forward a multicast packet
> + * @skb: The multicast packet to check
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Returns 1 if the packet should be flooded, 0 if it should be forwarded
> + * via unicast or -1 if it should be drooped.
> + */
> +int batadv_mcast_flood(struct sk_buff *skb, struct batadv_priv *bat_priv)
> +{
> +	struct ethhdr *ethhdr =3D (struct ethhdr *)(skb->data);
> +	struct ipv6hdr *ip6hdr;
> +	int count, ret =3D 1;
> +
> +	if (atomic_read(&bat_priv->mcast_group_awareness) &&
> +	    !atomic_read(&bat_priv->mcast_num_non_aware) &&
> +	    ntohs(ethhdr->h_proto) =3D=3D ETH_P_IPV6) {

mh..this would not work for VLANs..did you plan to introduce support for VL=
ANs
later? or you simply overlooked it? :)

> +		if (!pskb_may_pull(skb, sizeof(*ethhdr) + sizeof(*ip6hdr))) {
> +			ret =3D -1;
> +			goto out;
> +		}
> +
> +		ip6hdr =3D ipv6_hdr(skb);
> +
> +		/* TODO: Implement Multicast Router Discovery, then add
> +		 * scope >=3D IPV6_ADDR_SCOPE_LINKLOCAL, too */
> +		if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=3D
> +		    IPV6_ADDR_SCOPE_LINKLOCAL)
> +			goto out;
> +
> +		count =3D batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest);
> +
> +		if (!count)
> +			ret =3D -1;
> +		else if (count =3D=3D 1)
> +			ret =3D 0;

how can this function return more than one?
When there is more than one originator announcing the same MAC address then=
 we
have _a single_ global entry having a list of orig_entry. but stil only one
global entry.

so you may want to count the orig_entries rather than the global_entries?

> diff --git a/translation-table.c b/translation-table.c
> index 37e7d47..1d2d618 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -83,6 +83,40 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, con=
st void *data)
>  	return tt_common_entry_tmp;
>  }
> =20
> +/**
> + * batadv_tt_hash_count - Counts the number of tt entries for the given =
data
> + * @hash: hash table containing the tt entries
> + * @data: The data to count entries for

One line saying what you are returning would be nice :)

> + */
> +static int batadv_tt_hash_count(struct batadv_hashtable *hash, const voi=
d *data)
> +{
> +	struct hlist_head *head;
> +	struct batadv_tt_common_entry *tt_common_entry;
> +	uint32_t index;
> +	int count =3D 0;
> +
> +	if (!hash)
> +		goto out;
> +
> +	index =3D batadv_choose_orig(data, hash->size);
> +	head =3D &hash->table[index];
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
> +		if (!batadv_compare_eth(tt_common_entry, data))
> +			continue;
> +
> +		if (!atomic_read(&tt_common_entry->refcount))
> +			continue;
> +
> +		count++;
> +	}
> +	rcu_read_unlock();
> +
> +out:
> +	return count;
> +}

as I asked before: this function cannot return >1 because the same address =
is
never stored twice.


Nice job so far!
Thanks for working on this cool feature!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRjtRZAAoJEADl0hg6qKeOKdMQAKYnLp1/PeNEudzJ6zVbszyb
7jS3Jawe2jn6lZqYOFzSv4e7euWHm0o+VMH3eKShnNMPGuTRKBHwTUUNOq1D/ASo
CumNvxEzTDdoAJX8+jf7CmGu7waH7Fwa8xn0VLPa1d8mCJMe4popW/8wdQsxoV9M
DFgvN346FpRyBPoRHK+8Frx2u2dEP8f9pzYQ6NTcpVil5ADhqniYzj5r1UsDog3U
iQhok/SiIEsBjalfigkfKAs4+xCykx6rczzNxhrFXPUMnR8kcnRNSbtf+0rt1t9+
VAHkDtOYBN0fq3Et+GzFY0Y6WvVUiP99albSO7um+xO9eLP0gRIvL1xTi7SSc47N
nJXoQasUcwEOjmx4cs6n1EXP+LxTkGTGAdELEzXXDJifKKEmwyEZu11uGmznZfwi
+6B7UkW5usAZsu4HzH1oA9sWppX5PJQbIp8r8NYONOd87UjJkfpwMGQrr+bxlzYs
5YcXImgXtdrruF3UPYDs0EYvmLBFwtzNy4jPjYo9kcF73H6eRxK0hC5oHHR6ui93
KWk8i4jtkRJCAw0zvJl0aizOaDHk5mSd3hNbcCEI5avism4qXTpV6NzzJqCvT+kN
PDc+dGcXb+JVIat6UiCUhyqfmqjZkvqlw/uLs5FZ/v8B9JwCnIGJgb7zD4YtP+ac
vmcJXX7Y9SjzVsiA9Apj
=Djmq
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
