Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 13:45:04 +0200
Message-ID: <4761670.Z7ajXcAPkg@bentobox>
In-Reply-To: <20160612041426.26339-4-a@unstable.cc>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-4-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2084648.qMvX1tQyX1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2084648.qMvX1tQyX1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> +static void batadv_v_gw_print(struct batadv_priv *bat_priv,
> +                             struct seq_file *seq)
> +{
> +       struct batadv_gw_node *gw_node;
> +       int gw_count = 0;
> +
> +       seq_printf(seq,
> +                  "      Gateway        ( throughput)           Nexthop [outgoingIF]: advertised uplink bandwidth\n");

Maybe you wanted to use seq_puts here. At least you've used it in
similar changes.

Kind regards,
	Sven

--nextPart2084648.qMvX1tQyX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXpzAAAoJEF2HCgfBJntG7isP/iNgTxYzZJDp9YYfhS9ZEGFW
uanrS5m+bXwMSTbtWzsyL+lV4lkHLJlDgzZ0F4n0TRsIvxhqlM6RUPba5MTFEmEB
uitey8fIxrgwNcf1zNMlE7NxtLq29TScnuk2FTwGPdcm7XgeBDIEmDfigLbVnPxL
Kcd/QKmWnKr3GWrMA+Znrbi0miljRjnwzgWlkHPPy8wmOSGZFNCxagsoYK4a80sg
5V5I2aWyCx5hTKj4/yLyL6uF74+vw0BPqooabIT3RTdsbmtSXCZ+p76rs791AgDc
NLssTXfqJWW5zv5wK/kXeNtRO8vd+BhLNgiBw3dhZC8fBIUohJgryKD4OlBKS1wI
2uajb4RZTiySKkbL2lJAyxl/a6Wma4E/SJJXLaZpF48MjiVTZ/UPU23ybfCfAKTw
AdBQCxoRL9N12HifTy9rAiLAcg1SSQqdtfvxuuwk/qOiVrXol9nMpBX4DKFoUGpC
A96v9BvkX+/x0yHinWRbpvLxDet2k45z4FG4ddTsgpxyZ0t1WnxDAojF0lWYrEEi
i+kmCe3Nu7tD8Zo1k65r4ohw4gWNUROYPsg35Z7wPVn/VjEa5paGbQcVnPHWJP9F
l7IYbBFpnj1tzbLbdpZY8tSmIdaNmAjAe367q1OH8DFhrfP6Dvk6apgS9s1BYLWB
/Q7RWrQCn3z1fx5p0ida
=YxV7
-----END PGP SIGNATURE-----

--nextPart2084648.qMvX1tQyX1--

