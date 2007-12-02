Date: Sat, 1 Dec 2007 23:39:16 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Message-ID: <20071202053915.GC3923@apoderado.ometepe.net>
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712011834.54327.lindner_marek@yahoo.de>
	<200712012141.59334.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <200712012141.59334.axel@open-mesh.net>
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi
On Sat, Dec 01, 2007 at 09:41:59PM +0100, Axel Neumann wrote:
> perhaps this has something to do with the reduced maximum-transfer-unit (=
mtu)=20
> which ist left for the tunnel interfaces. Since the one-way-tunnel do onl=
y=20
> tunnel the upling-traffic but NOT tunnel the downlink traffic this is not=
 a=20
> problem when trying to connect to a intractable www server.
>=20
> Did I understand you correct, that these problems only occurs when surfin=
g to=20
> a few webservers, but not to all webservers?
exactly
>=20
> Can you try what happens if you reduce the mtu of the outgoing interface =
at=20
> the upstream gateway (e.g. ifconfig ethX mtu 1400). I think there might b=
e 3=20
> possible results:
>  1) everything remains as before, there is another reason
ok, set mtu on upstream gw to 1400, and everything remains as before :-(
(didn't check at the upstream gw yet, but from inside the mesh i can
also access hotmail when 1-way-tunnel, and not access hotmail when
2-way-tunnel)
and tried another one with mtu 1200... still the same, seems not
related.

cheers

  --Jan


--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHUkUDlTtvZdk47D4RAoUkAJ4msbaZl4slQMHUjriffcq+vfdeagCgi5qW
FBTa9q0PeoRMmQbz44Sp/D4=
=jKaq
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
