Return-Path: <linus.luessing@web.de>
Date: Thu, 7 Jan 2010 23:35:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100107223516.GE2554@Linus-Debian>
References: <5522db2e1001070635m2f53c430sabf642e701ff24f4@mail.gmail.com>
	<201001080152.21832.lindner_marek@yahoo.de>
	<5522db2e1001071312s3261ac6akd959b86c09875c81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <5522db2e1001071312s3261ac6akd959b86c09875c81@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] link local mcast
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One quick thing that comes to my mind is, that you can specify
allowed or denied interfaces in avahi. Maybe it has chosen the
wrong ones? (should probably be bat0 and not the direct wlan0
interfaces for example)
Of course this is just an assumption in case batman-adv itself
works perfectly well. :)

Cheers, Linus

On Thu, Jan 07, 2010 at 04:12:33PM -0500, ecfu wrote:
> I guess I am confused then...  I am trying to see my avahi services on the
> other side of a hop.  the middle node sees the services of both ends, but
> the ends do not see the services of each other.  After talking to the Ava=
hi
> users group, they seemed to think this had something to do with batman
> advanced implementation of its mcast routing.  If you say they are flooded
> through the network, is there another reason why I wouldn't see the mDNS
> broadcasts over the hop?
>=20
> Thanks
>=20
> On Thu, Jan 7, 2010 at 12:52 PM, Marek Lindner <lindner_marek@yahoo.de>wr=
ote:
>=20
> > On Thursday 07 January 2010 22:35:50 ecfu wrote:
> > > Does Batman Adv provide correct mcast routing for link-local mcast
> > groups?
> >
> > Yes, all multicast packets are simply flooded through the whole network.
> >
> > Regards,
> > Marek
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@lists.open-mesh.org
> > https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
> >

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n


--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLRmGjAAoJEBKw7u43QNpf1S4P/Au1Syfe2E0GvXSXSPlVSQ1V
RHZJBdr7ir5AJ5avqYrMiKDW+dHHJw2gGl2mZxsDZBE0fe3qzg9i1xJiY2SJOikc
zydF9pWlhL8AZE34Tp97BNkfF4au8546dD9Mde2hEuym4A8E9gFy6NsEWG/mmhNk
XN4LXZpcvIRFt25xjMVrimkm9TT2nxwnjKToSgXre1yobkdxVmRYYPg0qaPqstjo
jKfGhC3c9Top4k3/ELPphXald15JlUbcOq6u+GTn1HdssJQAxJmE50uvL/zQppeo
0gQXQvOSvvQYQlvXZupPTKgMSN3rHVJXJoIICTCBd19+gEzPDbU0VLKRaq1TEIcd
aFHVrhmD2N4tb1B2fK5PNlAKGlMKD0r7qCHg3UmSgkjA48H2kuPYYyRrcUxwblUv
Oc5dDYy+yOVzV2BGOBDa5qMGVlebtTk7VRTbk6MWIqfloocBVugLBmM3tCwoULzC
SKNANRqxM7JdbWxFAenS/SLaIV1oqjMezB9zg825JU3F5aP+vfdM9HIzmJ90GjsN
FMUvRLkAeNLQbeNDPY22Qv2HfXjpwV9W3fIMz/TH5SDSvMycic+O0B7aZb/ILBSY
WH91WErpG5PsMTiYiSWvaQ/cMVPjnpE21OVmOmLRGZ/P4inGmINFHwRIO8OZVsc4
SPzX3v+TkGKTYddovB+N
=Z72v
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
