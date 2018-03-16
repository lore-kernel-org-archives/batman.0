Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Mar 2018 12:31:48 +0100
Message-ID: <2175630.YCghfT8Scc@bentobox>
In-Reply-To: <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1828658.0htrMTpeYU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify
 batadv packet header before pulling it
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

--nextPart1828658.0htrMTpeYU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 11:29:11 CET Matthias Schiffer wrote:
> batadv_check_unicast_ttvn() may modify the batadv header, leading to
> checksum errors in the following processing of the packet.
>=20
> Rather than fixing up the checksum, simply pull the batadv header before
> modifying it (and push it back in case the packet is rerouted).
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

=46ixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")

Kind regards,
	Sven

--nextPart1828658.0htrMTpeYU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqrqyQACgkQXYcKB8Em
e0Zdeg/9Gs7GG/qw9hY/WMG93RKXT5DbKKo2e/3/A8m50S9zJ8/WX0tas6YnArOE
sHlylx/EYJmCwB4Wu3xSE+1kOgqNtoz/ZTfdO2Siu5ruzUj5SPED7w34HssgOP4C
TsurdRN7bQacnN55PYi7gZrakGaZj0RUOlSp4mfH1CM5Vp8i96uxWbWGDt/5jbmQ
pWO3z6Cv9sN1ofNhfsLJ1hiVnMrcKY1JDPt8nRbW8Z/czQSWh1V777akMOEsaD6v
e0JuztZcJMz43D5e/mAoWckDycHfKEt0wJflYuCryNGlpzPMJfRey56UHOAU9zOI
rKmOemIB1IquTfKyUtrePYDJZpCBAFmVi9+qp6WC6ZkIfT9E77mBGnU0Thc9tZXA
823purVz0mDpfp4WwvxVnacaLlLKv8ZY2TY+mNBHsuAkznYvR9W8IGfHy4GH14Vr
eDdV81GhqV09SLN6JGmYjOv9N493tS2jrZrzLXYAcLH2WDjJxyt6/m9Sysglu+Zd
x5Ij8YJ2DVl7r+a1Lzy1qLyC3sLGLVPTM0tWoqSaYItmvH/Huc8rREd8BieW0RTA
Cr9IqERzd6Ar8AOPIy1amf3tg7frFWRYwR9FrXJ/k8itOK0Nb/z5iysybfG332qY
A4cKXu01Eejjv+zxAwDdfGJKNYpBLXdCtDK9PLMkJZgymw2WkjU=
=uiTS
-----END PGP SIGNATURE-----

--nextPart1828658.0htrMTpeYU--

