Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 May 2016 19:31:01 +0800
Message-ID: <2772485.VzmroEUk53@voltaire>
In-Reply-To: <1462874769-5077-5-git-send-email-a@unstable.cc>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
 <1462874769-5077-5-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10305185.XJEXmcfkxy";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 5/5] batman-adv: B.A.T.M.A.N. V -
	implement GW selection logic
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

--nextPart10305185.XJEXmcfkxy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 10, 2016 18:06:09 Antonio Quartulli wrote:
> +static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32
> *bw)

> +static struct batadv_gw_node *
> +batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)

Kernel doc ?


> +	struct batadv_gw_node *gw_node, *curr_gw = NULL;
> +	u32 max_bw = 0, bw, threshold;
> +
> +	threshold = atomic_read(&bat_priv->gw.sel_class);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
> +		if (!kref_get_unless_zero(&gw_node->refcount))
> +			continue;
> +
> +		if (batadv_v_gw_throughput_get(gw_node, &bw) < 0)
> +			goto next;
> +
> +		if (curr_gw && (bw <= (max_bw + threshold)))
> +			goto next;
> +
> +		if (curr_gw)
> +			batadv_gw_node_put(curr_gw);
> +
> +		curr_gw = gw_node;
> +		kref_get(&curr_gw->refcount);
> +		max_bw = bw;
> +
> +next:
> +		batadv_gw_node_put(gw_node);
> +	}
> +	rcu_read_unlock();
> +
> +	return curr_gw;
> +}

I don't quite follow the use of 'threshold' in this function. The threshold is 
meant to decide whether the switch to another gateway is worth breaking the 
existing stateful connections. Here, the code is retrieving the best gateway 
of all - no need for the threshold ? Moreover, the threshold might lead to 
unpredictable results. If the threshold is 5 MBit/s and the first gateway in 
the list offers 1 MBit/s while the second offers 5 MBit/s the better gateway 
is never chosen. 


> +static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
> +				    struct batadv_orig_node *curr_gw_orig,
> +				    struct batadv_orig_node *orig_node)

> +/* fails if orig_node has no router */
> +static int batadv_v_gw_write_buffer_text(struct batadv_priv *bat_priv,
> +					 struct seq_file *seq,
> +					 const struct batadv_gw_node *gw_node)

> +static void batadv_v_gw_print(struct batadv_priv *bat_priv,
> +			      struct seq_file *seq)

More room for kernel doc ..


> @@ -387,7 +569,16 @@ static struct batadv_algo_ops batadv_batman_v
> __read_mostly = { */
>  int batadv_v_mesh_init(struct batadv_priv *bat_priv)
>  {
> -	return batadv_v_ogm_init(bat_priv);
> +	int ret = 0;
> +
> +	ret = batadv_v_ogm_init(bat_priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set default throughput difference threshold to 5Mbps */
> +	atomic_set(&bat_priv->gw.sel_class, 50);
> +
> +	return 0;
>  }

There is no need to initial 'ret' if the next line is setting a proper value.
If you moved the atomic_set() above the batadv_v_ogm_init() call most of the 
chachacha would go away.

In batadv_softif_init_late() bat_priv->gw.sel_class is initialized for 
B.A.T.M.A.N. IV. Do you intend to keep it there ? If not, a per-routing 
algorithm init might be cleaner ..  :)

Cheers,
Marek

--nextPart10305185.XJEXmcfkxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNbr1AAoJEFNVTo/uthzAFFgH/i/WIZTvTeBYsKy6+Bcexbdz
YN0FMRT2DxCsd2QAZtwYMq9jw5ZXTdLdT64bE9ZY23nyQoJDgAZUX8rd2aXmv+/v
YKdXXpsdRtoYNY/SIjhebxje60PO2XDWbv3MRjCLew8N7qgzrRlEWKvBt5cHoKy+
Md9KW6t2BK001GFm7tTKnWKDzfN44rPSxOGXohtZjGckuQQHCjW762EOHVYS0VUR
5ixL84wiCHA2OTCjyKn5sjqblf6YplKPnynbGD7lXMGEKvBC+twobQzZ9Q4ksDno
IUQ48UvexTD6BsDkhv1bGi6xdoZFVkjXC3uX1+3cHzu0Wg8XG5ouJ+Ocusi8Q2A=
=owdz
-----END PGP SIGNATURE-----

--nextPart10305185.XJEXmcfkxy--

