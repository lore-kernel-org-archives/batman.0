Return-Path: <antonio@meshcoding.com>
Message-ID: <547A22FD.2010105@meshcoding.com>
Date: Sat, 29 Nov 2014 20:48:13 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
 <547A217A.9070209@meshcoding.com> <20141129194632.GA27289@pengutronix.de>
In-Reply-To: <20141129194632.GA27289@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WccriTwA6TiNWTgx7dqiAjsDrmBchHDt0"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Kconfig,
	Add missing DEBUG_FS dependency
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
To: Markus Pargmann <mpa@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WccriTwA6TiNWTgx7dqiAjsDrmBchHDt0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/11/14 20:46, Markus Pargmann wrote:
>>> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
>>> index 11660a3aab5a..c6fc8f756c9a 100644
>>> --- a/net/batman-adv/Kconfig
>>> +++ b/net/batman-adv/Kconfig
>>> @@ -62,6 +62,7 @@ config BATMAN_ADV_MCAST
>>>  config BATMAN_ADV_DEBUG
>>>  	bool "B.A.T.M.A.N. debugging"
>>>  	depends on BATMAN_ADV
>>> +	depends on DEBUG_FS
>>
>> What if somebody does not want to bloat the kernel with debug_fs but
>> still wants to run batman-adv? (i.e. on a very constrained embedded un=
it)
>>
>> With this patch this would not be possible anymore..
>=20
> It is still possible, it just adds a dependency for BATMAN_ADV_DEBUG,
> the log which holds the verbose information. This is exported in debug
> fs as far as I could see, so it is not usable anyway when DEBUG_FS is
> not enabled as all debugfs function calls will be noops in that case.
>=20

Oh you are right, I thought you added the dependency to the BATMAN_ADV
symbol.

Better not to answer emails on Saturday evening :-)

Cheers,

--=20
Antonio Quartulli


--WccriTwA6TiNWTgx7dqiAjsDrmBchHDt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUeiMHAAoJEJgn97Bh2u9e244P+wX2aG2q6h95ooXHhQHSGPAD
hUv3GOa65UtlhXTCuQm3lJ419i+Mc9mLxXhNPZx7WOR08rE0fZ0S7bqY2Uk+zkjS
B9Q4IApvKq7xa8mS3cBOAVrqypwPOHhpNamFSs6/vTh8KKjvI2z9Bugv33Zxahm2
vx2UZttveKZPVppJSS4ypJo45ScPSR5zZRjIBpijTdMeLpikV4hz9eZybmbNJo7/
N8+tzSQm5kNs/JPJ6lq4qfXhwEEDdwyixOCzIYR5Nuse7jvlOpNOiAKtp5+1fXBS
SBxo1EaFKvWrMGd/sNTa9NOVuuw+2MoibvB3cjtEpfXNPy+hD2Pc+Sc7ES0tQLg/
hEieIoHIXjrtwblfxCXBiVgyPpwqPfDRc8hEw14rFwxIDKoKkZHiLSIZT5XiO5Cs
TQZSP7EQHALn0spF0EWbR4Z8JmV/V0d3eqyQN7WRjZBNYbqnObvl+TaOzzuq8IHh
6KwQ+I7KtYiVPgN2CNfhGjdn4Fo8PNikEeZFk3syE9RKulpslz5shf3y7dIx5jCc
BLyzx9nR7X25ngTEVKqlS82Ewwdskv9K8e+ixbUktnsm9r8zHa7DH4DxYzzRws04
Q7kK63SE09bxxTkyekEO4TqZB1/qqKNFlT8nDX0WULdWuD80Y8UF2VGoVNj2u8YA
tpQroamc5QTCKVvr/v7q
=REtw
-----END PGP SIGNATURE-----

--WccriTwA6TiNWTgx7dqiAjsDrmBchHDt0--
