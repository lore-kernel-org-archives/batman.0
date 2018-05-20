Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 May 2018 06:37:21 +0200
Message-ID: <5340933.XQBlgCQxlx@sven-edge>
In-Reply-To: <2078208.hARaRF5Zct@bentobox>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20180327154307.GA2052@otheros> <2078208.hARaRF5Zct@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6698954.2g2zx72Qyh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, netdev@vger.kernel.org, davem@davemloft.net

--nextPart6698954.2g2zx72Qyh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Jiri,

seems like you still haven't answered Linus' question.

On Montag, 7. Mai 2018 08:34:16 CEST Sven Eckelmann wrote:
> On Dienstag, 27. M=E4rz 2018 17:43:08 CEST Linus L=FCssing wrote:
> > On Sat, Oct 29, 2016 at 12:56:28PM +0200, Jiri Pirko wrote:
> > > >> I strongly believe it is a huge mistake to use sysfs for things li=
ke
> > > >> this. This should be done via generic netlink api.
> > > >
> > > >This doesn't change the problem that it is already that way. This pa=
tch
> > > >only adds the list of available files to the README.
> > >=20
> > > Sure. Just found out you did it like that. Therefore I commented. I
> > > suggest to rework the api to use genl entirely.
> >=20
> > Hi Jiri,
> >=20
> > Thanks for sharing your thoughts!
> >=20
> > Could you explain a bit more on which disadvantages you see in
> > the usage of sysfs here?
>=20
> Linus is asking because of following patch:=20
> https://patchwork.open-mesh.org/patch/17340/

The next patch with a similar problem would be=20
https://patchwork.open-mesh.org/patch/17372/. It is rather important that y=
ou=20
are discussing this with Linus Luessing and Marek Lindner.

Kind regards,
	Sven

--nextPart6698954.2g2zx72Qyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsA+4EACgkQXYcKB8Em
e0ZbHw//XcZBDMnzI6dnm/6J3h1JCiuODW26ahM/NZ6yD+ws3J8zBFc2SIjdsFyQ
qM+JXvmRS8OwXO0XofJg6XG4G1OefsUEE8+M6DbcOpCs8yG3BNFZn9T+sv8wZzSj
YgAkr7O7pwEUxK67dOCkgUBRcOHCqh51he/WU+9WZYJLqqQy9nsR6INBlnfw70xP
r+JFlw/MvRChUTerTevHe7HeoER8yhD8h3+08877JRuNu8t9tu+zafze3bX1UKjx
e1Ql3WjAh7yuu+Ins6+RSMzFOSNEOORh6ALWa0L68O+X9BTGwC6KrVUr695kr0s5
FF3DgnbCe5QM4S0m7DtkigFjmxYjUtOJAguGc4GnBbL1K1QCNxi7+9Wy4FyADW7N
ZD1O647OV5kbRyjEaE4WP6SP+ZvsV80XyFzAnrjZxVGnVhYy6bM/JcJ6tUPt5HEU
ZvummgNiCjtAwukba3RunxurxPKvfVU63K6jjlM2Qzgf0eL2iMSKQuNw4NHgnYAY
7LZh9HuF5Z7SyKvQKAArUNxD4vNSTu/jAKMzfNAzq3EaOZtMDzWBoSID54iV7pQD
crg8OPFOo4vewuFD21DaAnbXaC6gQMK4C6ywtteQ1Jn34lzDgK9iC5oubcwYguXj
9u9IzvggaF6PAfB2tK7dYy14AXbS4TE9Q/ls1myKYslAW5aiass=
=iEqT
-----END PGP SIGNATURE-----

--nextPart6698954.2g2zx72Qyh--



