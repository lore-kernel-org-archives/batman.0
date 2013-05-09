Return-Path: <ordex@autistici.org>
Date: Thu, 9 May 2013 18:45:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130509164504.GG1415@ritirata.org>
References: <1368109687-3780-1-git-send-email-ordex@autistici.org>
 <201305100009.11734.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <201305100009.11734.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 1/2] batman-adv: use VLAN_VID_MASK
 instead of BATADV_VID_MASK
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


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2013 at 12:09:11AM +0800, Marek Lindner wrote:
> On Thursday, May 09, 2013 22:28:06 Antonio Quartulli wrote:
> > --- a/main.h
> > +++ b/main.h
> > @@ -172,8 +172,6 @@ enum batadv_vlan_flags {
> >         BATADV_VLAN_HAS_TAG     =3D BIT(15),
> >  };
> > =20
> > -/* mask needed to extract the vlan ID (12bits) from a 16bits variable =
*/
> > -#define BATADV_VID_MASK        0x0FFF
> >  #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
> >                                (int)(vid & BATADV_VID_MASK) : -1)
>=20
> The last user should remove the define otherwise the code won't compile.

oh, ok, will send v2 with the patches in the other order.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRi9KQAAoJEADl0hg6qKeOBQIP/31vHdBY5w+b5oZIxJOw2OGB
yUmew3YS7Bju0cAgeMcXag0KwZpFYI/7mmV79/U1bOer63cb7SuSxEkWJL+m4Xg5
hHNBuyk8kvLYQsCmSSNISn6ivheC913G3fWFu/QHQw08AP+uN3Ydu3MNSYzSGksj
yEjHHQ0es+6C9SYWqDy6PzZJMrLIri0IVBAzOh9vvIzIicoAvi924hfydTC8La4m
WO/ZXsKQhG8BKP8+dL39gt2FtkU6Ds2+ZwPAhPusKjz3qJy3GH4ak7Tb6JPsbCEB
CVOYDP96MpI/AaNYtXgeaZAJs2zVrOpW/ghCoxNeB3itD8Lb9ry15rJbmnELerlC
XJ4IYdT1BjZlXWEZ3KpKiItu3OufPNSWlUFlmG6f8aPbD0dZ9bocGFYkLRZQA54X
1x0/WK/dq2sreT+EpyNteqQKi5Od3CINUWFcYCLFV80lwTpRUXI7u1ccWNB3D0Xq
7Tjzmrw9sVEJDXuzvUopPTsjAIN4r6lKctSuX955Q3Tg7Q8wGChKS7bm6gKAGGov
i1kSmEH2Nes2HpVy2gH+/YpanW2thJwkJA3IK6PIFvqf4ZNRACLak411OseW/Nzw
7GIG+I1Oa1elrf0Iow8wr+IAMVGFuwEJLDjF0XzgZaVbuSxJSWcAh9J9YrAw1vuZ
XdYALMYh9AE3Hs4ELhUA
=7sKu
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
