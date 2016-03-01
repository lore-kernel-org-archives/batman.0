Return-Path: <a@unstable.cc>
Date: Wed, 2 Mar 2016 03:18:02 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160301191802.GD7704@prodigo.lan>
References: <2589855.Wxd0lgVuKV@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <2589855.Wxd0lgVuKV@bentobox>
Subject: Re: [B.A.T.M.A.N.] [RFC] EOL of kernels < 3.2 and removal of
 support in batman-adv
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


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 05:54:43PM +0100, Sven Eckelmann wrote:
> Hi,
>=20
> the oldest kernel still supported via linux-stable reached its EOL [1]. I=
t=20
> looks like also the distribution releases with such an old kernel are sta=
rting=20
> to die [2]. So I would propose to first disable the checks for kernels < =
3.2=20
> from the daily build_tests [3]. Then someone would have to change the old=
est=20
> supported kernel in README.external and CHANGELOG. The last step would be=
 to=20
> remove the actual support from the compat files [4,5].
>=20
> This would remove 13 of the ~38 supported kernels. Or to say it with year=
s:=20
> The oldest kernel supported will only be 4 years old and not anymore ~7 y=
ears.
>=20
> Any opinions about that?

Personally I like the idea.

Backporting features to such old kernels gets more and more painful and
sometimes even not feasible at all.
For example, we will never be able to run batman v on old kernels for
this reason.

Another point is that every now and then we get bugs from people trying to =
use
batman-adv on ancient kernels and spending time on those bugs can be really=
 time
consuming..that's why often the solution is "upgrade your kernel". :)

Unless there is somebody who wants to commit on maintaining such old kernel=
s,
I'd agree with Sven in limiting our support to kernels >=3D 3.2.


Cheers,



--=20
Antonio Quartulli

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1erqAAoJENpFlCjNi1MRCvMQAJar2hA32WmP/X+sDn9/lH9T
m3otwQ2Q7jal4xmlP1l5gIKmQOlvrrl/gy0nYDEdPAhhCWtmsXjnUGjlRyvPwKzh
vt//doJRgpAwTzcmuHqU3nTLYf9TTJ9F36ZX7wpo1J4LhiWX84PS7j+RDn9STqMN
eZpft9ghOSiAY/RkQ3U7XbD/NEY0H+upam5IHf4NFs/p7+yR8355ZhZfvbguu/VA
58eCfBmY2bA7QehcHMkBAuRahpODjw2dxrfmcn/xS2E+b2j6dHcJNAZlS3r4BFfX
t2SoMqTjTY5yRQ4jJxifDvPaU8aGY6TaWSjxxbJ2eq4U+nxpucxRGhYmRZjgvu4V
tOCIhquD1aLytU0Uox3qWPcM6tQa8gF6PrRj9L2x9iiqxxfNXPEC40eO3czGl+5p
Qqv51ZFn6HiixqV9XmKvE+EETaRFvkJtFXizJiexMH8ZQuufZn9JRWyBpOy8kfWQ
L0I8KfRDrVhmPmwnKy7m7Qnbpw7y9AJjgcEtwcAdvmDF3f7Uj9E2dzOyYdV2gh+W
17+PhB4NRrqdkXPfrPWhTK920N13bNn5gJiTSTia9IAIBHOWWIOk/xorZrDcFMOJ
pgpAG95u+ksmGsDlNDjZGHzv9+Ge5l/TIrjtPzdVR3JXbAv+h2NE7k1j/Cy9rYC3
gO3MlzNmT9eZMHm49JSW
=CiC6
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
