Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 22 Aug 2017 08:59:15 +0200
Message-ID: <2470987.7o5QObroCJ@bentobox>
In-Reply-To: <CAA_JP8WCg+FVRdwYrqh-LS4Z52_rNHV5NkZwjRwS7Rksns7h7g@mail.gmail.com>
References: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
 <13544673.RylKELaqkV@sven-edge>
 <CAA_JP8WCg+FVRdwYrqh-LS4Z52_rNHV5NkZwjRwS7Rksns7h7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2921569.OBMIyfngqO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman on top of vlan?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: dan <dandenson@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Antonio Quartulli <a@unstable.cc>

--nextPart2921569.OBMIyfngqO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 20. August 2017 11:52:24 CEST dan wrote:
> thanks.  Just to clarify, batman-adv 32 bytes, so to stack vlans qinq
> I need 32+4+4 so 1540 yes?

Seems to be right.

But TT doesn't track QinQ clients with two VLANs (it only tracks the outer 
VLAN). Maybe Antonio already thought about possible consequences.

Kind regards,
	Sven
--nextPart2921569.OBMIyfngqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlmb1kMACgkQXYcKB8Em
e0b3DRAAhI5FUl3gEynzLTtUqaVoZbxplDVVEs2NInYffELStYyIKNlSi5IgljAJ
jLW+LKpMBbKhCS+W5kdjdkiQM5k5Tv56h8XtdLgaELjqzmXzW5JkoZ3gT0HixIkl
wBsfV27x+2nqvXBINVajdxow6xmK73UzIOuKxxUzS4Hi/6beGRw9DheDP5a2Uzkd
P5p4u8MPqP8z5Hsrsbv+tIA/iX7aYq6s9aQzff1QSuwg2o+8emZzlDichSwyyGmI
c1A+RSxL+1vQMfdXTpPOjK4Oig4Qi3D8f2SJdvxIV9k5OQZhPbFWO9TlmGHuXLmh
nbJJiHTdx1/E19WkhQRlgXUOv1ZIMPbay45jMPKjevzV947ujcnP9th++0QvUXZB
1PFMCLhEwn6JoTdRGNy/RMXAqzMUDIwRUEPhnBY/fF+hSI//H8RVwoiZ1Gti2qW9
F4fGhjCIK6UahuRgFpebRj4yy2g5TVLUKPBatWcwxZcziLo+O85xwkzFpDCVbaBx
YL7cqxbTzQ+zcLEKmTyOIx2WaWk+YPDsA4DKqdWCG3iR1NiB42tFzWKiTbPLKeVi
Jz+93QAj9iKgiQaQOec5fbyB2vx0Pa7yg0l4ExGiDVyRmBvos0fGXjPtReMsAxDD
NykUQl9QYeucduYVegLRf0iAZbfH/og6ZZuPa7gb6TyOBgRqtl4=
=ouvJ
-----END PGP SIGNATURE-----

--nextPart2921569.OBMIyfngqO--

