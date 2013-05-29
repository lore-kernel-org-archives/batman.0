Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 17:32:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529153202.GU3333@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-2-git-send-email-mihail.costea2005@gmail.com>
 <20130526135746.GM1679@ritirata.org>
 <CAP5XTDOfQeQ_13wUebA2e68kBCty=NV7mLG4x2nqZ6aVzL6xig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U7F658e60E1K4csu"
Content-Disposition: inline
In-Reply-To: <CAP5XTDOfQeQ_13wUebA2e68kBCty=NV7mLG4x2nqZ6aVzL6xig@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/4] batman-adv: added IPv6 to DAT and
 generic functions in distributed-arp-table.c
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


--U7F658e60E1K4csu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 08:16:25AM -0700, Mihail Costea wrote:
> >>  /**
> >>   * batadv_dat_entry_hash_find - look for a given dat_entry in the loc=
al hash
> >> @@ -393,6 +403,11 @@ static void batadv_dat_entry_add(struct batadv_pr=
iv *bat_priv, void *data,
> >>       case BATADV_DAT_IPV4:
> >>               choose =3D batadv_hash_dat_ipv4;
> >>               break;
> >> +#if IS_ENABLED(CONFIG_IPV6)
> >> +     case BATADV_DAT_IPV6:
> >> +             choose =3D batadv_hash_dat_ipv6;
> >> +             break;
> >> +#endif
> >
> > mh...I was just wondering: for the hash functions it would be nice to r=
e-use the
> > same "array approach" that you used for the printing format.
> >
> > So we would have an array of function pointers to reference rather than=
 having
> > this switch block...What do you think?
> >
> > I think it would be possible to do this for many other "variable" param=
eters if
> > required.
> >
>=20
> Should there be a struct that contains all of them, like:
>=20
> struct batadv_dat_data  {
>=20

I was thinking of having many array, but I have to say that the "struct ide=
a" is
much cleaner and it can be seen like an API.
Then we would only have one array of objects of this type.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--U7F658e60E1K4csu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRph9yAAoJEADl0hg6qKeOzYsP/1CLxGXIZKgft6MZtBdYvrI9
Li+SwWYLmVpcPl/56IB0uWHbip04zEZc6MxUfHhjhMdh/zLwIBEMJhr4pMgoUSrP
adZoE0GbpvD7LLkYgKK8OcWjSadH5Sfz38mu1uiBZ/DtHETa+Ar4UhL2Y1N1iI0l
mKHPuQZP+x/GJeSObqMZEONVJKSMQIMDlJ9exYrw/uucEq8HeM3vh15IN+cyqOnT
vSLyuRRjgPREbH27ZlXPlWZnrrrXDrvJl9jlXdWrwyCSzhHpuex8Bj1AA+ft7OGS
u9+6UrjDLIDxJP5lPXMJ3/ZKIn4bj5cnR0P8IMSwl4imsb0gd4rMkcypzkSHhBTw
zHOk1CAQWhrdanqS1cWOC9Yw6XkbFS23Pw5bVOwQEB052bcwFx5wttFsWSFWlGhE
XIVQGv16fnyHjmlzlfw7GlTzmDu6BiuRsQhbdntHvqY9xkPo2df+W67TQWDQeAPk
4wxBPqNs7xY7ArRkA6004FPsfnMeBvP/8AzGfSYndMwyZe1bZ8r5TTOJObErrHb5
Vwfzr+l09QFShRJBdSnvw+tmrhDOgW2ww/DGJ064uPeauj1dRbC4WtQBg8MQSGCV
Ay/+Gjro664rS/MNLLia4n3Zsvbgc8rmlioUwgU1EZXQppHR5LHFt0tmrbykvlgp
niuVMKmAcn9HhaIPrT2b
=HMcw
-----END PGP SIGNATURE-----

--U7F658e60E1K4csu--
