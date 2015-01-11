Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 18:38:17 +0800
Message-ID: <13038168.FmPfxN5Dug@diderot>
In-Reply-To: <1419594103-10928-4-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-4-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1809575.7HNrFF0m4u";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 03/26] batman-adv: iv_ogm,
	Reduce code duplication
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1809575.7HNrFF0m4u
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:20 Markus Pargmann wrote:
> +static int batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
> +                                   struct batadv_hard_iface *if_outgoing1,
> +                                   struct batadv_neigh_node *neigh2,
> +                                   struct batadv_hard_iface *if_outgoing2,
> +                                   int *diff)
>  {
>         struct batadv_neigh_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
>         uint8_t tq1, tq2;
> -       int diff;
> +       int ret;

In the success case 'ret' is never initialized or set to any specific value.
We do lack kernel doc for the newly created function 
'batadv_iv_ogm_neigh_diff'.

Cheers,
Marek

--nextPart1809575.7HNrFF0m4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUslKZAAoJEFNVTo/uthzAK00H/RhyfmGwLqB0y5B6rHS/hO/a
WBgPniJ2+YZI9B0+8xrLx0yPxf97tvklcKS9WzIfAQ4uoiqvCoMojZZ942PzxyCm
nmoL17zyYPWFOXXqC6uZ3c8mf0FK60HF1U0kbQKdMXYrjjjGpuuxUjQNU5CV3Irx
jcn4iHLSKTpTYdPUdoe7uZAoBgiGeu3EMUN03BNypOGO2wpLFepuhYTN1DIXLrPH
zbmmPl3H7K5g32Jw7XwqmuZsoL+lO+ix5eVZ8t3WBFcS3v2e1+V6xl0l1E8W6/1S
vrQb7NubVp5UP2hpN4SXOc2q+K8AAno9Z7GHoobAYed0JiGPUs1k64uwrleIAqk=
=1E4w
-----END PGP SIGNATURE-----

--nextPart1809575.7HNrFF0m4u--

