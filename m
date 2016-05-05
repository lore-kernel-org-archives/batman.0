Return-Path: <a@unstable.cc>
Date: Thu, 5 May 2016 22:47:27 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160505144727.GO11201@prodigo.lan>
References: <1457775018-16546-1-git-send-email-sven@narfation.org>
 <2831615.2xmdSus33c@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="07UuamFNDT4U/3KT"
Content-Disposition: inline
In-Reply-To: <2831615.2xmdSus33c@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: use static string for
 table headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--07UuamFNDT4U/3KT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 12:04:06AM +0800, Marek Lindner wrote:
> On Saturday, March 12, 2016 10:30:18 Sven Eckelmann wrote:
> > From: Antonio Quartulli <a@unstable.cc>
> >=20
> > Use a static string when showing table headers rather then
> > a nonsense parametric one with fixed arguments.
> >=20
> > It is easier to grep and it does not need to be recomputed
> > at runtime each time.
> >=20
> > Reported-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > [sven@narfation.org: fix conflicts with current version]
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > v3:
> >  - workaround checkpatch error (over 80 chars) caused by __stringify
> > v2:
> >  - rebased patch
> >  - added new static strings in bat_v.c and bat_iv_ogm.c
> >=20
> > Patch was resurrected from https://patchwork.open-mesh.org/patch/3599/
> >=20
> > I've requested an rebased version at
> > https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014637.html
> > but done it myself because it was rather trivial.
> > ---
> >  net/batman-adv/bat_iv_ogm.c            | 8 +++-----
> >  net/batman-adv/bat_v.c                 | 9 ++++-----
> >  net/batman-adv/bridge_loop_avoidance.c | 7 +++----
> >  net/batman-adv/distributed-arp-table.c | 4 ++--
> >  net/batman-adv/translation-table.c     | 9 ++++-----
> >  5 files changed, 16 insertions(+), 21 deletions(-)
>=20
> Applied in revision f7be1df.

The Gateway table was missed here ..

Cheers,


--=20
Antonio Quartulli

--07UuamFNDT4U/3KT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJXK1z/AAoJEJ4aZjxxc6bKyrQP91J9qaJ3ep8V+Z0dfys9sqD8
sgd8BRrv1KrWZMui+UT1l7kIJXzJiTgwcXOZUIafcknWRPNhOETBv0W02oyq+joZ
guxAaruskYl7weFAb2S8oOeF6t0Syr2QZ2YSyy2GhmGmiOm7hIdGuHF2EYHAWOdX
nEPKS9O6In3fHTzvZ/694XjgVQTRKsF762oPOYg16HH3JNu1N8PuwyM4viz5rhmk
ATeElciGC/Ybvv3lBhLaAEa0CqiC/uD0HU+47KIzI2hosMymorwHkZh8pFs8WbXn
21upb+nfkMCMtcpwCGqyqqz/01Ufx4U4LEgYIlmcoofhrlyzK6ZT4ND1VORWz4s2
5F4nBBV+BSIAvZcA4z/OaFkbylNxasxVTfk0AqHosGOUIWR4yjKmYLKHCLBsYLmZ
45FOHErNRCgXHokiM/jj+sin1nb7djqxHHpHAIiC/mTtNIQmN22hnI4s44jRPVdl
SO/SMYWFLrIR3dVrTRDQu4rNDZUOiYXffw3C+oHgAszt4G2Pa/WEUn4lBcgEzk3x
txwM3APcAvnQu16zB3m7Ji0qDHlrnvBQ15PtFKpx2hJKg9KHAl+gp7vIyhWAcV9e
gIWgsedK8dlPF0PASl+Ya+RATw0BfTpXyCjOKLqUpAD4m4YOSatFX1I+yEJiOh1d
DL1LPhSVAK3+Vd3q9lQ=
=F6Ww
-----END PGP SIGNATURE-----

--07UuamFNDT4U/3KT--
