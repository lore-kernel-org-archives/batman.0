Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 Jun 2012 23:23:17 +0200
Message-ID: <4571338.XsGMM8NbvX@sven-laptop.home.narfation.org>
In-Reply-To: <1340740822-4516-2-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2875820.6qm9y5Jyni";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: add reference counting
	for type batadv_tt_orig_list_entry
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


--nextPart2875820.6qm9y5Jyni
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 26 June 2012 22:00:18 Antonio Quartulli wrote:
> diff --git a/translation-table.c b/translation-table.c
> index 245cc9a..0f02514 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -152,9 +152,12 @@ static void batadv_tt_orig_list_entry_free_rcu(struct
> rcu_head *rcu) static void
>  batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry
> *orig_entry) {
> -	/* to avoid race conditions, immediately decrease the tt counter */
> -	atomic_dec(&orig_entry->orig_node->tt_size);
> -	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
> +	if (atomic_dec_and_test(&orig_entry->refcount)) {
> +		/* to avoid race conditions, immediately decrease the tt counter
> +		 */
> +		atomic_dec(&orig_entry->orig_node->tt_size);
> +		call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
> +	}
>  }

You can just invert the atomic_dec_and_test and use a return to avoid the 
weird comment.

[...]
>  static void batadv_tt_local_event(struct batadv_priv *bat_priv,
> @@ -639,12 +642,17 @@ batadv_tt_global_entry_has_orig(const struct
> batadv_tt_global_entry *entry, rcu_read_lock();
>  	head = &entry->orig_list;
>  	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
> -		if (tmp_orig_entry->orig_node == orig_node) {
> +		if (tmp_orig_entry->orig_node != orig_node)
> +			continue;
> +		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
> +			continue;
> +
>  			found = true;
> +			batadv_tt_orig_list_entry_free_ref(tmp_orig_entry);
>  			break;
> -		}
>  	}
>  	rcu_read_unlock();

Please fix the indentation in this patch and not in the later ones.

Kind regards,
	Sven
--nextPart2875820.6qm9y5Jyni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP6ihFAAoJEF2HCgfBJntGvU0P/R7iIwqqqLhqi61bK/X6DhJ2
MsogYYXVstQaBa8i3SoMQ/JKh9J8gsB9tBGo3CySre9fz27ts/kOAlwQb4UqTK1q
QtttakEwe69iMPzXqRBPQ9ZfuMe9dpC4GgG6ZTKX/Klqu2rho/npSDiwh2gCRzj0
wTIMxbzZrrHuz7LAB6Q2Egk/bN1GwO82mHmY4hhIOtoZMxvcxN9f9X6jc8HXfpND
+s4jLcx899uqDQ7k67xXr1ka7B077xKPgWiLdvevhGzIFljCtcmHuWOAeYNgoT7i
yUd5TGuvAkLKIMqkXnjKbm7pLslrPTSaJo5gap4ySYleDAQxD+7kuG/8vdnugyjo
NH1XtMWpfNoSH9pS+lGPfSqEMyoCAa+EEL/Dp6lI4V3gxaHz99CHHBDYI9vOD82P
eE0cfcJL9F7ZxSRiSKWaAIWdFxaOX3Vz3LYxybysQm4UsBFsOFyO3Ta9cRI1ZBsJ
GlxusIbjD9rkInRxCoq61SI1O6d/VG1bJFUV/WAWFBOCgHUipHZuDnueuAAf5U9p
CIpQwSPs38MyrBPl3KKDVzV0ceDBHhD7y/KpEcGyr29XNIKbFuRcYGiY37nTx7MO
+CTw6n91Qa2OYW/1HIyYMPuPTfiLNUu5zJen5XVmgvrYK6Pe1tCyEG3A+zh7LCMV
sFuNz8Dd/rnRmuGvQFPF
=tihX
-----END PGP SIGNATURE-----

--nextPart2875820.6qm9y5Jyni--

