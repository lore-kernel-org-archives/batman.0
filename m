Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Oct 2013 18:55:15 +0800
Message-ID: <2541348.dk7oEX68Hn@diderot>
In-Reply-To: <1381323938-26931-8-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1381323938-26931-8-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3513795.9YiLGVhgLf";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: add debugfs support to
	view multiif tables
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


--nextPart3513795.9YiLGVhgLf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 09 October 2013 15:05:38 Simon Wunderlich wrote:
>  			hlist_for_each_entry_rcu(neigh_node_tmp,
>  						 &orig_node->neigh_list, list) {
> -				neigh_ifinfo = batadv_neigh_node_get_ifinfo(
> -							neigh_node, NULL);
> -				if (!neigh_ifinfo)
> +				n_ifinfo = batadv_neigh_node_get_ifinfo(
> +							neigh_node,
> +							if_outgoing);

Nope ...


> +/**
> + * batadv_originators_open_multiif - handles debugfs output for the
> + *	originators_multiif table
> + * @inode: inode pointer to debugfs file
> + * @file: pointer to the seq_file
> + */

Documentation longer than one line should be indented by one char not 8 
(second line).


> --- a/originator.c
> +++ b/originator.c
> @@ -776,7 +776,49 @@ int batadv_orig_seq_print_text(struct seq_file *seq,
> void *offset) return 0;
>  	}
> 
> -	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq);
> +	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, NULL);
> +
> +	return 0;
> +}
> +
> +/**
> + * batadv_orig_multiif_seq_print_text - writes originator infos for all
> + *	outgoing interfaces
> + * @seq: debugfs table seq_file struct
> + * @offset: not used
> + *
> + * Returns 0
> + */

Same indentation problem here.

Cheers,
Marek

--nextPart3513795.9YiLGVhgLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSbPEWAAoJEFNVTo/uthzAxHMH/RTB90sNITP/izptvfWzpsYO
FxxDLyCb9YKTkA+kZ3JQK/RmcRH8ZsqFfoCG704n5Ead0ty9hsf+jer8fRLY3DAO
Nc4qUMyIUZN6wunL76ZFKeoItna8Hn2VZPn+y6W+4RPuQu7gUC7gNjiym/CgK5c7
rL2d8s7VG5VW6L6WjR/YilkHHkoA09NfQTN5ePF59+3jnaCCJNR059NAfepJR48f
Wf5J0/qibRCj2NVd0ypuZI57VcoKlZbEVASOa16rC2GEke0ov1OVhV5x6hT3dUyJ
BqrZBQmpGP7DFqkQR/+6/p+AbKUFDdNHSNBOQ5X/x32Bp6I5z+4rL2cxDhXNPdo=
=z5Zz
-----END PGP SIGNATURE-----

--nextPart3513795.9YiLGVhgLf--

