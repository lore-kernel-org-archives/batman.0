Date: Thu, 31 Jan 2008 23:46:52 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] IMPORTANT: batman-exp <rv972 goes crazy after
	49 days uptime
Message-ID: <20080201054652.GB14381@apoderado.ometepe.net>
References: <200801311804.55291.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <200801311804.55291.axel@open-mesh.net>
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


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Axel
On Thu, Jan 31, 2008 at 06:04:55PM +0100, Axel Neumann wrote:
> I found out that the batman-exp daemon goes crazy when its internal life-=
time=20
> variable overflows. This will happen after 49 days, 17 hours, 2 minutes, =
and=20
> 48 seconds (which corresponds to 2^32 milliseconds). Unfortunately, its=
=20
> behavior afterwards can be anything between hanging around and doing noth=
ing=20
> and an endless loop of sending packets.
or just work normally for another ~2 weeks, and then going crazy after=20
some 60 days of uptime ;-)
> The problem is fixed with revision=20
> 972.
>=20
> If you are running batman-exp I strongly suggest to update.
if i find time on sunday, i'll give it a try

cheers

  --Jan


--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHorJMlTtvZdk47D4RAtlbAJwOwCcgFZyGQvSUHhQhjh+3Z+WmhQCfYhzR
g+7XnIe8YCLktKuysdQ1If4=
=vWG3
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
