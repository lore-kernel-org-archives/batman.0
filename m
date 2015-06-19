Return-Path: <antonio@meshcoding.com>
Message-ID: <5583D639.2070403@meshcoding.com>
Date: Fri, 19 Jun 2015 10:43:37 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434698174-8899-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434698174-8899-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kNqBiSRkKPC3vaCUMEn1JFbTIAkg6lenv"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: fix kernel crash due
 to missing NULL checks
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kNqBiSRkKPC3vaCUMEn1JFbTIAkg6lenv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/06/15 09:16, Marek Lindner wrote:
> batadv_softif_vlan_get() may return NULL which has to be verified
> by the caller.
>=20
> Fixes: 9729d20 ("batman-adv: fix TT VLAN inconsistency on VLAN re-add")=

>=20
> Reported-by: Ryan Thompson <ryan@eero.com>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>



--=20
Antonio Quartulli


--kNqBiSRkKPC3vaCUMEn1JFbTIAkg6lenv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVg9Y8AAoJEOb/4TMchkvfFmAQAJU1io2SN24sX7rHyGdltJGM
t1qMOICzPR+Ow1k+8qCx94l9BUXBx5BQ5FLNMaxWgZYny7YKwYgvmC+K8SAbPwl8
zcuU1VZMY8bMr8k2bg34e2Exj0AbjOY4eRcY+3+QNkzzUvGeu5s+WRoz+ekN60nq
euNW3peTPlSM5ZnP4scKinMCgsZFKXwm70s41v2l8klgmviHj/dWvbNO7snICI9T
YufS+UkANn39u+cZS5pEZiHGhqEY5QywxuMYWWJEG+6CuFfuRLkhkeRRjNUHC2EM
dIewokMUdSP9dnXOaNs+l5ije47dFOg7AnDrCk42xAypuEiygf27wS4OHijKVCU7
xtR0LsLP2L0AKEfl6ufWTREY7zF9UayAlipNSgMN3eu0SkuUQZ9I2vKkXa1xOgtD
8KYAsrurWPbgaSEYNJUJ6qOh3tDCidcvgv4JOWazPuMaFkkNtcrR28W/8YqtJeEv
lu83trLZ2Yco5d7mX/GH6W/E7OIO50VxSElspe7ZZGqEgHHpThzsswgh8FTsGO6g
Y2aRCYcv2MjpOURiYq/qoCfbB6d2t4XM3VpMsaOitPPzK7Yp7qVW9djNL/kRcaXh
TwwukbAE2C65tjiDxLBK5LLVnCaWiUYg1pm8NJHtjs5xgaB37aKMGlVlAtDMuq8U
mSe1aIuMEi8hMcpq5KDh
=y01q
-----END PGP SIGNATURE-----

--kNqBiSRkKPC3vaCUMEn1JFbTIAkg6lenv--
