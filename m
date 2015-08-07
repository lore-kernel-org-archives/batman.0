Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 08 Aug 2015 00:05:19 +0800
Message-ID: <49623477.gbvZJGeD3Z@voltaire>
In-Reply-To: <1438863412-19471-1-git-send-email-sw@simonwunderlich.de>
References: <1438863412-19471-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1622677.AScJ6xrrWb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: rename equiv/equal or better
	to similar or better
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


--nextPart1622677.AScJ6xrrWb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, August 06, 2015 14:16:52 Simon Wunderlich wrote:
> @@ -1953,7 +1953,7 @@ static struct batadv_algo_ops batadv_batman_iv
> __read_mostly = { .bat_ogm_schedule = batadv_iv_ogm_schedule,
>         .bat_ogm_emit = batadv_iv_ogm_emit,
>         .bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
> -       .bat_neigh_is_equiv_or_better = batadv_iv_ogm_neigh_is_eob,
> +       .bat_neigh_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
>         .bat_orig_print = batadv_iv_ogm_orig_print,
>         .bat_orig_free = batadv_iv_ogm_orig_free,
>         .bat_orig_add_if = batadv_iv_ogm_orig_add_if,

What branch did you base the patch on ? I am unable to apply the patch mostly 
because of this section.

Cheers,
Marek

--nextPart1622677.AScJ6xrrWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVxNdGAAoJEFNVTo/uthzAuqsH/RZb2W6Jt3soLKki4R8/R51o
Nt9HJHE6Uuw2MOkZJH6YXgYzPPKoctq6rgZknab1HDb+YM8EVBQfCfbmJQdjEI7s
ngu88pzRhJpidBS1hm7xhWzyblOYlW1EHu9h5OjOci3XmDQvL7tfbldFELEBOEpj
fJDJhxWNMvLq8oPNuZ+RffSRbSz0LxYIoRznLE6ja2eV3lNYCjbp+dKEdPUNksK/
6s9s6NoHOuq40wjz/b2qK2sm80MRaW4Ut+b1YZda9b4D6zRBOxJDwy5k9/ba4RXa
VxwPE96qEdKtS42u4MkMP1Tnu2ruF2vh5uBjG9a5gApR5gjUZPg9qj2FZgs+Nd4=
=plqq
-----END PGP SIGNATURE-----

--nextPart1622677.AScJ6xrrWb--

