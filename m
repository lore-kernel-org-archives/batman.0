Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Dec 2013 22:15:57 +0800
Message-ID: <14186390.DvsAzCSDXC@diderot>
In-Reply-To: <1387294513-12541-1-git-send-email-sw@simonwunderlich.de>
References: <1387294513-12541-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4760456.IrGRreA4ct";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix NULL pointer deref in
	batadv_find_best_neighbor
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


--nextPart4760456.IrGRreA4ct
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 17 December 2013 16:35:13 Simon Wunderlich wrote:
> If there is no best neighbor, don't dereference the NULL pointer.
> 
> Introduced by 9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv:
> split tq information in neigh_node struct")
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  originator.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/originator.c b/originator.c
> index 2243003..9fcde58 100644
> --- a/originator.c
> +++ b/originator.c
> @@ -789,7 +789,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
>  					best, if_outgoing) <= 0))
>  			best = neigh;
> 
> -	if (!atomic_inc_not_zero(&best->refcount))
> +	if (best && !atomic_inc_not_zero(&best->refcount))
>  		best = NULL;
>  	rcu_read_unlock();

Although this is a valid fix the approach could be improved. The for-loop 
should check whether the counter can be increased. Otherwise we might select a 
best-neighbor that is being purged and end up with no best despite having 
alternatives.

Cheers,
Marek

--nextPart4760456.IrGRreA4ct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSuuidAAoJEFNVTo/uthzANioH/R6JvZcYvbarJ2oOoO7C6mWQ
W+wdzGm9MZmXKKxR6DiMJnCBqfx2bynHmUON5HVBDnrRTa196il2NkTUhy6ICc3P
jlUfhtF9zpcFFWW9pc3WD1SPAFUlBCkOccnjPeJ1abakU6elPGCFlPbKQSa4cDpG
3QdowHB7L/MRRiwJX3Lb7e/T3wEISqapnxHMw+EiSYZlNMO+qwwLVX6OTq2hqvV1
/7i18TkH4jGw5nz5DGoIp/8r6d8HHUIi0svwiI04dAywvU/ihuXuXZAw+0VBr2W8
SpouT8TRLNOnG2QC+Er4e3rhc4IbUe51eJN/lfprdeogPb6B8zNyAPn+w129FEY=
=HPiw
-----END PGP SIGNATURE-----

--nextPart4760456.IrGRreA4ct--

