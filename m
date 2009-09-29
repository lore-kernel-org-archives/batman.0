Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 29 Sep 2009 18:14:50 +0200
References: <200909031406.49008.lindner_marek@yahoo.de>
	<200909291719.37794.lindner_marek@yahoo.de>
	<5161afcd0909290856w41dc1d10l3b109c2e68155f70@mail.gmail.com>
In-Reply-To: <5161afcd0909290856w41dc1d10l3b109c2e68155f70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2912949.qOnNQhXf2B";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200909291814.53591.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] mailing list migration (was: development flow)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart2912949.qOnNQhXf2B
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[...]
> > * We create the additional new list while keeping the old one. The new
> > list is for the communication with the kernel developers.
> >
> > Opinions ?
>=20
> I think that having two lists would be a hassle and a mistake.  To
> have two lists at one host might work, but one list at VGER and
> another somewhere else could be counter-productive, as "internal"
> communication would be constantly forwarded to the kernel list, and
> relevant kernel traffic would have to be forwarded back to the
> "internal" list.  Think about that for a second.  Eventually, we would
> probably just drop one list.
>=20
> If one list is O(n), then two lists are O(n^2) for anyone who needs
> both.  I vote for one list, no matter where it's hosted.
Don't understand the calculation as I would prefer + instead of * here, but=
=20
this isn't the point (and if you would do program a bad matching algorithm=
=20
here it is still O(M*N) ).
Don't think that two lists are good without a good topic split. I see a rea=
son=20
for -devel, -users and -announcements list in some projects, but not for a=
=20
list for "kernel people" and for "other people".

> commercial solution (EMWD):
>  - spam filtering
>  - open-mesh.net
>  - small price < US$20/month
>=20
> open source host (VGER, freelists.org)
>  - spam filtering
>  - their-domain.com
>  - no price
>  - we get added to their project directory, so potential contributors see
>  us
Haven't followed the whole discussion, but is it real such a big problem to=
=20
change the mailing list address? OK, it shouldn't be done every week, but t=
his=20
is done for a good reason. Just do an announcement on this list and create =
an=20
auto reply (smtp failure notice with further information) when someone writ=
es=20
to the old list.
Maybe more interesting is the fact that if we can import old information in=
to=20
the new list. I think mailman stores everything in simple mboxes, or am I=20
wrong?
And also interesting if we can do backups of the data on vger and co.

Best regards,
	Sven

--nextPart2912949.qOnNQhXf2B
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJKwjJ6AAoJEF2HCgfBJntGPS0P/jq/k4/yBgwBdHohJSTFi9db
e9x7CXtrrijWMXaRiA6//Oi9sJYVqEqavu6tYNMHgXBpw6FmCEKLZ3b8KBQkJteh
jWxY4UOkXtmRjoG/NCuWPSEeeoB2JtSGjkqjfj0XDbDwVNvQs5G7TMVnt0CVYWXR
Bu38Oix7VLWFUTdCdwRjf9RpFvPBMy/mfFhau2QJ70bcbwAe+UXABK6m7REI2/nP
esZ5Kv9SN8e+e5ilgMDqZUpyku9ydUlPwaiNldWx9UPhuFIBDK+LSwE7OpGdV60v
+l083QQXBUlx+P5cjvinSRRtvWd5S/f+NEHIYW5A4lsIvyhKq61SZe0naX7eOJLA
dziSBMeonfO4nqMH+hlneVb4d0wZfkRQXU+/y2Pth/LkVFNWZO3D3t8F63WyVw+I
6ByHMWtc09VGbgXP9EJw8TapyHASWuyut3XWkCYxgycICTXb9gR6jb+H1ycRDJJs
tMw1gZuMLi2bokZbskSd+JDKBg8TinILCSOkd+4iPT6bXO9Wk6sUNmOu1HeaKnfN
jU8uhUq/wZ7RlTaED3/4h5wv4u6UnaMjkPvf5ztLSNz8ahbRXevJIUgTXCuWS9Lt
4+PfckXF1k7bZLfOMjipojp5XALjfXqwZrLlSN5G9kecwx3OsoUtHAk5MHINf9gx
ZUPw1Ov7tNDM0ZWqo9tD
=aRhs
-----END PGP SIGNATURE-----

--nextPart2912949.qOnNQhXf2B--
