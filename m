Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 23:05:30 +0200
Message-ID: <2035271.giVKt6JBZB@sven-edge>
In-Reply-To: <1461875848-11720-6-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-6-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2069783.T8K6VCPLby";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 05/10] batman-adv: netlink: add
	originator and neighbor table queries
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

--nextPart2069783.T8K6VCPLby
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:23 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Add BATADV_CMD_GET_ORIGINATORS and BATADV_CMD_GET_NEIGHBORS commands,
> using handlers bat_orig_dump and bat_neigh_dump in batadv_algo_ops. Will
> always return -EOPNOTSUPP for now, as no implementations exist yet.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
[...]
> @@ -1311,9 +1312,15 @@ struct batadv_algo_ops {
>  		 struct batadv_hard_iface *if_outgoing2);
>  	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
>  	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
> +	void (*bat_neigh_dump)(struct sk_buff *msg, struct netlink_callback *cb,
> +			       struct batadv_priv *priv,
> +			       struct batadv_hard_iface *hard_iface);
>  	/* orig_node handling API */
>  	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
>  			       struct batadv_hard_iface *hard_iface);
> +	void (*bat_orig_dump)(struct sk_buff *msg, struct netlink_callback *cb,
> +			      struct batadv_priv *priv,
> +			      struct batadv_hard_iface *hard_iface);
>  	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
>  	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
>  			       int max_if_num);

Kernel-doc is missing for these two new entries.

Kind regards,
	Sven
--nextPart2069783.T8K6VCPLby
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI8yaAAoJEF2HCgfBJntGtzYQAMcKLJGffuoqL6IfANOW6ePi
iVl9NAetE9xvQsBKDVrGYAiJFi45Fc4VvOJ84/eKg4jFRR8SiOzyeVSW+Ha4fDRq
NKv1E1H6hL4uY3ghTAOGMxi/KHZmgrlgMJNRfv8bd5SyGZE8RxA0svoL0vcXS42o
5geVuAMlTsKRHtVzi0NitHmPY62rbz8G+yLftw5vo+BH6IIIPQUjCwFDSI5gTIn+
icZbhm1blbYZ6u/mrbD5n6ZUPQoq0sGU7+b5Rrpcce9R03mjvC9CNHnCnZECv6VT
aHB3lMxxHREM8XlRonLh4Mvios8wsnTpZ5J/IDVZi1XYkT2Dcs+oWVGznAo8eOxh
hsDLELZq/19jM7tdwQbMACd6KEoBPhYbumfs6Gky28UH3HMxrjYekGTJDuQ04Lk6
+mQsiWgan8grLhr7LU2PrhFGhQuReCcXgyCq+GOK5bq8bblxlVZdwx/Ht8gFkdLY
c6k+P5aZHIHYA0OlnkXiMVUT4ROdzVBVLayfWEYtIjpe+mhHm9ClLA1rc45UQxRl
1R0lZUqm5jCZKFgfxM5NgS0iTEI0cn7gIN35FwgEEZUZ6K0DLswEoLU4Vz1loYlF
wGI1pX8EGiiG6Df7hwZJqgP2pnAf0Aq1oZKFwlu7hLhO0y12nVEhzRrXA9WZG9H7
JcP/hbfQtjQDlU7Qzv30
=InWZ
-----END PGP SIGNATURE-----

--nextPart2069783.T8K6VCPLby--

