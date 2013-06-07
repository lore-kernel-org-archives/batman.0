Return-Path: <ordex@autistici.org>
Date: Fri, 7 Jun 2013 15:57:13 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130607135713.GL1789@ritirata.org>
References: <20130604051326.GJ1226@ritirata.org>
 <20130604053841.GK1226@ritirata.org> <51AF567A.7030404@inti.gob.ar>
 <51AF58F4.8080501@inti.gob.ar> <20130606055102.GH1789@ritirata.org>
 <51B0D294.4070809@inti.gob.ar> <20130606182954.GI1789@ritirata.org>
 <51B0DD43.6090500@inti.gob.ar> <20130606191823.GJ1789@ritirata.org>
 <51B1E4D6.5000900@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KSn4sQg3MnruwCB4"
Content-Disposition: inline
In-Reply-To: <51B1E4D6.5000900@inti.gob.ar>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--KSn4sQg3MnruwCB4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

thank you for your logs

On Fri, Jun 07, 2013 at 10:49:10AM -0300, Gabriel Tol=C3=B3n wrote:
> >
> > Hello Gabriel,
> > there is a lot of noise because you are also generating traffic on the =
network.
> > However I can see the ICMP Echo Request and then an Echo Reply, therefo=
re the
> > two nodes seem to be exchanging ICMP packets correctly.
> >
> > I'm checking again to try to understand what went wrong.
> >
> > Meanwhile, can you please report the output of
> > "batctl l"
> > during a bw test after having set the bw_meter log level by running
> > "batctl ll bwm" ?
> >
> > To get the exact log of one test, you can first run batctl l (this will=
 print
> > all the past log), then you run the test and then you run batctl l agai=
n to
> > obtain the interesting log. Please upload it on pastebin too.
> >
> > Thanks a lot!
> >
>=20
> Sure, here they are:
>=20
> http://pastebin.com/fLu9hsyt
>=20


=46rom this log I can see that the protocol is entering Fast Retransmit man=
y times
and this happens due to reordering or small losses (the latter option is mo=
re
realistic on a single hop network - but is it really one hop? I never asked=
).

The other strange thing I see is the final SRTT value which is 260ms and lo=
oks
pretty high. Is there anything else going on the network (other traffic or.=
=2E)?


Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--KSn4sQg3MnruwCB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsea5AAoJEADl0hg6qKeOKIQP+gJzSY3d8KHk+/ywjnfDqxFV
OVxNACHEdEzK8JhPMgXnoAD8hCTNnfBrjym2hchw7QYHtXgTFyQnAHl4wXsX5UoI
9zksKrWsNbHmE3rKt9WRsuNq/q2d8IrFdodNR4OeXyKY6uSv6W2pIE4AkkFPUSrY
SgKwdZExrDEwXjONoDlui/MX0MrCLTIEyfx9WLefYHKg8nzo6EwAQUjd71lWXPJB
Ne/C++9V99H8V73J7/kDXiLJ3+xevNnMldvNALmaq/6xuKag62n47gJ+6xp2mbav
K5LWRzmABIpW7h9N8rhSKjdSsWfZC5LB8iWKvRUnlCtqxviQY0GJnyGuJoq6EjSv
J51jSoS/VOW/WMX97h3NHQmvIuMdhIzlidAYPFhHzp1YwBV8mv/K/+NoXbQJzLJA
G2pKiogJbAQ1KYYGyb9nMFD1uG16+6cU0MSfk41IDTDcTfEN8Y5pGatbfnypzMp3
QjBEeDwG2WG6ldmHRt+z0NC2gWTP2uytCBEb8Jg9lzNCwCErDV6+ibd9lnlVf9Rm
dH7YSnDmPjkVuLUXIlzZ2PpivxlQ6zaE+a/bt3Gx3gd+jrW16gmgV/hdQ0WFEkFw
Rb1pHKWH85PeBwHfgzEYhextQ59ih5VrFY1q42KGcwJCbXtRAgccaPLMhvuJ0duT
ZQ4PdHIN41SqyFIThNS/
=oqZ1
-----END PGP SIGNATURE-----

--KSn4sQg3MnruwCB4--
