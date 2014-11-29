Return-Path: <mpa@pengutronix.de>
Date: Sat, 29 Nov 2014 20:46:32 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141129194632.GA27289@pengutronix.de>
References: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
 <547A217A.9070209@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <547A217A.9070209@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Kconfig,
	Add missing DEBUG_FS dependency
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 29, 2014 at 08:41:46PM +0100, Antonio Quartulli wrote:
>=20
>=20
> On 29/11/14 19:07, Markus Pargmann wrote:
> > BATMAN_ADV_DEBUG is using debugfs files for the debugging log. So it
> > depends on DEBUG_FS which is missing as dependency in the Kconfig file.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  net/batman-adv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
> > index 11660a3aab5a..c6fc8f756c9a 100644
> > --- a/net/batman-adv/Kconfig
> > +++ b/net/batman-adv/Kconfig
> > @@ -62,6 +62,7 @@ config BATMAN_ADV_MCAST
> >  config BATMAN_ADV_DEBUG
> >  	bool "B.A.T.M.A.N. debugging"
> >  	depends on BATMAN_ADV
> > +	depends on DEBUG_FS
>=20
> What if somebody does not want to bloat the kernel with debug_fs but
> still wants to run batman-adv? (i.e. on a very constrained embedded unit)
>=20
> With this patch this would not be possible anymore..

It is still possible, it just adds a dependency for BATMAN_ADV_DEBUG,
the log which holds the verbose information. This is exported in debug
fs as far as I could see, so it is not usable anyway when DEBUG_FS is
not enabled as all debugfs function calls will be noops in that case.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUeiKXAAoJEEpcgKtcEGQQZwEP/iKX0VbQYpn8NMPrLH11Zmhp
wjVoc+Zc+gu3kacyMjoPKDQvZ1xtjC9gH9uXlUhwlm1vXOmHd0tTALh4yJEk+fE+
eRshGENrebIwZ2XW6N0fkoZkbOuyQ/1xqj1pZsjcMCQCuzDcBkgUr1WbnVOqCZuv
q7BWfWVVSGburx4X1DKBxDypPDmUMiNSOulot/d05jUYHL2/gW2MNclmHihwjSck
3E5nyk+Gn1GgLMAQAn5vJKEyRJwrjvlxUoGRHsA33h48v0k81Ms6a/oD7AF+wIun
h4mVTC74mte4zZJZGMxKDoTf2zCr+FfCV1tOA6NxnWHq77I8lxLeqVObNSflw06N
ieIAdKa0uUvigrQA2S+fEURARHIWWt07H/e9tFoPX3IaGvMG8/NwXPPOj11Gv9Nd
ZgrcPt4zZaqrrrUuzREaYG7pL2vY9cmtiZrnRKHg/5x8FbDcqZ6EWIb0R/6vCvM+
TWxwd2GHrognuifJeX+DMii+tg7RwEmpfDQFT8BkaYfcr9YbdRsAynL2cSDktge4
ApCPt0sYwf+hF+aIco0JscHFms9Txmbk6HJJfU39cI1v7JsEoTlKfX3bUGXPnu6J
XNleDavmafRSD4jdc3szF6Eicqic8jZsQEsiUNhIwIZgfgapgCsi4RycfvZzK/+H
82dZ01NAGTg7ZUiKWmBy
=2MfE
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
