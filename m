Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 7 Jun 2011 18:06:53 +0200
References: <BANLkTimU4iHxK0CY=-kede2yehwf9wM3fA@mail.gmail.com>
	<201106071450.34123.sven@narfation.org>
	<BANLkTimEcKsGF7-2sn6NL=cEByrfWQUUZw@mail.gmail.com>
In-Reply-To: <BANLkTimEcKsGF7-2sn6NL=cEByrfWQUUZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1529063.NHTeNTPGSW";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106071806.54498.sven@narfation.org>
Subject: [B.A.T.M.A.N.] customize batman-adv for a new dashboard (was: Marek
	Linder)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: micheldegeofroy@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

--nextPart1529063.NHTeNTPGSW
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Michel de Geofroy wrote:
> Hi Sven, Marek, All
>=20
> First thanks for the feedback really appreciated,  I  actually dont know =
if
> it is Batman or the Robin script that we would need to customize or both
> not being a programmer its hard for me to tell...

I try to help. batman-adv can be understood as layer above the data link la=
yer=20
and below the network layer. When you don't need to get the discovery or=20
routing/path finding algorithms to be changed then your actual target isn't=
=20
batman-adv.

> At present the dashboard we have developed supports Olsr Robin and we wou=
ld
> like to also support Batman Robin unfortunately Antonio is very occupied
> developing another firmware called Mesh Root and as far as I understand t=
he
> development of Batman Robin is at a standstill.
>=20
> To answer your comment:
>=20
> "Why should batman-adv be customized for a dashboard? Shouldn't be the
> dashboard customized for batman-adv?"
>=20
> Maybe Batman already has it all and it is just a question of updating the
> robin script I have no idea :( but I know I need someone who dose
> understand and is able to provide the right kind of support for the
> firmware.

I don't see any kind of requirement for batman-adv in this mail - so I can'=
t=20
tell.

> We are NOT looking for proprietary firmware even though we are ready
> to finance a firmware that would function with our dashboard but would st=
ay
> open source.

batman-adv and batmand are not some kind of firmware, but daemons/kernel-
modules for neighbor discovery/path finding in already established link lay=
er=20
connections.

> I am not even sure we are knocking on the right door since as far as I
> understand Robin is more like a script.

Never touched it - so I can't exactly specify what ROBIN is.

> Being new to Batman any help appreciated
>=20
> Some Features needed
>=20
> 1. Connect to Alien AP as Client.
> 2. Enable to test connection speed from the gateway to the dashboard
> (similar to repeaters)
> 3. Support for N and 5ghz
> 4. Branding
> 5. Robin Batman Adv Firmware Update

All those topics aren't batman-adv related topics, but related to the=20
firmware/helper scripts. I know that Marek is working on a complete=20
environment (hw, firmware, helper utilities, dashboard, ...). But I would=20
guess that you will only get some promo material for the open-mesh.com ng=20
firmware....

Kind regards,
	Sven

--nextPart1529063.NHTeNTPGSW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN7kydAAoJEF2HCgfBJntGJXAP/3dG5iPnPt18gj9gQDWJYlLd
hMMZeM9KM0VqmPUYOFrTrNvMJ7tgZDSKfZJpaymSqcGkY0+zb50tFIYWpW0cy+zE
y+/IeZFmR8wcAjEIIGtBnFnEoxTSRyKeR6YkSUMN/kgWtjd9RS8AJMtVcgPulRFK
dqOivZSpR6wMuDEGL32lh9Rw1FZozesmPDKUt/5xB1waH7LYiK6SLEsHtDyqLaiT
sG0aDBi6JdBKDvj/bbTx/+tDeWwBo0w6ijiQBqCIw2Tm0EszvPy/wlZFJPJ4h0g9
EQCD40Bn22nEZy7GfYGVn16OmUvnD/aFKfimzUfO/+QQ6Wc3dJI5oJ6fcnj77w3f
YJK/QP5i7BK0OmaS7ue7AloT0wBV55vkV+YmXa6xrSHyoVNOBy7KloM+HRy5f2hQ
sBMqTg90+zgUXj+uafKGgFGVuHj/GVxNk0tr7QdFQ/gOeOFLmmyxpfOIU7p4EqE4
0vkOx+TS6lDbwnqiAmH9Hg6gpIrkCYGamqxVan+oFTuKNy8IcKvM8uym71tBoFIr
RrqhWSqpiSlic1WEy8Wa5UsLXasZohHgkBYs/PCZw+5ENFJ0dlQJhuLY5X9RBCoT
O2C13o+jpoqGSOfyTIYGymgwaOPr4/OqK8o1s5i2TK2uY5KVMs4Zdlh7G+p/u63t
LBiwZB4AcmNGaLpemnZB
=ppTy
-----END PGP SIGNATURE-----

--nextPart1529063.NHTeNTPGSW--
