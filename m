Return-Path: <ordex@autistici.org>
Date: Thu, 6 Jun 2013 20:29:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130606182954.GI1789@ritirata.org>
References: <20130528070057.GC3333@ritirata.org> <51ACBCE4.8000506@inti.gob.ar>
 <20130603160813.GC1226@ritirata.org> <51AD0277.1060907@inti.gob.ar>
 <20130604051326.GJ1226@ritirata.org>
 <20130604053841.GK1226@ritirata.org> <51AF567A.7030404@inti.gob.ar>
 <51AF58F4.8080501@inti.gob.ar> <20130606055102.GH1789@ritirata.org>
 <51B0D294.4070809@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
Content-Disposition: inline
In-Reply-To: <51B0D294.4070809@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: Gabriel =?utf-8?B?VG9sw7Nu?= <gtolon@inti.gob.ar>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2013 at 03:19:00PM -0300, Gabriel Tol=C3=B3n wrote:
> Hi Antonio,
>=20
>=20
> El 06/06/13 02:51, Antonio Quartulli escribi=C3=B3:
> > Hello Gabriel,
> >
> > On Wed, Jun 05, 2013 at 12:27:48PM -0300, Gabriel Tol=C3=B3n wrote:
> >>
> >> Sorry, I sent the mail incomplete,
> >>
> >> So these are the routes:
> >>
> >> Equipo1:
> >>
> >> root@Equipo 1:~# batctl o
> >> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:42 (bat0=
)]
> >>     Originator      last-seen (#/255)           Nexthop [outgoingIF]:
> >> Potential nexthops ...
> >>             E3-5GHz    0.680s   (251)           E3-5GHz [   wlan1-1]:
> >>          E3-5GHz (251)
> >>             E3-2GHz    0.430s   (255)           E3-5GHz [   wlan1-1]:
> >>          E3-5GHz (255)           E3-2GHz (252)
> >>
> >>
> >> Equipo3:
> >>
> >> root@Equipo 3:~# batctl o
> >> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:d6 (bat0=
)]
> >>     Originator      last-seen (#/255)           Nexthop [outgoingIF]:
> >> Potential nexthops ...
> >>             E1-2GHz    0.310s   (255)           E1-5GHz [   wlan1-1]:
> >>          E1-5GHz (255)           E1-2GHz (255)
> >>             E1-5GHz    0.550s   (255)           E1-5GHz [   wlan1-1]:
> >>          E1-5GHz (255)
> >>
> >
> > routing tables look good. I am wondering where the problem can be..
> > Can you try to do a "batctl td wlan0-1" while pinging? this may help to
> > understand where the process is blocking.
> > It would be helpful if you could do that on both the nodes while pingin=
g in only
> > one direction This way we see who receives what.
>=20
> I did it, but the text files for the logs of the nodes with "batctl td"=
=20
> have a size of about 250 kB each one, with just 1 or 2 seconds logging.=
=20
> Is that too much for sending them to the list?

maybe  you can upload them somewhere and then send the link here?

Thanks

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsNUiAAoJEADl0hg6qKeOioYP/RCPQwYosKWiymSNFtSKY7P1
1a1Cm0yArM7PGXVSqNBOyUVY05mrpqrcjliFKG7fmoMSycqsPs1NM2AwewskSWBF
MbLHH/2GNRxFcMflR52/6YeJ+LSTpEzI+61Ns3OpEpveBYT0a744DZP/j8Z2wjju
Q0/IYlsWrWwWnv265qgjq4XMycfIWx7P1wELK7VGBR/oCxjXHSzPqx9Y/DGiS5EZ
IOs2Q/dNMcG2YGAvdS7DDuLTnPf61X6ilBCmfb7XBpMMYSnS99Wk2I6URWgpZorm
2gyLG24ubETQPz8PXgdfQiM26eTDEYTrp6S047FXo7ITmtlU8wGkK2o3MpctYh6v
xb0s0XsLnrbSe610h84y555EzK5imF9/BqhE3NdS03GC3Zwee1BsiZ+A5+GtODKq
w6CUKnqiZPgu9YgGPipbYSSUcZESE+qTM8VCWCDdXYu7asRImPL6yByKeJBDEK2o
sclmwKGR/GkG9imr7KpXmCn1AhSuNSRPQ9Z/75515+9ZNTdiZ4Wbdjs0ttsdHYna
jA2YxOvm/txOK8c5ad4ARYWw4uPxg1JdicjQ9eS1pNye8o/yrVftNIv4eHh8Vrb+
QYS/Ar/99UaatFckI4nMxOAYNNdj1cys7xAUp3m3MbKKurjbqsD+KLxwbwK8m25y
oazswK1bwFm+yD6DoT//
=NQWh
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--
