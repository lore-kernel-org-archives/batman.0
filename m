Return-Path: <ordex@autistici.org>
Date: Sun, 3 Mar 2013 22:01:15 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130303210115.GA1400@ritirata.org>
References: <1362332076-27516-1-git-send-email-ordex@autistici.org>
 <201303040147.05547.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <201303040147.05547.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix old master freeing
 operation
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 01:47:05 +0800, Marek Lindner wrote:
> On Monday, March 04, 2013 01:34:36 Antonio Quartulli wrote:
> > +       if (master && master->netdev_ops->ndo_del_slave) {
> > +               ret =3D master->netdev_ops->ndo_del_slave(master,
> > +                                                       hard_iface->net=
_dev
> > );
>=20
> Aren't we going to have compat trouble with this one ?

Yes. Kernels before 2.6.39 do not have the ndo_del_slave() op.
We need a way to make this code compatible..

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRM7obAAoJEADl0hg6qKeOEM0P/2fGsBjpbHzCcehkPPYNQZGW
6C9g3HlytAGbUN3KAcI2jEWCD+aSHbIKMyqdg+E5skfAZTfFl5eUEbLIO3ba2m2/
Wp4MWvnJz6JsHdO27SVaDequcetbVNhCDv1IR0QtAvrB2t3+7qOxLZ3vZEI/lhXA
rjto77HA0PJRdBRg7RWy97aUPKwtLUXKh24uJ+kfyO3HF75NMlsh3eigliLo+Cuz
QXxiJbrNTbi2qfhqXe5yY0MGsaAjX7X20fyZo0Eg04itcEt0i4g5lbsUFRFYudX1
6Uxp0BYqfuJ/aJDrL2drV20A+JIrD2oEDWq4YtOn63VmGnQR5TlL/1Ll8fI5WYC7
p7TsZKDopgfv256n8xyzMXH0SwdYtZfLzVf4tKJbbmgemWry3SHQuA3MwMpLPxMy
FdGQPRJQg7mJNAyMp233h5WccX36Nmptm2Nqj8XGxNH4u2aATqm+TTa6opruiI5o
xM6CljzaFcrMfKbcu7rHrYNSuofFfuukkE2HBfjIdnU+I0txaMCxVlGrA1qilaQg
bTmrEbpKwDRtgQzliSG84F54Ju9wL8L5L1yjAygQfvjAKXkIaijXvAIyMcMN2lVT
Av4tgOemZP86qNVeMEG51wArhXCzbVmOd2GQWSln9n3Zm0+aGm6cZLsh59POTj5k
YodvjqsHASafCGUy6e8s
=44BJ
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
