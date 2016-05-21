Return-Path: <a@unstable.cc>
Date: Sat, 21 May 2016 21:09:20 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160521130920.GB12056@prodigo.lan>
References: <20160521121614.23779-1-a@unstable.cc>
 <6311894.ZRre2EmoLd@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gHypzss5dW8YUwgb"
Content-Disposition: inline
In-Reply-To: <6311894.ZRre2EmoLd@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: B.A.T.M.A.N. V - implement
 hard-iface init function
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


--gHypzss5dW8YUwgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 21, 2016 at 02:39:49PM +0200, Sven Eckelmann wrote:
> On Saturday 21 May 2016 20:16:14 Antonio Quartulli wrote:
> > Some fields in the hard-interface data structure are specific to the
> > B.A.T.M.A.N. V protocol and have to be initialized only when such
> > protocol is compiled in.
> > Instead of having a #ifdef block in the middle of the hard-interface.c
> > code it is better to have an algorithm private function that hides the
> > precompiler logic in its own header file (like other functions).
> >=20
> > Fixes: ffd2f27908e5 ("batman-adv: Only init ELP tweaking options when
> > BATMAN_V is enabled") Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> >=20
> > Changes from v1:
> > - move bat_algo.h include line to the right location
> >=20
> > Changes from v2:
> > - rebased on top of newest master to fix compile error.
> >=20
> >=20
> >  net/batman-adv/bat_v.c          | 14 ++++++++++++++
> >  net/batman-adv/bat_v.h          |  5 +++++
> >  net/batman-adv/hard-interface.c | 10 ++--------
> >  3 files changed, 21 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> > index e4a91cd..81157a3 100644
> > --- a/net/batman-adv/bat_v.c
> > +++ b/net/batman-adv/bat_v.c
> > @@ -334,6 +334,20 @@ static struct batadv_algo_ops batadv_batman_v
> > __read_mostly =3D { };
> >=20
> >  /**
> > + * batadv_v_hardif_init - initialize the algorithm specific fields in =
the
> > + *  hard-interface object
> > + * @hard_iface: the hard-interface to initialize
> > + */
> > +void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
> > +{
> > +	/* enable link throughput auto-detection by setting the throughput
> > +	 * override to zero
> > +	 */
> > +	atomic_set(&hard_iface->bat_v.throughput_override, 0);
> > +	atomic_set(&hard_iface->bat_v.elp_interval, 500);
> > +}
> > +
> > +/**
> >   * batadv_v_mesh_init - initialize the B.A.T.M.A.N. V private resource=
s for
> > a *  mesh
> >   * @bat_priv: the object representing the mesh interface to initialise
>=20
> This seems to be the first use of atomic functions in this file. Can you=
=20
> please add "#include <linux/atomic.h>" to have the atomic_set functions=
=20
> defined.

Right!, will send v4

Cheers,


--=20
Antonio Quartulli

--gHypzss5dW8YUwgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQF4AAAoJEJ4aZjxxc6bKCVUQAK/GQEnzM3ztwtsF+XdtN0j/
UuS80OM/qS/LEm4DCaH8e25ikJ/VQY7AJKp4vkw+/bEuB6loxLMqx4JRhWzAm8xD
mChMY6Jxmv/LPBpEiFfyjpEKsP7fbQ6ZoOEw73UlMZV6AL/ny0m4Nl3egRL0uLCp
pvr1nH9UrYExTuxPjEJpjqVDSy6GdWWDM9S7Fo230/W/28zgwUM7SPlUroBQnVUQ
UtC6oFKxfyGgivPtHHfVuv8/6l/rMcuV+aGA9pZg8w7uFeniK9U1lpU9fQ/oYBQx
AGwUdObwmN4d6MHK0vT7lr5NKZZpMdHlHVZJz/oLEE/Y1q5JRatHOgF0JpApO8L9
zBk1Q0vNzPY/935qPFz0rk/C76fXzHRrKxBg/081A7iVnoheZXd0BKiVfZvGCgLK
o62+W4Xw9Iz2it4g/0bfRARiGtWJcXMO5cEoHIFxwMaU40LENJ8eCxPIHtKB2iyo
qqW8295+YzlaVrQ2hLVQjc608hscwd2cekLA0kkck5+snGtmmKO3D38+R+NyBQAg
KSlfKWNy8aWr40ZzRd9DC/CoTerPtdQegZquSPymE2sjeiJLEeK5fJaFDr6mSwC5
gDFtMsAB8UaW0ISTSN22yXWXPE5ZZ8CxRSTD37egTKYCUsyddYY7bRhaz0ccSxXu
naVVtB1Tpo077Qulnim+
=wfz/
-----END PGP SIGNATURE-----

--gHypzss5dW8YUwgb--
