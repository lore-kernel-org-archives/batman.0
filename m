Return-Path: <ordex@autistici.org>
Date: Wed, 5 Dec 2012 13:05:55 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121205120555.GG27828@ritirata.org>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch> <6578542.D9nnFXgRvc@bentobox>
 <20121205113927.GF26922@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kra4tWuoVJHqwr45"
Content-Disposition: inline
In-Reply-To: <20121205113927.GF26922@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--Kra4tWuoVJHqwr45
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2012 at 12:39:27PM +0100, Andrew Lunn wrote:
> > The biggest different is the "lets install a whole kernel to test this =
change"=20
> > methodology ;)
>=20
> Yes, i generally do that, test a whole kernel, not a module. But...
>=20
> > Usually (please correct me) batman-adv is developed outside the kernel =
because=20
> > it is easier to test stuff and it worked till now. No one of us wants t=
o port=20
> > the latest OpenWrt to the -rc kernel to test stuff ;)
>=20
> Do you actually need to port to OpenWrt?
>=20
> How i work is build a kernel, with everything i need built in. No
> modules. Then tftpboot the kernel, and use the rootfs from the
> disk. Why not do the same with OpenWrt?
>=20
> > > It seems like the biggest problem is the late feedback from David
> > > S. Miller, et al, about patches. Getting this feedback earlier in the
> > > life of a patchset would easy people lives.
> >=20
> > Partly, David switches horses relative often. So an early feedback is n=
ot as=20
> > valuable as it sounds.
>=20
> O.K. I've not paid enough attention to his comments to know this.
>=20
> > > For Marvell work, we post all our patches to the linux arm kernel
> > > list, where the ARM maintainers will see the patches. All patches go
> > > there, in all stages of their life, from early RFCs, to patches we
> > > want the upstream maintainers to take in a following pull request.
> > > Thus there is the possibility to get early feedback from the upstream
> > > maintainers and avoid most last minutes surprises.
> > >=20
> > > So maybe it would be good to stop using BATMAN mailing list for
> > > patches and instead use netdev. Or at least CC: netdev.
> >=20
> > I'll tried it in the netdev_alloc/standard interface patchset but I got=
 only a=20
> > surprised "where is the pull request?" reply.
>=20
> Humm, interesting. Is that maybe because BATMAN only ever sends pull
> requests to the list?

I think the main reason for this reply is that David was directly CCed.
I think we got no feedbacks because we are not used to send patches over
netdev "asking" for them.

However, if you look at all the other network "subtrees", everybody just se=
nds
pull requests only. I think patches against "subtrees" are rarely sent to
netdev for feedback.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Kra4tWuoVJHqwr45
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvzijAAoJEADl0hg6qKeOLk8P/R9qO5wHor1/iUVGq0ZAQFD8
MakdNQG6IvCQj45E+ASRKCquWeJZq8fKXtImywQ3zg38mYBWzuRXJMIxbP9TAWHE
vEPwYglxZ9xE+71sZeJSSwtqxJwZfSn534H8BD9XMrgl4gtOMLpzn0rR4lXbeuhj
fdFdCEFr2PBkApRl9xvhHPE7224iVFSS/odxmf7KXfppH2qG4nWPyG5E45QVKGCz
r75Qk1KpbXuZxRY4ZnRe7RawFihH0Qk7GAJxmpOnBdfwK+vgrz5o5eaGGT9ZSa+q
qcdifJad4J6i230WE/y0/uMUnTQIEjinX6agOi8FEiMpHiw0sTBR45SZPJULc+8G
nrag/G0enyddyFZcgPMSe8K9qfB0rTKlNLmY6dCzKgQ4fCotAGLyCwtmxhqSG+C0
P/3+GLtAt0VUPiSF8JGtUyM3yh6ABbdD1ZCEwhXgkzuHrrJUGLJd2BODuNK9kqs4
s72ZghFak9mkGlhL7odglpcpqc/9Kf057Y09t5lCX+iw8LpDIct25J2wd9uWIehp
B0CSoAfCFjZC1bAJqncaqscZ76DrrbMXOjk9UdLsqm9U2FRV704WjQdfkBBnS5c/
7C9tHFFpsb4DUaISybgyOhTisypW8bcZYD0Q7aDqFvYnW/L/05eO3kC/tJOc4HpT
akOCnWV75fyTRY0OuMTB
=c4gP
-----END PGP SIGNATURE-----

--Kra4tWuoVJHqwr45--
