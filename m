Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: bits 10 to 15 in OGM packets
Date: Thu, 25 Jun 2020 16:06:38 +0200
Message-ID: <1752987.3nn1Mqi339@bentobox>
In-Reply-To: <CADhofF8ExwW+kYPDTX1W4ZZz_6gs3zEvzu_7oe1WrkP3-+fpiQ@mail.gmail.com>
References: <CADhofF8ExwW+kYPDTX1W4ZZz_6gs3zEvzu_7oe1WrkP3-+fpiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20168081.oS1hcQqD1i"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Rahul Bothra <rrbothra@gmail.com>, Tom Henderson <tomh@tomh.org>, tahiliani.nitk@gmail.com

 
--nextPart20168081.oS1hcQqD1i
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 25 June 2020 15:22:46 CEST Rahul Bothra wrote:
> I was going through the Internet Draft for B.A.T.M.A.N, and wanted to
> confirm if the bits 10 to 15 in the OGM packet are supposed to be all
> zeroes always?

Please don't implement the legacy draft which was never finished. This is 
really, really, really, really, really, really, really, really, really, 
really, really, really, really, really, really, really, really, really, 
really, really, really, really, really, really, really, really, really, 
really, really, really, really, really, really, really, really, really, 
really, really, really, really, really, really, really, really, really, 
really, really, really, really outdated.

But the batmand layer 3 compat version 5 handled these as reserved flags. So 
it would have been a good idea at that time not to leave them in a random 
state and just set them to 0. This would have allowed announcements of 
additional features in the future.


See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
include/uapi/linux/batadv_packet.h for the B.A.T.M.A.N. IV and B.A.T.M.A.N. V 
layer 2 packet definitions.

Kind regards,
	Sven
--nextPart20168081.oS1hcQqD1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl70r24ACgkQXYcKB8Em
e0Y6/Q//dDw8T4rQLMmUHZ9Np6omSmX6AIE60C80wK0AWG1QZNYx3zj6hvl8gOIA
ACZQHCFZkwC89SqTaHWWeNVDun0fbavvqcyK+tEZRtC/QVi0Y7qdvrxSbYYIOKWj
63GkOx5YslZCQIsI5V+AKZ3dZ5rHVju+XCQ7/bcYb1pzOEQoQndX3r+HFe7ZUa/L
E6LHVe879wbX3C3EvTtRl/KQmSj0U+/pVFhshwlBddwxwMiyB1svv3U++Tzm8HmB
rmakXpNsqlvy6dPLHRoZwffIVabN+/Gnb7Qssv6dJCChMSxVKZ9V0M7D7GZyeVRV
eLCXQ+O9kT4EBZv9TvYQr++nQmWGpg1plAJceZae/gmPiTHbpvMmLjxJWXDI2+p3
2YYL95gC70rC2ePMNkWs4SiLhzM7zJ3/D29jN9Oq4aKTE7zQw91q0I5k9m+lHbAa
i5SKxE8sbYKd59nAMR0HwioOS5ku81tYtw2KY0CdYedYn7JTfkGw1x+r9wk40xlV
RFIbTnezCaw7/rRDcpD46sJgUPsVKZ/0KPZJHly+UT1rDZtSqKTGIrEPChpWtGZc
P+Nz40UqVGU79dvUOnbN+OePdR/LaFYb9IwZioWa0bEugf2FxduV3TqAbg33uFEj
EWfqb31fhG/rguBJjQjun+h2KcWB8tZOqi5VM0zyAYmjrpIVcgA=
=twgQ
-----END PGP SIGNATURE-----

--nextPart20168081.oS1hcQqD1i--


