Return-Path: <ordex@autistici.org>
Date: Sat, 30 Mar 2013 14:10:30 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130330131029.GB4024@ritirata.org>
References: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
 <1363495498-17830-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <1363495498-17830-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix rcu_barrier() miss
 due to double call_rcu() in TT code
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


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2013 at 05:44:57AM +0100, Linus L=C3=BCssing wrote:
> rcu_barrier() only waits for the currently scheduled rcu functions
> to finish - it won't wait for any function scheduled via another
> call_rcu() within an rcu scheduled function.
>=20
> Unfortunately our batadv_tt_orig_list_entry_free_ref() does just that,
> via a batadv_orig_node_free_ref() call, leading to our rcu_barrier()
> call potentially missing such a batadv_orig_node_free_ref().
>=20
> This patch fixes this issue by calling the batadv_orig_node_free_rcu()
> directly from the rcu callback, removing the unnecessary, additional
> call_rcu() layer here.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
>=20
> diff --git a/originator.c b/originator.c
> index 585e684..013c7d0 100644
> --- a/originator.c
> +++ b/originator.c
> @@ -117,7 +117,7 @@ out:
>  	return neigh_node;
>  }
> =20
> -static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
> +void batadv_orig_node_free_rcu(struct rcu_head *rcu)
>  {
>  	struct hlist_node *node_tmp;
>  	struct batadv_neigh_node *neigh_node, *tmp_neigh_node;
> diff --git a/originator.h b/originator.h
> index 7df48fa..4f9f88b 100644
> --- a/originator.h
> +++ b/originator.h
> @@ -25,6 +25,7 @@
>  int batadv_originator_init(struct batadv_priv *bat_priv);
>  void batadv_originator_free(struct batadv_priv *bat_priv);
>  void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
> +void batadv_orig_node_free_rcu(struct rcu_head *rcu);
>  void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
>  struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_pr=
iv,
>  					      const uint8_t *addr);
> diff --git a/translation-table.c b/translation-table.c
> index 9322320..ee91cc1 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -144,7 +144,10 @@ static void batadv_tt_orig_list_entry_free_rcu(struc=
t rcu_head *rcu)
>  	struct batadv_tt_orig_list_entry *orig_entry;
> =20
>  	orig_entry =3D container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
> -	batadv_orig_node_free_ref(orig_entry->orig_node);
> +
> +	if (atomic_dec_and_test(&orig_entry->orig_node->refcount))
> +		batadv_orig_node_free_rcu(&orig_entry->orig_node->rcu);
> +
>  	kfree(orig_entry);
>  }

Hi Linus,

I was just re-reading this patch: the code can be beautified later (I think=
 it
would be worth defining a new function, e.g. batadv_orig_node_free(orig_nod=
e),
which can then be invoked both in batadv_orig_node_free_rcu() and here - in=
 this
way we avoid to export batadv_orig_node_free_rcu() which should remain priv=
ate
to the originator.c module and we avoid this forced fake rcu invocation), b=
ut I
think that putting a comment here to explain why we don't invoke call_rcu is
definitely needed. In the future somebody else may ask why we don't use it =
and
will try to re-add it.

The rest looks good.

Thanks!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRVuRFAAoJEADl0hg6qKeOQJsP/iqoVV/ycRevIA5KkoJS6Xrp
K2YSnosfkSkKUx0tTrEJkPT4Rwj/Poiqo2w8Db+sDUV6603I1rFNzMjci6Av99iW
kloaMtnRKzI3vot2z84PpJTI8jg516Wb4SBNm5kz3QzgXq+rhwceigZnjYPYUX7b
VzeZa2fI9YkqCfQRe5W1ReF+YEOlNRRG9tPEgSqMGOPvVmMRmuHFCotTkFFMQsOu
Y7G5Y9e4m52qZ7cXnRkYx1YJvyI9PBBbCPMjyatSgL+1lTQhgRwSbHyxBQs08fw9
+dhtVCDDBQqKmbWGJ+m5WP0PeSQ4Po90BfvbfafVs42pE/ohTcQdzlD5EKiOzGvH
isZhME63Ed7t6qJExEkHuhVpS29XIr2mrP+Jac4UFRI2ys29zlLboIW1IJSyFM2M
7EYVc3vvrCFTY7KOIZQ4PhL3Q41+0IRSr1CgbjWn8MVdudlKybr9JzKzUlUVvkxo
kbkLm6Sj9XVLxqA6jzq9Ws6YMF9xwZdqPBKuRWPq3K4PPj+blZ2oj+J0gXQKURx/
ULJn7CTkMy4AuRpxdzkUYlD7WXD9Q7N1PTtJYAILF880tgOdgfSdciZpKCOoiMIZ
Rr0OfxZre81xYu2+YXv+V318SxhM01XJcgKO2Dq8NnXa3UxOgqOM8OGwBEaovZ9T
/xLCugBP/5X/GlLPjh32
=khQc
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
