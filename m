Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Mar 2018 11:24:02 +0100
Message-ID: <6505615.pArebLaVYc@bentobox>
In-Reply-To: <20180313104113.19654-1-linus.luessing@c0d3.blue>
References: <20180313104113.19654-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13347824.0NvrmlaXB5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/2] batman-adv: netlink support for
 DAT and MCAST
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

--nextPart13347824.0NvrmlaXB5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 13. M=E4rz 2018 11:41:11 CET Linus L=FCssing wrote:
> This patchset adds netlink support for dumping DAT cache and multicast
> flags tables.
>=20
>=20
> Changes in v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - renamed netlink attributes:
>   - BATADV_ATTR_DC_ADDRESS   -> BATADV_ATTR_DAT_CACHE_IP4ADDRESS
>   - BATADV_ATTR_DC_HWADDRESS -> BATADV_ATTR_DAT_CACHE_HWADDRESS
>   - BATADV_ATTR_DC_VID       -> BATADV_ATTR_DAT_CACHE_VID
>=20
> Changes in v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> - Added missing includes, "#include <linux/netlink.h>" and
>   "#include <uapi/linux/batman_adv.h>", to distributed-arp-table.c
> - Added missing forward declaration for "struct netlink_callback" to
>   distributed-arp-table.h
> - Changed nla_put_u32() to nla_put_in_addr() for BATADV_ATTR_DC_ADDRESS,
>   removed the then obsolete ntohl() conversion
> - Added missing include, "#include <linux/netlink.h>", to multicast.c
> - Changed nla_put_u8() to nla_put_u32() for BATADV_ATTR_MCAST_FLAGS and
>   BATADV_ATTR_MCAST_FLAGS_PRIV to enhance extensibility

Applied in 0509fc0c..53c58c1e [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/9ae766e912b1bace4e7f3ce=
9960ee8a29ce61dce
    https://git.open-mesh.org/batman-adv.git/commit/9ae766e912b1bace4e7f3ce=
9960ee8a29ce61dce
--nextPart13347824.0NvrmlaXB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqo+EIACgkQXYcKB8Em
e0a88w//cHlo0OFNudk7VXPkw0iL9AlhZJT5JLyIAWwKTbmz+MDXrp5UCUqdE3Q1
kreW40XEmjfFTjuVgN6cBYbSw2pQmzwc9USstqybMMHO/rhG0IhBVwn79/keC45s
lB+IOmERDZcML1Si3hCiMMWlygRaTyH4ltfL4gtZ1meqgItzLy/brSo/xTzDNcqA
XFEtkUruxYT6CnbU9GRiw4QuD3dKRhEfCuMjBMAfJdHSiLn43z1bx/p/cW4e/UTs
Idax3e2w2uhm9ALn1H/yh4RMwqhJI+yShqjMSYiYPYJb6FdoSja4rVOQmeHMjBXH
sMd9qaVXGIsqkme5BfXnyRyLeWhQENrHSsTNfRA8sKmKem337tsV55Dekyw3CdrB
8CwmdSr9xomKAEOpOhVI4dPBjMzPfXtEQGLHK+NSUiQxvkhwUP9/q/bYCaTLQsRY
pE+KwyL7afTdn66bRucBeXjWV5Jztue9T4HWnbuqVUgNFxOZOwFpwUrCBb3HIo4P
VwRI9wofMC3lGaz9g2eLOEpCBQTpMT3CxIeqWv4LBkcgcE9Z/Yj88XTa6546cdMm
jB2P2WC9zjgZko4HzVo253vsRgUiDeCqvgH8JXWeU70BqmBvHpBPoYw3SL4OMdpT
WeLI8RWJ4dzw3Fvdqker9WJTfG8W+dd0BlqBLJbziBXH7BkX310=
=4CnJ
-----END PGP SIGNATURE-----

--nextPart13347824.0NvrmlaXB5--

