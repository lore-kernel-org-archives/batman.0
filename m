Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 12 Aug 2012 18:10:52 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120812161052.GA1919@pandem0nium>
References: <CAHD-aqJubnMBSuyjyS+aOXnS8FSQe=w8Aj2-SnaohNqXSs_xJg@mail.gmail.com>
 <20120807104651.GA25568@pandem0nium>
 <CAHD-aqLExJDuKfYE+TBtruth=YFwbH4PhzYfgWje6N+pxj93hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CAHD-aqLExJDuKfYE+TBtruth=YFwbH4PhzYfgWje6N+pxj93hQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] propagate gw_mode over two mesh linked by
 ethernet with bla2
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


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guido,

On Fri, Aug 10, 2012 at 04:27:13PM -0300, Gui Iribarren wrote:
> Case closed: i had gone lost in a myriad of different openwrt
> revisions, compiled binaries, and patches, so I unknowingly "updated"
> that part of the network to a more recent openwrt version, but that
> didn't have the "check incoming type for bla" patch.
> So it was a simple regression on my part. I just reflashed those
> routers to a firmware confirmed to include the patch, and everything
> is working again. (bla2+gw_mode+vlan)
> Thanks a lot Marek for pushing that patch to openwrt batman-adv stable
> package, it helped a lot in getting things straight :)
>=20

OK, thanks for letting us know!
> > Feel free to update the Wiki, although I'd suggest to add an FAQ to the
> > user page and not on the technical documentation. :)
>=20
> Done, added two entries to the FAQ rewording this thread :)
>=20

Looks good, thanks for your contribution. :)

Cheers,
	Simon

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAn1YwACgkQrzg/fFk7axZaQgCePWMSnAQ19k1ZRWBDrKHCElQ7
inIAnj7T5eTGLjIvUjhqqDjt+Izull2R
=wvAz
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
