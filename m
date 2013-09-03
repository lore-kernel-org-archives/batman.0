Return-Path: <ordex@autistici.org>
Date: Tue, 3 Sep 2013 11:03:15 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130903090315.GG1871@ritirata.org>
References: <1378116909-551-1-git-send-email-ordex@autistici.org>
 <1378116909-551-9-git-send-email-ordex@autistici.org>
 <201309031700.00566.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <201309031700.00566.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 8/9] batman-adv: provide orig_node
 routing API
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


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2013 at 05:00:00PM +0800, Marek Lindner wrote:
> On Monday, September 02, 2013 18:15:08 Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Some operations executed on an orig_node depends on the
> > current routing algorithm being used. To easily make this
> > mechanism routing algorithm agnostic add a orig_node
> > specific API that each algorithm can populate with its own
> > routines.
> >=20
> > Such routines are then invoked by the code when needed,
> > without knowing which routing algorithm is currently in use
> >=20
> > With this patch 3 API functions are added:
> > - orig_free (to free routing depending internal structs)
> > - orig_add_if (to change the inner state of an orig_node
> >   when a new hard interface is added)
> > - orig_del_if (to change the inner state of an orig_node
> >   when an hard interface is removed)
>=20
> Please look into this warning:
>   CC [M]  /home/marek/batman-adv/originator.o
> /home/marek/batman-adv/originator.c:578:12: warning: =E2=80=98batadv_orig=
_node_del_if=E2=80=99 defined but not used [-Wunused-function]

Ops, sorry. During the last rebase I re-introduced batadv_orig_node_del_if(=
) in
originator.c. It should not be there at all.

I'll re-send these two patches.

Thanks,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSJaXSAAoJEADl0hg6qKeO/ScQAMP62diOVYfhaY7WXWwdXDXw
UQsoGqr9CayUhEZpZeYiQcFbr0StwFDKSdE27Z2u5xsuFwf1qYurEAsJX9thx6sz
jiXWD8MkmOYZRKBTTW7McaYZIllxu/V3Ke/Eb2U7JWUwaMfPgoetsHFc9m0JRLZ5
rqRYV33E6FU8/ZSVxDwS3EJd4q8DCGzNTPpate0lJOiia0+BC9tDcJ+fsJAhkwux
J6mOoVI0EXEAganO5JblqBocPvMsENgJSyatkjRJzXQCsO+VjvpRrb3cW9pL7m9k
JAFnG4rkY1VMSaKzH8DbCUvPU076yS2im01YLVzdKqHaHBpBXLEfMynFi/O7Pe3P
QOzUEPjFO3D9xRaPzk8r1WaipDmsW3Wi4rceyrBnlvWcHQJpvDy58O33rk59qqq5
boOPvutIXPOh3/Qg7WWZis/h1HlzkjcR/6JjWKj+We0inNOpU1yWH7gqrbn+AnUp
nJ7xoRlikoIqq7XQ7BzWMZ5HPc6KYH77gbpeIalobHyxp/noREcB4iLPgbgPDw8x
5LyrsUaxskLDx27NGaruhdzETX2s3g53ojxJ0KW813H7IyRrubkCInoAIkCXzO6S
He8VburtWJO+wFG2EtBDojhxlwmJbWhWD4iD3hPwZGNo5Qkus+ZKl1Zes1Gz1wxN
6Zk02lcTDDfM5GId9UJR
=5zvS
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
