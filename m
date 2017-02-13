Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Feb 2017 21:51:42 +0100
Message-ID: <4054192.GCnPXVyv3H@sven-edge>
In-Reply-To: <20170213194431.24075-1-linus.luessing@c0d3.blue>
References: <20170213194431.24075-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2579525.XhPotEX4EC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix transmission of
	final, 16th fragment
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

--nextPart2579525.XhPotEX4EC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 13. Februar 2017 20:44:31 CET Linus L=FCssing wrote:
> Trying to split and transmit a unicast packet in 16 parts will fail for
> the final fragment: After having sent the 15th one with a frag_packet.no
> index of 14, we will increase the the index to 15 - and return with an
> error code immediately, even though one more fragment is due for
> transmission and allowed.
>=20
> Fixing this issue by moving the check before incrementing the index.
>=20
> While at it, adding an unlikely(), because the check is actually more of
> an assertion.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> ---
>=20
> Compile time tested only

Seems to make sense. But have to talk with Simon how he wants to proceed
with the maint branch regarding the net.git submissions. And we should
add The fixes line before committing.

=46ixes: db56e4ecf5c2 ("batman-adv: Fragment and send skbs larger than mtu")
Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart2579525.XhPotEX4EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliiHF4ACgkQXYcKB8Em
e0bTfw/+P9GQ11ioceeFOEV2zmxzatB8Zwgnqxo6fQXyjF6WFCaGDajLZG/dyg3l
MNZIJr3rsEaFaQHCPB3Fo4KwI8hYViPD8PAIOBhvoRFNHyl7TGpRJx2PYmAImaQU
MZo36o1DRj5KpuTgRobGUD53pTPL0n/2YF30Rh9dELIJ4Dvt4Nyd+P9wkdfq2eJK
0UY4i4KkYoYtkMjJqaaz2gutLcax/wvqSZfz3HLTWnvq6mICRFjzCuGngV58bESb
pyY9yFaiuzGSkxn32mBlAcsOoIa/LTd0oaYCayh++qScRK+/dWETi+b/hOHb3/cq
mQuBbkVzdw+wgbOFykC+/6V+QClk9ZSO9luq0XD7TCJCqO74pxWavon0/D0MK0tu
OPAzEcKIqlGhrcE/DhI4p0NbmUNJJP3jbBcWxxBK5pox/EhzVhFDb7ofqLZMpg3O
fhR0/4ZtKmeFSxDgSOqJCdWE3nwDN5ibai3t0P1B9KRtp6oUO//1n/RGW0EFcByK
EVK/3A695NHJRyLayd8VqDHnhVbAVFrkZYdvwX9+oEjC+R25VZSEyItfGTry1tq/
vn5Rq9z5fFv63yrNUXg0Q27LJnPXeTzwqMl8e9nEfU6uXRtWkLh4jJlZ/X+JXEnY
D2/wubv1QAVQqhMzn54+5cbfOE80BkQO5tzuhQkWNQXfYloufVQ=
=86Or
-----END PGP SIGNATURE-----

--nextPart2579525.XhPotEX4EC--

