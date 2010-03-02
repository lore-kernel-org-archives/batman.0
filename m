Return-Path: <linus.luessing@web.de>
Date: Tue, 2 Mar 2010 22:44:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100302214349.GB4436@Linus-Debian>
References: <20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
	<20100228163428.GA15370@pandem0nium>
	<20100301055955.GC15286@lunn.ch>
	<20100301165706.GA11578@pandem0nium> <20100302064308.GA733@lunn.ch>
	<20100302211324.GA15885@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline
In-Reply-To: <20100302211324.GA15885@pandem0nium>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon and Andrew,

I already tried both Andrew's intial and Simon's latest patch
yesterday and had both of them running for about 1h+, also with
alternate vis-intervals (1s, 50ms, 30s) but so far I wasn't able
to reproduce any crashes or leaks on two Debian stable VMs
connected with each other. I'll run Andrew's patch version again
this night for some more hours to make sure that I'm able to
reproduce the crash at all. Any other hints for reproducing it
more quickly welcome :).

Cheers, Linus

PS: With how many nodes and what kind of systems could you
reproduce the crash? Were all those nodes connected directly with
each other? How many vis-servers were running?

On Tue, Mar 02, 2010 at 10:13:24PM +0100, Simon Wunderlich wrote:
> Hello Andrew,
>=20
> no, sorry, and i won't be able to do it this week as i am at the cebit
> this whole week (if anyone else is there, please tell me. ;).
>=20
> I would therefore like to ask you and Linus to test it as well, i will=20
> perform more tests on sunday.
>=20
> Thanks,
> 	Simon
>=20
> On Tue, Mar 02, 2010 at 07:43:08AM +0100, Andrew Lunn wrote:
> > On Mon, Mar 01, 2010 at 05:57:06PM +0100, Simon Wunderlich wrote:
> > > Hey Andrew,
> > >=20
> > > all list-adds and list-removes do a kref_get or kref_put respectively,
> > > but that probably was not very clear. As soon as a refence is created=
=20
> > > (by linking into the hash or a list), we should also kref_get() it.
> > >=20
> > > Please find attached a new version of this patch with separate=20
> > > send_list_add/remove functions which include the put/get functions.=
=20
> > > I've also added the kref_put/get call to the send_list loop again.
> > > It should look more balanced now. Tested in my 9 qemu setup again,
> > > no memory leaks or crashes but i only did a very quick test=20
> > > (15 minutes)
> >=20
> > Hi Simon
> >=20
> > This looks better. Did it survive longer testing?=20
> >=20
> >      Andrew
> >=20



--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLjYbTAAoJEBKw7u43QNpfsTUP/A0xJNysDzIpP4yKQaqCZxnA
GAPzFX/hzDafwI4ILs7VOd5Ng/5BkTJl8atzJA6tvgPns/3/XAOM5llNf6O0FJqM
VEOxJgFnM+3i1LnXnA8MoakU6jQSYiRS0LiS0sDJBfzSTAMx+SmDpbRgg9UoR+px
rwaQ01fLD68OIXVxUkRj4SMSUnMkGl6Y0RM7LaJOj+LT/FdYnoilT0QiQCZQC7h4
bNGK/VS54cYdJDB8MRFCafYQ/CBIUS2JZALjvBxAQjgFuoaHKpLOi2++QURMra7q
bsh6VK3kDSKyIZ/rgLtkER+LAYNHKFLwU3NB7yB0QRtvL4W3XL96Q50tHSFtAijQ
vsw9xJhUSAkAy8lP2Fw/fIJgHt2d+T3lB2zWTPAaCbN1QoHFJyQSUjpBIr0K/soa
yJmZ9DTfRxZNligk3l5CRNANyLTBycrf8Qkb07FkNsS39yOBGtRzpnW2i0DJwKSX
E2W/jNuwSwcofp9wOfbvUKFG/MgjYXiVuJQpqSo7lRisvdzGDEUjKq43vSa2CctS
VAZsr+lZZQWtwIujSMfEpcKbnbhplfL4NsCaPfht59QPTFy1I8P0LD2iTxkgJeNc
/2bQSGVyDAl73SPPbLMiv/L7Qn7+8zoPCsNvle00APP/waBdhfm4xkQM1TSE94Qv
hLAhv8Idr3k2iQLSdNaB
=WbUy
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
