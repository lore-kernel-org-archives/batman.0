Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Mar 2018 12:31:51 +0100
Message-ID: <3119700.ohP9Qt40a2@bentobox>
In-Reply-To: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2448147.rkRksKyGAy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/3] batman-adv: update data
 pointers after skb_cow()
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

--nextPart2448147.rkRksKyGAy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 11:29:09 CET Matthias Schiffer wrote:
> batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
> must be (re)set after calling it. The ethhdr variable is dropped
> altogether.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

=46ixes: 78fc6bbe0aca ("batman-adv: add UNICAST_4ADDR packet type")

Kind regards,
	Sven
--nextPart2448147.rkRksKyGAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqrqygACgkQXYcKB8Em
e0bjHhAAkN7hEajyeIAF/tw6LTZJk1s8PGNMEER8SWNUgvcdVmeHfbJ1rfrmuste
iIgNqU/8SIA8NBUgmbKIpUGnR+xkzUYJlelBAop38kGBBzdwgs09KZhNPls4oXcM
Nw9zF3YU27TnvRq4YGLCUxpQQsYX6bLEZTZ1MvfNsQQG1l9YKf2d7hcBXV44K8UD
cN3fpqxys6vweE4C0svet5Zu6qcf6tj3jrErM/qEgWNlP7GqPEnTOZMpzt2neaMe
57QuZeKOQE7IAdrl/QBhZ9+nUMJlN8Fq2w5fwl99sOpWEP6dtfsqvqqKlgVymJwe
rOGS87RkEu+EBg2V0m8r2jeQSmt77/DWXy13XhWB2Yloqtcutv1BjQgbk4mD2FOC
/t1ao8UYaV4N2+ycc4Ozr+lZkZRpTQHZjobm00xc6upQcIXf4Fx+fMsMIWZV2kP2
iBOR3qs2/30uR1iWCoN7iNvmB6RU2qZXkQ/mJty6+JpIhG/xAj9BdbmqnbCoc4Ae
W+edKgMx9h0azCBLt/K1yF333JKx43KeOliwAf46A81W5er2xr7ZCpP/OlvkyAxB
stUQsaXr32cjS+NBxeHXSLC+epI0knj6IjiRv2A2abphWo2ormvqmuy8Kwl65oDx
7FBqBCIXvO75ldZn+UY0zI+4+IOblji1fxCq3jrFTGi/k3XRYWU=
=ACXI
-----END PGP SIGNATURE-----

--nextPart2448147.rkRksKyGAy--

