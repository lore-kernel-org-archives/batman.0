Return-Path: <sven.eckelmann@gmx.de>
Date: Mon, 11 Jan 2010 15:58:44 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100111145832.GA7680@sven-atom.lazhur.ath.cx>
References: <5522db2e1001110645h64053e9bq59bdacdaeab2dbec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <5522db2e1001110645h64053e9bq59bdacdaeab2dbec@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] modprobe
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


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2010 at 09:45:07AM -0500, ecfu wrote:
> The installation instructions say to use insmod to load the batman-adv
> module.  Can you use modprobe?

Yes, when you installed it correctly then you can use also modprobe.
>=20
> Basically I just want it to start when the system boots.  Is there an easy
> way to do this?

Depends on your distribution. Normally it is sufficient to add a line to
/etc/modules or a similar file. You can also add or modify a init script to=
 do
that - including the configuration of the device.

batman-adv should not stop you from doing the normal way you do that stuff =
in
your distribution.

Best regards,
	Sven

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJLSzyjAAoJEF2HCgfBJntGEzwP/ieNmXJYbvmztMncbZiB2HFn
FhEt7sy/uDgRX/DEl66fzTBgRRpO8gP2ypxIrbAnXg+1YmuzRagZ9mkLHsftobX1
7haSjn9ucf8Z3k/NeaPlVcdzYrDX9iFEfn9Df6Zj1uxh9qJpNgmIsIK/vNjNlLnL
m/7Lc50TbX49Rm/uwNY3lnbc/obyfxAtfx+aapG3aSYGiDB48JqQRuCPMfCcXA9o
u7WO//xyglbUVBUWXVo9qg/3kvuMwm1xePlsGu94LZFtVbnGgLqP/FPjDv0+sO8V
NagYslYEm67BdPNANrbbyzsEOet2FUmkIiBtlWtdaU6GGyM0SIehPlNYe/lxxEab
jIhWeeQf3sawfD4TCQPEX34HoSP2qigGaPlTiAY5hvjvlC+6GPEEyMhxiBmweO5e
cbOGvhc8Tj0MVk1A8TpzBkGc+G651cADZ7Ps+imCoq23GJbYDpNXwNym23z55FfA
aPAIJk5Z/28ed5ZCgHOMaXcK2o321qXNeqUbuCEhEH7NInWzy+je/BSjwnnOQ5DA
H8zAH1EJszvsSzmnDyqEy3qrL0lKuEC5Ke9TD51iwn9QPhgZOSic0vkhyJmnYSqH
jh9PPbJa3YRlYbjyHl7E4hZAInjXGDsHtyeDDCgl3h8YERCbkrieWHzEJCpyqb96
f+QlvDFuyT0i0qofuQsF
=ErI6
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
