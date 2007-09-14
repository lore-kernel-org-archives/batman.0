Date: Fri, 14 Sep 2007 13:32:50 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] translation of batman-adv
Message-ID: <20070914113250.GA3041@hrz.tu-chemnitz.de>
References: <20070914080358.GA1870@hrz.tu-chemnitz.de>
	<001401c7f6ba$3ab9e600$0cdbe29f@happy0bc06a65b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <001401c7f6ba$3ab9e600$0cdbe29f@happy0bc06a65b>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

No,=20

the batman-adv currently has a timeout for client-macs of 5 minutes. But
as soon as another new ap announce the mac as his node, the old ap will
recognize this, update his table (remove the client-mac) and stop announcin=
g it.=20
So only the new ap will keep on announcing, not both.

Regards,
	Simon


On Fri, Sep 14, 2007 at 06:30:11PM +0800, ?? wrote:
> hi
> i have a question:
> when a node moved from one ap to another ap, will the two aps  announce t=
his node
> until the "previous node" age out?=20

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6nFirzg/fFk7axYRAjJMAJ4rExIGLRMU9Ape2Ep1Sjjg/9w/7wCgjDXc
pXuGtaABpHMK1iIejP3jFSg=
=UJ2K
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
