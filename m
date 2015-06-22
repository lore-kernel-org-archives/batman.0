Return-Path: <antonio@meshcoding.com>
Message-ID: <55882DC7.5090405@meshcoding.com>
Date: Mon, 22 Jun 2015 17:46:15 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434957203-6939-1-git-send-email-sven@narfation.org>
In-Reply-To: <1434957203-6939-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FwEM4KBiaweQvg7EqmlKcRmcaqjObMi7m"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Replace gw_reselect 64
 bit div with shift
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FwEM4KBiaweQvg7EqmlKcRmcaqjObMi7m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/06/15 09:13, Sven Eckelmann wrote:
> -	gw_divisor =3D BATADV_TQ_LOCAL_WINDOW_SIZE * BATADV_TQ_LOCAL_WINDOW_S=
IZE;
> -	gw_divisor *=3D 64;

Marek can you comment on why this constant was used in this computation?
To me it looks like we only needed a "good enough number" and not a real
reference to the local window size.

The remaining change looks good to me.

If you merge this patch I'll then squash it with the uint64_t change
that we already have and I will re-send the pull request to David.

Thanks,

> -
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
>  		if (gw_node->deleted)
> @@ -167,7 +163,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_=
priv)
>  			tmp_gw_factor =3D tq_avg * tq_avg;
>  			tmp_gw_factor *=3D gw_node->bandwidth_down;
>  			tmp_gw_factor *=3D 100 * 100;
> -			tmp_gw_factor /=3D gw_divisor;
> +			tmp_gw_factor >>=3D 18;
> =20
>  			if ((tmp_gw_factor > max_gw_factor) ||
>  			    ((tmp_gw_factor =3D=3D max_gw_factor) &&
>=20

--=20
Antonio Quartulli


--FwEM4KBiaweQvg7EqmlKcRmcaqjObMi7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViC3LAAoJEOb/4TMchkvfA/oP/Ai6f1eUcOvrMtlWHq2R37Mt
jc7r3AGN7erv3Fa0sDVbEolanoR7xrWIustqo/nCuean4eJwZZ6JLae9tAlvsylY
8we2eeLXcor567aC/+j1TYLBuWyptJiRljXVzGXCF0n1a7GeLNFlS4mkveXYVw5G
AN+LwDS1aSoLWjMCi+WSAgT5grkFiElHdAhWGBSF3ibFTjFzF+GtqIc+7D2u5cAR
u1e+Bz98H8KYvoG/rOGnnngC+c//Y7lscSb0NiYkk9QZbC3ZMhjOEGcdU2rsSoqu
OCvb+OHQX7Cs+s50+XqPJBj0OdtrjNmO1l2VyVj/MFVVBpjl3DQZYAjeXSkPb2Gc
x0UGl6qRRRHKMk/jcPNMJO0Ns2sFZU60r1YpFh9iFtktSyPkMp5HQ5VYmF55kEvC
X/qY0WZIeMQ8HFE5xUZDSm/mO7kr+NzcpkGZmKaUOqc3uioQyQOxPC7kNlSahHQ2
cjUrQ+SlISggl21ujPmd905C0EmKs9UUh1cVwGEANZf32BUB1bTbKyQM0hj0tW3j
2Pt3aacH5i6orWCOcx+7a6XGp5TXIFSGxVdKiO/o5ClAYEMGwGnxiiOEs5YK8Owy
Wrng628NGmbhlkctcXl6OBYm1loekCd2Zfn2uSrLCG5MJHJhjPYE1MXf8Zpy+ROt
jEuLypDSkHnmUTDeDefi
=XuO5
-----END PGP SIGNATURE-----

--FwEM4KBiaweQvg7EqmlKcRmcaqjObMi7m--
