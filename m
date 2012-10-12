Return-Path: <ordex@autistici.org>
Date: Fri, 12 Oct 2012 15:04:57 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121012130457.GA4566@ritirata.org>
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
 <5077A77B.3040803@altermundi.net>
 <20121012071559.GB2564@ritirata.org>
 <5078131D.9070508@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <5078131D.9070508@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2012 at 09:54:53AM -0300, NicoEch=C3=A1niz wrote:
> On 10/12/12 04:15, Antonio Quartulli wrote:
> > On Fri, Oct 12, 2012 at 02:15:39 -0300, NicoEch=C3=A1niz wrote:
> >>
> >> Is the setup clear enough now? or am I missing the point as to what is
> >> unclear? Please ask whatever needs to be clarified.
> >>
> >=20
> > Hello Nicol=C3=A1s,
> >=20
> > I think I got your point. First, you are talking about the "normal" AP =
isolation
> > feature that you can enable in hostapd, right? Because in batman-adv we=
 have our
> > own (Distributed) AP-isolation but it has different effects and behavio=
urs.
>=20
> exactly, it is the "normal" AP isolation feature.
>=20
>=20
> > The behaviour is correct: OGMs are broadcast packets. In infrastructure=
 mode,
> > whatever broadcast packet a station sends gets to the AP which will re-=
broadcast
> > it again. In this way every station gets it and from the batman-adv poi=
nt of
> > view it is like the packet was received directly from the other sta (th=
e MAC
> > addresses in the packet say so). Therefore you must enable ap-isolation=
 in
> > hostapd if you want batman-adv to behave as you expect.
>=20
> Does this mean that with isolation turned off stations will try to
> communincate directly if they can? Say, if we have two stations that are
> far from the AP but very near each other, will they actually send
> (unicast) packets to each other without going through the AP at all? If
> so, activating isolation might be eliminating real possible paths, all
> for the sake of sane originator tables.

First, this is not related to batman-adv. We are discussing something "belo=
w"
the batman-adv layer. In infrastructure mode unicast packet from station A =
to
station B will pass through the AP. This behaviour has been changed by 802.=
11e
and (T)DLS (you can have a look at the 802.11 standard if you want more det=
ails
about that). But, again, this is not related to batman-adv.

If you use infrastructure mode without AP isolation, batman-adv will consid=
er
all the other STAs as direct neighbours. But, due to infrastructure mode,
packets from STA1 to STA2 will always pass through the AP. This is also why=
 I
would suggest to keep AP-isolation ON if you want to run batman-adv on the
stations and on the AP, but then it depends on what you want to get.

>=20
>=20
> I believe our mixed setup is not standard practice, that's why I wanted
> to share this real-world results.

not standard, but common (there are many -closed- drivers that work better =
in
infrastructure than adhoc mode. but this is normally used in PtP links only=
 due
to asymmetry problems on the link (see 802.11 standard for more :-))

Cheers!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlB4FXkACgkQpGgxIkP9cwcqqwCghrch5unEl/wzXfW1X2LP98iZ
x9oAn2LLBfeBe/Lm1NR4ABYIoE26AVZv
=2o6n
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
