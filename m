Return-Path: <antonio@meshcoding.com>
Date: Thu, 21 Nov 2013 15:20:10 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131121142010.GE311@neomailbox.net>
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
 <528D81CA.8000106@universe-factory.net>
 <20131121072143.GD311@neomailbox.net>
 <528E115E.6070901@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <528E115E.6070901@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 02:57:50PM +0100, Matthias Schiffer wrote:
> On 11/21/2013 08:21 AM, Antonio Quartulli wrote:
> > On Thu, Nov 21, 2013 at 04:45:14AM +0100, Matthias Schiffer wrote:
> >> You are casting a u32 * to unsigned long *? Won't this break horribly
> >> when sizeof(u32) !=3D sizeof(unsigned long)?
> >>
> >=20
> > It will break when sizeof(unsigned long) > sizeof(uint32). For example =
on
> > x86_64. Hopefully nobody would use such ancient kernel on his machine. =
But you
> > are right.
> >=20
> > What do you think of the attached patch?
> >=20
>=20
> That's better, but if you care about overflow, you should add something l=
ike
>=20
> if (_v !=3D (unsigned long)v)
> 	_r =3D -ERANGE;

yeah, thanks! I'll add this!

>=20
> Also, the comment in the line above doesn't make sense anymore...

yeah, I removed that already.


--=20
Antonio Quartulli

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSjhaaAAoJEADl0hg6qKeOFOEP/2U7Pjti+NC9H0dIZxir9SeI
iJgNG5rjUZovWXTLagWt9fr3Rv/GJmFMOwtnJHsdj3hzqLzQMbgHfqxAoktwyJN6
yG00UGAX/PdOQuDu+vQfszZ5skG82OAKJCmSDi32ODO9JBcFAiq4PlZgtwbwh9EB
y55cbfuPELp8WOJLjI8mivkpp/JHz+3tlOGXTovBzV30jdgAwVONFkmJAIctOZ9C
Ub4qUKs/2XFstKLRT/D5PG/eJI0TQyf0njtOFQHYGp8jvxn8UJIcqtQ1Jws0lMCd
dBTbWwEJbLBWR8CWhBGgO8eJD/FpTh9r57H4clJZTF1wK8uO5+jYWHNkdjhCcEqs
Z/s0rkIeTnTvO+PejAcl5cFQlEUkKqXT0+NYn37ZUHZ+tFQrF2DdSC/RC4u8xosG
LiPLO2dE0idt8BHUzrWHXpp1GGHeziu/le8NW6teTe6Yx0lnkeneRiWlMOz179qg
XOuZ6QtJcU+I5+07GJQ+B0uTTtKBYyAlnnapq49fZPerfvzhotbKnOtuR8RGQZ5m
/UVEoxOUDVfnK1Guc6pa2XgKUmEOldsXIWfURhmhW8ETaBYnrMShXCBPjd705Ipu
jkBA005JJ+8d43g+L4DjA+p1RHc6Eyu4c8gMxaHko6BXlk+puNS6OqZj4CXCUJqH
J7negRdjD1ecAs807gtW
=XqN1
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
