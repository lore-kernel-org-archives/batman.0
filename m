Return-Path: <ordex@autistici.org>
Date: Wed, 6 Mar 2013 11:54:23 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130306105423.GI1400@ritirata.org>
References: <1362565981-31117-1-git-send-email-ordex@autistici.org>
 <201303061853.03020.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline
In-Reply-To: <201303061853.03020.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: invoke post_func only if
 the attribute has been changed
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


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2013 at 06:53:02PM +0800, Marek Lindner wrote:
> On Wednesday, March 06, 2013 18:33:00 Antonio Quartulli wrote:
> > @@ -169,7 +169,7 @@ __batadv_store_bool_attr(char *buff, size_t count,
> > =20
> >         ret =3D batadv_store_bool_attr(buff, count, net_dev, attr->name,
> >                                      attr_store);
> > -       if (post_func && ret)
> > +       if (post_func && ret > 0)
> >                 post_func(net_dev);
> > =20
> >         return ret;
>=20
> If I remember correctly the shell or some other system between the kernel=
 and=20
> userspace did not like to have 0 returned. It resulted in some funny "try=
 to=20
> set this value over and over" reaction. You might want to test that.

Oh ok. I will look for that. I think in that case we can simply change the =
value
returned by __batadv_store_bool_attr() and leave batadv_store_bool_attr()
returning 0 so that from outside we can still understand if the value has b=
een
changed or not.

Thanks a lot!
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRNyBfAAoJEADl0hg6qKeO4IEQAIOVDnujvNFhz7+UnWJL/6/2
UYSZbHngWwS9iJ92j0ydDuvcasXHdrExINMZJ7urZk0QTeT47TwrBlkZVUfyV9xA
3vEqrCBijXJYPZhYGIobhZtM+Q61+qBhuTvTYhoBNrPz5C3M9rdVtOfliEVOtlYe
Eepie90658B38n919vblW9LEx+GzbKQapQMmDAgsU94MTrQyYWRDAY/LA++D3+yd
YJU26p7LV+uKKwGfZjT1z7/JufSV/dFdKoMqJIcMv2tGHAbVnUz8OBehMns+AGBB
jo41N2LuveH4EGWpQsU2nXlw7C/goAyj11uLJaAZ5WnBsG4DT699eQCLuKcr3dAx
NywM3CYkxVvBQ3sc7Oqxxh8jRSwxQjgUmGhXC3682UcBfx/2c51FP4Lo+Nck5YDA
/VvBRNLtViRrj5cMTVBvxK5SJV+dfPLHigmLtPs8/PvGyAJnrwqIBzR3MKiAP1Vn
1/ryOuT84Nso4kBVX+EkWzilL42KhQsiiFSF5M5AwSrgpuxRIKovzezYfO3ngwj/
mwsjD1rpLDJaulmOb5K7a8XIU8evOqHnfRhxS9omU7a+GzEyKqSjBxqX2YlY7GP2
fzZdumCKAu+kuHbsozmC20anJA9xEEHezXkpW9HVYmGee4rTm92U1pNcASazvZo9
XKEGTCOTQM34vmQdUFx9
=LGcE
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
