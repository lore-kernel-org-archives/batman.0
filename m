Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 May 2016 19:07:52 +0800
Message-ID: <2870286.TlxMuhjIas@voltaire>
In-Reply-To: <1462874769-5077-4-git-send-email-a@unstable.cc>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
 <1462874769-5077-4-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6280949.jvob7lOR1C";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/5] batman-adv: make GW election code
	protocol specific
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

--nextPart6280949.jvob7lOR1C
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 10, 2016 18:06:08 Antonio Quartulli wrote:
> +static struct batadv_gw_node *
> +batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)

> +static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
> +				     struct batadv_orig_node *curr_gw_orig,
> +				     struct batadv_orig_node *orig_node)

> +/* fails if orig_node has no router */
> +static int batadv_iv_gw_write_buffer_text(struct batadv_priv *bat_priv,
> +					  struct seq_file *seq,
> +					  const struct batadv_gw_node *gw_node)

> +static void batadv_iv_gw_print(struct batadv_priv *bat_priv,
> +			       struct seq_file *seq)

How about some kernel doc ?  :)


> +211,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv) if
> (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr_gw) goto out;
> 
> -	next_gw = batadv_gw_get_best_gw_node(bat_priv);
> +	next_gw = bat_priv->algo_ops->gw.get_best_gw_node(bat_priv);

Either make the gw.get_best_gw_node() ops mandatory or check for its existence 
before using it.


> @@ -1320,11 +1320,21 @@ struct batadv_algo_orig_ops {
> 
>   * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
>   * @store_sel_class: parse and stores a new GW selection class
>   * @show_sel_class: prints the current GW selection class
> 
> + * @get_best_gw_node: select the best GW from the list of available nodes
> + * @is_eligible: check if a newly discovered GW is a potential candidate
> for
> + *  the election as best GW
> + * @print: print the gateway table (optional)
> 
>   */

Shall we mark all optional ops as optional or .. ?

Cheers,
Marek

--nextPart6280949.jvob7lOR1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNbWIAAoJEFNVTo/uthzA2OEIAK389uDaoon5rrkCL20HFja7
me9xE6feJVuCtkYCnrWIgz8YCOcsQiVVvTV4UbFaKyK3mC+0t9V/omt4K2x/NW56
OomeM8zA7e7JU89aZBGuA39PWrYwaq0cttteQxYXSKCdEtu5Q89gMiPha9nQ08P5
52NvFlk0Gu4qDLWj9oE9I8WZL4jExOH6StrIGWlTXhdvw7hWxL1bXL9zm+3Z+EOO
Ff/OWQW4PQDqXKgrYalbswCW7+cFTeCr9t1ac0gBvPcOOqvh7B/7wJ+1Ewz68HBg
1KuE/f3FKBnXL/iisb80mykt5B6/FnS2snv8vESaUTH6Vg5Y6n7J7IRAGzWI4EU=
=Tl8F
-----END PGP SIGNATURE-----

--nextPart6280949.jvob7lOR1C--

