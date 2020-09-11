Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Date: Fri, 11 Sep 2020 14:01:02 +0200
Message-ID: <2850909.jKhAPPOaAE@ripper>
In-Reply-To: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13196327.JHk6ruZ3ot"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Alessandro Bolletta <abolletta@netter.io>

 
--nextPart13196327.JHk6ruZ3ot
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 11 September 2020 12:48:52 CEST Alessandro Bolletta wrote:
> if I pass tagged ethernet traffic inside a bat0 interface (without
> creating an alias that uses the linux vlan stack for transparent
> tagging), is this being allowed by batman-adv?

Not since batman-adv was made VLAN aware.

Kind regards,
	Sven
--nextPart13196327.JHk6ruZ3ot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9bZv4ACgkQXYcKB8Em
e0YrhBAAw3rlsWjMOrJgkUWYsUWgicf2MpSVdLAvwua4tDTbY2GfgQ9kT1kuKqRo
Q4Z9rRx4dX9cq9N4j5GLdsyaBUpbiiTqMVZAD5No5C4vRWf8KPz1Gii+1UMS0aD/
oqeCzMNscGlJKmX81SAtbsMtffyoo3sJ+aS8ypl9aU8pfgpLCxLEwuKjRFbxmKGk
qw0ta0p0UYb5SbLBFIGdaLiJbmZ2jIv3dnbQIFUfQZuXapQtOFJXjO7jCU5B1Ga0
UaGaUEKxQzINvMXZwGtZrs+3yPqLAS2RXh8LhzbE/Y5U9C6m84ZBy80pYrAgT3KJ
vQ/k+r5e+IMvZu18CNTenF7QQPc+ame2sCubsNMJJI6roLV3JHx8yx6eq0QyAly6
btTLtyR2R9lnpiVq7JYJv/K6cGEmJc3PVpMtfPG2uYgTUtQBFcd19ON2Sqk4bwIj
9bNGY5JyQG8dtU82oX2Z1z86BJRsoj0JR8LrToTa073PLrfFXesNPlExwy5Cc/G4
kTJb0kzhP+r9PYVYE6i7pAgQNbYTmn/wPQy0AKWmd0q6BiFI+72NxXKrVbnpbltO
yEHzMGgS22xzMJKRzNOdIJUcpon7FnXeGetOo+r8d16pNJ4Cc5ul+pGiB7133aRa
fkgXqjEdzw9SoLb4nTf00vf/TuRCDcjLpV46QuttPevSXDN+a+Q=
=5+jS
-----END PGP SIGNATURE-----

--nextPart13196327.JHk6ruZ3ot--


