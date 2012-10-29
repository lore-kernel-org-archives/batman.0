Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Oct 2012 16:30:10 +0100
Message-ID: <1704253.EuqF38gjUr@bentobox>
In-Reply-To: <1351523401-9188-1-git-send-email-ordex@autistici.org>
References: <1351523401-9188-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1555557.9pjGssCebm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't free resources when
	DAT is disabled
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1555557.9pjGssCebm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 29 October 2012 16:10:01 Antonio Quartulli wrote:
> Freeing all the resources when DAT is disabled need a much more complicated
> locking system to prevent concurrent enable/disable operations to destroy
> the internal state of the component. For now it is safe to avoid such
> freeing operation at all when DAT gets disabled.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  distributed-arp-table.c | 10 ----------
>  sysfs.c                 |  3 +--
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index c933615..7921030 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -1061,13 +1061,3 @@ out:
>  		batadv_dat_entry_free_ref(dat_entry);
>  	return ret;
>  }
> -
> -void batadv_dat_switch(struct net_device *net_dev)
> -{
> -	struct batadv_priv *bat_priv = netdev_priv(net_dev);
> -
> -	if (atomic_read(&bat_priv->distributed_arp_table))
> -		batadv_dat_init(bat_priv);
> -	else
> -		batadv_dat_free(bat_priv);
> -}

Also remove it from distributed-arp-table.h

--nextPart1555557.9pjGssCebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQjqECAAoJEF2HCgfBJntGhC4P/jTeVbhPRlAnWs+J83/AG2ga
QUPQrvgXE1rXUGwE/bnQyWbtFWZHzBlTGCQfbjwGZOPgzeGo9pLguGLwLLroRTGz
jH7PHjxo3+ZbITXwrvwAfaUMgwfxliE733ZmNbA9oxtC5JYgFMY954eB0xs1mxWE
ESgwyRbCnKaXm2laBCm7jZIqKABRJYpHXaqxaLjmvGPdezwC2mc1v29t/krlsipu
yMNyBQi3ksQaLOEWw0f3WVReNOVV2+KZ48ozbdpxVOaYaZfmRsqJS8MRJlu2lZme
s3xipu7enRG8vKumRZTREKxrSU1RDWVZdWh4M0S33EMqOogGa9JBdyO9uPj8eegv
aslMRjyDBFsusXORSzVsUWTeH5gu2GO3guXWJ9RJ4jYdAmFYnd88x8iFPYVFaCI6
xq2x541AdbR489kbJu2gK3iiHDDfwdQkXxP+OtkWIdlrXf6XL80VUPhH+itcpzkb
kNdD89oje3MwQgdDkgiSdmxuzx6Nd9mbNfwgoKE95FChuB31qGUHGv3Tza+qJLwh
6PMDGRsljl3dqj3cDUJwipy2bPU04X15FcdwDLCGRR0f4Ty/5lLv/4ROM4+o2UNS
TjfTBoCT2Z7J4c05KAx1RphOWGp6Gd18o2asOI2eZ3X3OUtD3vrKtYxRV4CIZJz8
gvcp76alr+oV/IzeP+Au
=LOgV
-----END PGP SIGNATURE-----

--nextPart1555557.9pjGssCebm--

