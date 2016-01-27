Return-Path: <a@unstable.cc>
Date: Wed, 27 Jan 2016 18:44:18 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160127104418.GC13408@prodigo>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
 <1988230.TvXLEl4ULW@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <1988230.TvXLEl4ULW@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
 in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 11:13:53AM +0100, Sven Eckelmann wrote:
> > Additionally, veth devices come in pairs and they are each others
> > parents. Don't infinitely recurse in this situation.
>=20
> Can we have this part as extra patch so Antonio can ask David for a stabl=
e=20
> backport?

good idea!


--=20
Antonio Quartulli

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWqJ+CAAoJENpFlCjNi1MR+pgP/jfQy0PwOAfWUVszu8R48t+g
5mcoQxY6S7yZD2o+O0ujI5FkJ2qhNKhxx6rkPPoUX/yx3lisZC7tao51SpWihHWW
HWy+nVUBDjyDP+2ysON2WwFk5gUMfCmBeGakiFgHDIyVQPqxHl7bdYn3dOUOORpu
2/KBqUBVk00tJfuYHFQsT0yJF58Ny8QsvoIF+tNBK6HWsddM4YI5pUS89pW/8k5W
I8SP0+yZLQS7NN+97G8QB8ct9LXft/9oUp74ExUGivvCdx5VZb6Pm3mQwUOLNt2E
8D+AS7j7IwO1Ag0Sl6DrappozgcC+DAmjz/WnIfPdLGGyNTOoRiNCrOXtzrj7YMn
n2709vgMB6K+F2GjJRqICEkx4QdOvNz9MIofXRgLL/iXTUfpVZKzukMkWxv5eX2c
s22k2C4Bhb2HSQr9uR6nZKq9HaHjj+vJEF4upgr2p/rMUzMAYI019AvIexLbKpe5
tKq09P0z7+Pi1X5P1+3AbEd1KkQE0lnWcl6Uvf5ls9RQItuEO8G+1DElt9eQv37a
+DPHxVnpIEFs1UOWcWXLBv4wWY2SuFY4Nkom4Wn/zasVHPlGu5uk9BAGLY8m4nBI
+5Eglk1kiSQVACAncmHFCjmT3Brsdb3EHdFllrhHMNkBC3fGNQzms5FMezrDfw20
T9wWv6/izaaeXpi5cwoJ
=zEXi
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
