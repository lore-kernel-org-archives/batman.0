Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Mar 2018 14:31:33 +0100
Message-ID: <15527769.EVGQFkFgID@bentobox>
In-Reply-To: <9d6e6557-b697-0a4c-10da-fa3339dc2ade@universe-factory.net>
References: <20180318121201.29052-1-sven@narfation.org>
 <6825317.Bh3rAZBzc7@bentobox>
 <9d6e6557-b697-0a4c-10da-fa3339dc2ade@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2436949.9QHkaEK6Td";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix skbuff rcsum on packet
 reroute
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

--nextPart2436949.9QHkaEK6Td
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 19. M=E4rz 2018 14:19:58 CET Matthias Schiffer wrote:
[...]
> Ah, you are right, I got confused. In that case, the patchs looks correct
> to me.

Thanks for the review. It is now applied as fb91b0ef8473. I have also merge=
d=20
it into master to make it easier for you to prepare the cleanup/refactoring=
=20
patches.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/fb91b0ef84738102807e5dd=
7ec0b3565415aff56


--nextPart2436949.9QHkaEK6Td
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqvu7UACgkQXYcKB8Em
e0ZL7Q//RXFyFQomscpW2XpZn8jU1ZwSzcTdX2az8X0hta8Y53/db89cnwcdjMNA
Gk1BLpXX/4O+g6HVzxRY80HETiLymkjpWkEd1wV8g/aWpc8o2CuLO+CzGPuK7ZHS
uSUKbhTZC3T3UfxFr9blT2G4H2ROzWcZ0SZnTXCx2XCXuUbvoRxmzljW6g+pfTeU
VESfBUUWNKKUbxlZBo85LZOLKPsCJ5jXtd0a+l/vFS3xmNj7QOz8p0dibxzZmEyy
ioEdUyWgfgHsqFgdNogU4hTThGfE/4f1Qi1ljh/jrqn0yWwkMQdYixrXBAG5E9UY
cyMw2NZjzAFFx85UiQC/2PSWTWVq8ollXOPq4sOwDyPhvxcllK3K75LNs5e8wkib
BriGAuwyTJKZ4JVjxpDg+4hYF8ChUjVjvbFZZCrHWhunGxXy2nscp4DbBk3apPPp
9T96jCnfIhR2lZYt1bAr0W3tU8G6RmjRIs5sHwgZajIQVCJqD3OxvbukRw4qXSM8
sAYO9I8gHSDgH/ouhM27Ki3bVxSyhp/pYnekqZDqp48Ihgx0gAPpsQjVjpK5fgS4
iogcY7zt47Mnz5bxHATBDNUtcEQr6sR/kYyJTo/Kq/kxCVywqAUCs+m2u0IlbZDl
dkcJq6SLLXwiGaG/37mUJ6fOIiE464c9IloQKnXiFmxc9sm+jkk=
=GQj3
-----END PGP SIGNATURE-----

--nextPart2436949.9QHkaEK6Td--

