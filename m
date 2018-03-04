Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 18:15:57 +0100
Message-ID: <3781180.yC8v9ux37Y@sven-edge>
In-Reply-To: <20180304140408.7015-1-linus.luessing@c0d3.blue>
References: <20180304140408.7015-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1751204.8irNP708TB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Avoid redundant multicast
 TT entries
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

--nextPart1751204.8irNP708TB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 4. M=E4rz 2018 15:04:08 CET Linus L=FCssing wrote:
> +static bool batadv_mcast_addr_is_ipv4(const u8 *addr)
> +{
> +       const unsigned char prefix[] =3D {0x01, 0x00, 0x5E};

This should most likely be

  static const u8 prefix[] =3D {0x01, 0x00, 0x5E};

[...]
> + */
> +static bool batadv_mcast_addr_is_ipv6(const u8 *addr)
> +{
> +       const unsigned char prefix[] =3D {0x33, 0x33};

This should most likely be

  static const u8 prefix[] =3D {0x33, 0x33};

Kind regards,
	Sven


--nextPart1751204.8irNP708TB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqcKc0ACgkQXYcKB8Em
e0ZGIxAAhKYGhgdh8b6GKpvKdGx3xVQBOzDitHX3Uk/llNnZ8/NEReKcUQUww303
eWrv+dogyGAOkZ1IOJu1Pv3go7etnoMFrfsSg2kUYIK1isZB7qg6PCZuj1JtdACA
FWyu8xhw5m1ENrKzIsCNG14pY+p2eXHx9lA/meeuPOTyPw37zuYOn4QbF4Yn3vDn
wCgv8BiEtKj2z8fRSl4SEUuuGv42aEu4zenY0fXPwoHvYD5VU0Xtz4HlCvW24bcA
qC+zHPe7nF3HcfrmolULdZTGjkKe8MFTr5nL/hPW8du3tmyiIN/0OtvNNURkqA4k
upOfMo3q/KJLr+tjpEAM12S/EmkW4BoLnxDeEg+SKD54P5vgFHuABGMOP4H+E8At
q1JtqslQYRRq9ujh5fXH29hpImmKxgxkw7dA3OzkPny+PJhtLARcFZjHNgYZBqhW
MHgPrPMYcwasdJtGaAFmTi614Fmo+tWS4tuQw9F1yve2Tbnk8LvpgK6u5iKv9L7O
FawZrtwV5HwmRoADV5mFEY8JtXbwtkDRx50Q+5ver7L9wyVfjlywJQ9IYA9+Q3xt
0LHgDR1yuAgmh2jDFo0y1MnU7pQP99ro67cPDs0Ob6pQxWYHhUnbUo/NVuJhKxv1
jTAPJqAo2wlgktthLy2NYGbkZJ6vbvOFXkHcRdRKbpXEEDZPPQk=
=+zMf
-----END PGP SIGNATURE-----

--nextPart1751204.8irNP708TB--

