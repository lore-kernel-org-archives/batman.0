Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 Jan 2019 08:37:10 +0100
Message-ID: <3036280.VRa4Vx8K96@bentobox>
In-Reply-To: <20190107185712.GD5399@otheros>
References: <20181207203209.22633-1-sven@narfation.org>
 <20190107185712.GD5399@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1661098.9KF6M8RRKR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/20] batctl: netlink restructuring,
 part 3
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1661098.9KF6M8RRKR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 7 January 2019 19.57.13 CET Linus L=FCssing wrote:
[...]
> Is "batctl if" supposed to use netlink to get the interface status
> yet?
>=20
> Currently, with the items in *_attr[] in sysfs.c in batman-adv
> commented out, I get these errors:
>=20
> ---
> root@Linus-Debian:~# batctl if
> ens3: <error reading status>
> ens5: <error reading status>
> ---

Not yet, but I think we should switch to it in the near future.

Kind regards,
	Sven
--nextPart1661098.9KF6M8RRKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlw0UyYACgkQXYcKB8Em
e0avdxAArm8GfQUUWh3YKJcjGSNClnH5pHhIiXu4z1XTxawOgKbvlWc0DyD76oSm
1pADqDYFMIEIukBF/3+/nkB3HaOSeXTZtGlmXNZ26YqITwi/hE7YeuSfkO/hwYlN
MBdxwDMGZzIli6pE7sQU2LWVeCEbRE3lPLSY6iqtn9lI1DtQX+Uz3+NdfzUENcO9
xUHFMDoM7unDskZhUmyBgSp5qXls5kgB+22ZiN/Dre7lPjzGPoz5+vLYnrG373b7
nKNG+I9/yQ8HCVenwStsaBLBraUwi6/+qx6OVIqdu7peUsdtFys7E2suR533ixwe
m35MIZ2tLtrFxXxNlTzOxD8j3kNPGVKDubA3Cb7uNGxSZCq52X1oSk/jidOjlV3e
86WyTlO0EQizgcgAKaSOyNYTKCwhKU6T/eFabxR0X8E+31YFcynwtwdKzGkjSEWr
NPtmFuGX6my2xDYnuFGOm0Cm66S9FBnt2omPk9ALkTJBOkdGavG5Zi8zfJSMkEQM
+XECuu1fNzNOlf9y/HvQbdzAJFGPCVnAXGYb3Q/H2CqveGQ3wcTGMmBQ45WuG//G
Q8Hzbi6FMUEzqlJujqDu7HAWVAkBoayv1i8409G2xGzhFEfqatdHqKL+aB336e6p
T/wj4+YBH9CQcwIu+fqNddOcQKBf6Wop4tExmMo+DhtWS0CKLCk=
=BbKJ
-----END PGP SIGNATURE-----

--nextPart1661098.9KF6M8RRKR--

