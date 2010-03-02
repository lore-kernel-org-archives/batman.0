Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 2 Mar 2010 22:13:24 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100302211324.GA15885@pandem0nium>
References: <20100126061311.GA12697@Sellars> <20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch>
	<20100211094659.GH2900@lunn.ch> <20100211100156.GI2900@lunn.ch>
	<20100228163428.GA15370@pandem0nium>
	<20100301055955.GC15286@lunn.ch>
	<20100301165706.GA11578@pandem0nium> <20100302064308.GA733@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20100302064308.GA733@lunn.ch>
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


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

no, sorry, and i won't be able to do it this week as i am at the cebit
this whole week (if anyone else is there, please tell me. ;).

I would therefore like to ask you and Linus to test it as well, i will=20
perform more tests on sunday.

Thanks,
	Simon

On Tue, Mar 02, 2010 at 07:43:08AM +0100, Andrew Lunn wrote:
> On Mon, Mar 01, 2010 at 05:57:06PM +0100, Simon Wunderlich wrote:
> > Hey Andrew,
> >=20
> > all list-adds and list-removes do a kref_get or kref_put respectively,
> > but that probably was not very clear. As soon as a refence is created=
=20
> > (by linking into the hash or a list), we should also kref_get() it.
> >=20
> > Please find attached a new version of this patch with separate=20
> > send_list_add/remove functions which include the put/get functions.=20
> > I've also added the kref_put/get call to the send_list loop again.
> > It should look more balanced now. Tested in my 9 qemu setup again,
> > no memory leaks or crashes but i only did a very quick test=20
> > (15 minutes)
>=20
> Hi Simon
>=20
> This looks better. Did it survive longer testing?=20
>=20
>      Andrew
>=20

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuNf3QACgkQrzg/fFk7axZJtACfRFA5nipDHNoahpkuJTc9+iRB
3XcAnRyN1+0phT3dlGBCq5uIa9FI629M
=SqUG
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
