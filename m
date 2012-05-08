Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 May 2012 22:38:58 +0200
Message-ID: <5459592.26kVfpJHA4@sven-desktop.home.narfation.org>
In-Reply-To: <ebf1a5f57c2b4069b177913c3a7ee3d7e0b8db3d.1336509029.git.mschiffer@universe-factory.net>
References: <201205081359.26707.lindner_marek@yahoo.de>
	<ebf1a5f57c2b4069b177913c3a7ee3d7e0b8db3d.1336509029.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1524940.gLgiYeOsYP";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix locking in hash_add()
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1524940.gLgiYeOsYP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 08 May 2012 22:31:57 Matthias Schiffer wrote:
> To ensure an entry isn't added twice all comparisons have to be protected by
> the hash line write spinlock. This doesn't really hurt as the case that it
> is tried to add an element already present to the hash shouldn't occur very
> often, so in most cases the lock would have have to be taken anyways.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  hash.h |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hash.h b/hash.h
> index 7bcb98f..2e0409a 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -109,26 +109,23 @@ static inline int hash_add(struct hashtable_t *hash,
>  	head = &hash->table[index];
>  	list_lock = &hash->list_locks[index];
> 
> -	rcu_read_lock();
> -	__hlist_for_each_rcu(node, head) {
> +	spin_lock_bh(list_lock);
> +
> +	hlist_for_each(node, head) {
>  		if (!compare(node, data))
>  			continue;
> 
>  		ret = 1;
> -		goto err_unlock;
> +		goto unlock;
>  	}
> -	rcu_read_unlock();
> 
>  	/* no duplicate found in list, add new element */
> -	spin_lock_bh(list_lock);
>  	hlist_add_head_rcu(data_node, head);
> -	spin_unlock_bh(list_lock);
> 
>  	ret = 0;
> -	goto out;
> 
> -err_unlock:
> -	rcu_read_unlock();
> +unlock:
> +	spin_unlock_bh(list_lock);
>  out:
>  	return ret;
>  }

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven
--nextPart1524940.gLgiYeOsYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPqYRiAAoJEF2HCgfBJntGSWYP/3SO5eQSlalNNfOvC5lcCPZ7
Mft1AYsfUUQlfSDDBPzK7BJHwMgjmQ8942Q/ChvtgDXtw0Cd+4ydOONtHHRv2zkJ
hrefJ0qqm7gRzls2jzkQC3BY5uheXx97ndmZEq7k+KngT37J81D7pgNcqevm5XXy
CHT3UmHKfAffBamjwduuejsGssLJStPzJnDo/Av0+MkU/17jbzj0/DaYwDls/eh6
p7B/S8jZtcH+yH98uBeiYpeb6b5kHUSWmB+dTrZPfJPiWz1JnyE0VI7avGdY2NZp
VpFaQ79S1cvoq1FbGyiuHTctWA1Un409Re4/NiHk5F0MBvbK2lFblwMZmhGiY894
jkxlyex1axQbWtNF3hOPZKExJxekYnj3WgZ983Iw2myoe8L87ES/qv7ws31iWEua
7OVG1X92hzUL2QReHVA2AxpPkc/BeCq3gVwNXsl1hFuWRAgxiB/+97sRP0cZL2ml
g5PgEdjze6upABe72Tx3/+FfrXUXFfycpXftMthEOsqbCFkxq3z++kJkTIXFOLhv
iIAS/QSbvsp9WZNNuN1X5r4R/gVKrYC49/jpTnnUujcdc4QJrwMQJQoK8G/uc4LH
CEgLxqAxiGYJ8mI43epVP6UmM/Me7uK5Mp7ziZI9I+JMiZu6Prz+/xOmss+req42
JD8em8I8CxqAphhHTdYq
=Ssxz
-----END PGP SIGNATURE-----

--nextPart1524940.gLgiYeOsYP--

