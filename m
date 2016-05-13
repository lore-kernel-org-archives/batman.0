Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 May 2016 18:44:02 +0800
Message-ID: <1891745.mZd9gkqG93@voltaire>
In-Reply-To: <1462874769-5077-1-git-send-email-a@unstable.cc>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2628204.UoZlcxgvcd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/5] batman-adv: make the GW selection
	class algorithm specific
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

--nextPart2628204.UoZlcxgvcd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 10, 2016 18:06:05 Antonio Quartulli wrote:
> +       return __batadv_store_uint_attr(buff, count, 0, BATADV_TQ_MAX_VALUE,
> +                                       batadv_post_gw_reselect, attr,
> +                                       &bat_priv->gw.sel_class,
> +                                       bat_priv->soft_iface);
> +}

Why are you changing the allowed minimum from '1' to '0' ?


>  /**
> + * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
> + * @bat_store_sel_class: parse and stores a new GW selection class
> + * @bat_show_sel_class: prints the current GW selection class
> + */
> +struct batadv_algo_gw_ops {
> +       ssize_t (*bat_store_sel_class)(struct batadv_priv *bat_priv, char
> *buff, +                                      size_t count);
> +       ssize_t (*bat_show_sel_class)(struct batadv_priv *bat_priv, char
> *buff); +};

No need to introduce the 'bat_' prefix if the next patch removes it.


Cheers,
Marek
--nextPart2628204.UoZlcxgvcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNa/yAAoJEFNVTo/uthzAVmEH/jA0B82CAb0OH7yNOoSuYrGY
rCQ/aq4JTv2cixrrLGAOrHOZK46863cIFJHsREqUqos9ixh+nZvBbhZ/SvPxYa+S
jlqkH6GofehfKBOKxTGRmWGLiT4PhVcRE61gkT/vb5EUuZfhoDBY91iTyIP9gglX
47Wepo6L9SI5LQ+WfGdFchFUoNiBrd3LNJTdsqRKHd24MvFCAnAZu7z55urHV1Gh
IMl3OWZiEfipdy5ROwuD1n3aTochsG0TzoBu9Mp1mY55zU02Urx4oZeC3Fz7zYVg
0658qJv2bdbl+Yemgjf5AkAqOtHLgpuPF5ybNZ7FwwrACWpwM7/4blGDtHqJ2MM=
=uQ8F
-----END PGP SIGNATURE-----

--nextPart2628204.UoZlcxgvcd--

