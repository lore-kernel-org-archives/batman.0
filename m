Return-Path: <antonio@meshcoding.com>
Message-ID: <52A6C6AF.90004@meshcoding.com>
Date: Tue, 10 Dec 2013 08:45:51 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1386661454-3036-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1386661454-3036-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RqT6Lm0HsvhxdpGigLIS5TWbXNv1J0H8M"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batadv: Slight optimization of
	batadv_compare_eth
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
Cc: Joe Perches <joe@perches.com>, Antonio Quartulli <antonio@meshcoding.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RqT6Lm0HsvhxdpGigLIS5TWbXNv1J0H8M
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/12/13 08:44, Antonio Quartulli wrote:
> Use the newly added generic routine ether_addr_equal_unaligned
> to test if possibly unaligned to u16 Ethernet addresses are equal.
>=20
> This slightly improves comparison time for systems with
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Joe,

this is just a re-send of your patch for inclusion in our development
repo. Sorry for the noise :-)


Cheers,


--=20
Antonio Quartulli


--RqT6Lm0HsvhxdpGigLIS5TWbXNv1J0H8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSpsa4AAoJEEKTMo6mOh1VEDAP/RaNP8583WEIAA6oI7mptQ6S
bFYMpyCwe10oOCGp+67hxZwt49jeS46O8fQ3s/SrQP4BDwUCbjz2ELOp8OSPZd/9
1pLw8l6CEz0GuB7uM0/b7T/OSdb25f+AiwL8IsaiiCjQAv4V6PrfRlXO2GvrRDYF
mpsVDeCLGc8XxFmUEKMXj6Kb3xZGmiS7siVWbhIjNKIt9Ce8jyJInST1Xp3kGRE0
jrjz6S/sIautY6oCQTNQjm7nBo90QoesojroYeoclI8xKgFBxAwqEp9qZgpZgLqz
OiMA+Wem6orXilG4ymhuwMuxVXnC7vL423MYR3B0BhlcS3kv3bF5Y0KcOuXlGeZv
BlO7LnKAbW1trfmJx60XOe4akkiZLn2QFBvpbo3n50Q8nBe+wEpsAqtoRAGiCWmR
JSFpI3X0umc3wBXg6oiPVa0MRZZ8Ca3gN/ZQxc/lynNdU7tXtxDK1J7XhV4FZsiz
fdDELQozwGJDP71E3+NEqnMW6PNDUaZDGPOrLFRhKu3R0XmqQcimbNJ9QM9fVk4M
TKbTdtvcupFZRKAVrO9RWkfzkUCO+083DbIL3MIPOIpMBGECEgOyWJgOz3mFKRqF
sVrGSmUADZp6/+yE4xUufxMVukM23nFN/1u+aHogdrVlGr+CAs3XFqeVYVIxpfLs
7qQ7PW7xTbW3v3ZEE4Gz
=t58J
-----END PGP SIGNATURE-----

--RqT6Lm0HsvhxdpGigLIS5TWbXNv1J0H8M--
