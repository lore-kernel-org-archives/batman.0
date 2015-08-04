Return-Path: <antonio@meshcoding.com>
References: <1438720693-30590-1-git-send-email-sven@narfation.org>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55C12313.5040700@meshcoding.com>
Date: Tue, 4 Aug 2015 22:39:47 +0200
MIME-Version: 1.0
In-Reply-To: <1438720693-30590-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1d7b83rXUFwOTmFAjfjwSJ5leqXfO0roH"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add lower layer header
 length to headroom
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1d7b83rXUFwOTmFAjfjwSJ5leqXfO0roH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/08/15 22:38, Sven Eckelmann wrote:
> The maximum of hard_header_len and needed_headroom of all slave interfa=
ces
> of a batman-adv device must be used to define the batman-adv device
> headroom/header_len. This is required to avoid too small headroom probl=
ems
> when these slave devices try to send the encapsulated packet.
>=20
> The batman-adv therefore uses:
>=20
> 	needed_headroom =3D max(0, dev[0].needed_headroom, ...,
> 			      dev[n].needed_headroom)
> 	hard_header_len =3D max(ETH_HLEN, dev[0].hard_header_len, ...,
> 			      dev[n].hard_header_len) + ETH_HLEN +
> 			  max(sizeof(batadv_*cast_packet))
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--1d7b83rXUFwOTmFAjfjwSJ5leqXfO0roH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVwSMXAAoJEOb/4TMchkvf1mIQAMUdh0Ma82/DIdAX1XS8Tex5
Gcg4zqLRZWyFpKOfqBu1+CpYSC3CKdbyW/SDRqzsWmsTZ6u6pRzl2s80I+WvQk3L
jzbwf97GaOWzSN/NLkR1L6COWGV2aapMkiRXAejsy9jMumRx134eRWjgOUuUV5FW
pcwgFcFcNDX9f0dQ7eZExQcaPS0SyqiyzlTz81+qHULFVelUUuXr5wTtGg2UW42Q
M4N7v7kzaEfdmWxbDxrvc490IbaTP/UJGwWuIF5/fDmeyJPafMkqJxjAS7Pizvcc
oQt8sZCP38j/IrKyT+qDK4CZKFygCm5b10ufoqyNPGqwo+ywzYAwVk3Z94DCbIMg
vCA6I14eMC96JLW2z1G2N/Blj49Y2GWwyfyVCyWUuQ7dvfa3SsDxLvfH3GJQ26jd
T1S57BY0eT3QyZjIdCoDC0CizSaadW48Slo5ZUv0+646vZZIl4I79lnavNEBTiI6
TX9A6kNyY+d3QnToIfASc7zeUQqu/1LXtUcLl7DHxcXm+1COQjjp+8J9wmxruzUg
NiO75bXeJ/90paT1GfT7vtVXk4oxot5v/bR82yh0qDms5pWn9y/NE1hYXqri9nGc
gPSlWxMNLQSQFwGDLiz43Oum1IBPonFIMZ+XFm6t/lScUIvTazMEMwtTHtazpFqR
bQHglChLkU9dbTUEIsey
=GNhL
-----END PGP SIGNATURE-----

--1d7b83rXUFwOTmFAjfjwSJ5leqXfO0roH--
