Date: Thu, 3 Jul 2008 17:35:21 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN Gateway
Message-ID: <20080703153521.GA5215@hrz.tu-chemnitz.de>
References: <4864DD02.20209@csp.it> <20080702130116.GA28427@hrz.tu-chemnitz.de>
	<486CD741.3050008@csp.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <486CD741.3050008@csp.it>
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
To: cipollone@csp.it, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

please note that the BATMAN Gateway module has nothing to do with
batman-advanced (user/kernelspace). The BATMAN Gateway module can be
used to accelerate the BATMAN Layer 3 (and only Layer 3) Gateway=20
functionality. BATMAN will automagically detect the kernel module and
use it if its available.
But you will have the same functionality without the kernel module, just
slower. :)

best regards,
	Simon


On Thu, Jul 03, 2008 at 03:42:25PM +0200, cipollone wrote:
> Hi,
>=20
> I want to know how work and what I have to configure the kernel module=20
> of BATMAN Gateway. I'm using OPENWRT and I haven't found paper that=20
> describe this kernel module (usage, configuration, how work).
>=20
> Someone could help me?
>=20
> Thanks
>=20
> Paolo Cipollone
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIbPG5rzg/fFk7axYRAph6AJ0VuyUurZ/2wh4sMRVNSBDZ4Rp07QCgyosr
amYFTDUPpkDnT7Mwfb7aW3s=
=ym3+
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
