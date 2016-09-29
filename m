Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 17:48:24 +0200
Message-ID: <39878029.2fscjNVSQg@sven-edge>
In-Reply-To: <20160920121245.593-4-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1786035.fxEdn79YTx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Evaluate and use
	neighborhood hash TVLV
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

--nextPart1786035.fxEdn79YTx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:45 CEST Linus L=FCssing wrote:
> @@ -1435,6 +1448,10 @@ struct batadv_algo_iface_ops {
>   */
>  struct batadv_algo_neigh_ops {
>         void (*hardif_init)(struct batadv_hardif_neigh_node *neigh);
> +       bool (*hardif_no_broadcast)
> +               (struct batadv_hard_iface *if_outgoing,
> +                struct batadv_hardif_neigh_node *hardif_neigh,
> +                bool inverse_metric);
>         int (*cmp)(struct batadv_neigh_node *neigh1,
>                    struct batadv_hard_iface *if_outgoing1,
>                    struct batadv_neigh_node *neigh2,

Can you shorten hardif_neigh a little bit to avoid this slightly confusing
line break after "hardif_no_broadcast)"? Many tools like checkpatch or
kernel-doc go crazy about it :)

Thanks,
	Sven
--nextPart1786035.fxEdn79YTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TfIAAoJEF2HCgfBJntGQgUQAJ4GrRtvi/r07WBTlXcZcCNd
zM2W8/QSN0dqFSD7FSiuRU3tdmJAPz2AR3eFfFDU0YF7eO3jA/v4xlL60MLHt4Kt
bQXG9PTCpTfF7PjkOynUOQwbmvFFM1AHk7PWnAp5tluIO7VHtrzrWAVWQ1s7Tc+I
wf8Gf7mwh3kIrz8eVPOtnAJZ8cdQWEFfKt6pMjeVcFB7hvQhiNG+2FxBCEVWAI34
BqPKpOuFDpHNJ/c/WnaQ5wMcHpOLhdph1C3LKew5Y1xCpDTkjSROYs//Rsfpxt+u
b++OvtpAhMkVaxup20KWUEgP5hZkVEoV+TU9VQFIQ6D+UjVkek/ZCAvbP+fYlFac
ipyTtyq2xGfqxAMjp/phrCRrCtgXvYW5nD6xZ2t72g1POtWuol3GYyotTMl0FN70
w7+gBTjZdlJK5jaXDHbPogTcVF41OlUnVHzbTm10h0ERRKAiT+qo9DeW/l/C9UNt
wh8TByd16iALKisDo87UZIJtDW/293x0+7PnCUAlk2PETsQeKYtpFkjY4S8Lxcyy
rVhuKwoytoTpuY5n4Z25+Mw1jIxsDyhjXKV7L9TCMN+kllwVOlvIUhll3APTfx+b
hD8LlRrmnGewoep56J2H9mErZ2EkPkLNm6YYxkXytW38yjq4jmog/BxbVLYBLtYo
WfUwwDh4N8tMmsk1vpoK
=HtPy
-----END PGP SIGNATURE-----

--nextPart1786035.fxEdn79YTx--

