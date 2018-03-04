Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 21:26:23 +0100
Message-ID: <3354106.Nz8zcFWoPL@sven-edge>
In-Reply-To: <20180304200218.13271-1-linus.luessing@c0d3.blue>
References: <20180304200218.13271-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5495967.DbJGOxneyQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Avoid redundant multicast
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

--nextPart5495967.DbJGOxneyQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 4. M=E4rz 2018 21:02:18 CET Linus L=FCssing wrote:
> If a node signals that it wants all traffic for a specific protocol
> family then there is no need to announce individual multicast addresses
> via TT.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
> v3:
> - use "static const u8 prefix[] =3D" instead of "const unsigned char
>   prefix[] =3D" in function body
> v2:
> - for consistency use "const u8 *addr" instead of "unsigned char *addr"
>   in function header
> - for consistency remove some spaces in arrays
> - use more explicit "memcmp(...) =3D=3D 0" instead of "!memcmp(...)"
> ---
>  net/batman-adv/multicast.c | 56 ++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 52 insertions(+), 4 deletions(-)


Applied in 853834799c29 [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/853834799c29224fc3ec21f=
dbaf343e83de0ed25
--nextPart5495967.DbJGOxneyQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqcVm8ACgkQXYcKB8Em
e0YoqxAAhmvDAiSRtFx4PAWMtR40WTMA3h9ylK/nqPasHyaSvd50ldduMpwp77Cg
nui1YuNtKY9sw0lKN0BANfAwWZhTvOEUB1193BciY0HC4Mf4YVWxyBQI9CcZOXSQ
yUhsjQCSyppZX/m4iZ2Emkl5pYvLlsWBeOXSaT1mA6ydv7NRNadZs3SBugRQUPfX
hpzOYMua+DTEwOvomplAWIeRZp4CfNRWXxYAIyRPaBeHq6kvJuSX2oVBysf54X6K
TyPKGIVxuFPc6xbVMyuOw+Uogyl/IyRcqVLFEIpva7tDC7bh6ZJ8lWQ+O+CLBVx4
2X+/OwqCP6lBFrmnucArCOSdBpAzrjdyqdBvXB8K/7VhLATEw+wyk1iR5MU+Pbri
rquGuiUTRcFGiduyPoI7S9050N5dhVBCdGC7j1d/PwKalmYVWgnqooLWCstmGQt5
OPCo8TphXyYl+vwYLr0+1H5n9t+0YUMn2NFARspjRPG6TvRKlNWublYr3diplE16
hxmdnZarkbkiHtr+SSnU0LImSnCqXgp8sd/YZ5rTjTE9ndsC+AhUwKA1v8lEUhn7
q44oeNbdKWGMdSjgBXf1A0EE/YPpUQQWHeQzPH0ClOGdcN8fMsIng5mAv+Kh1WiQ
/X21CLdZ7qoFCJmGNHmGS84hzx/HsIFwyRcVsh5KcEDhwhnCWU0=
=xZF3
-----END PGP SIGNATURE-----

--nextPart5495967.DbJGOxneyQ--

