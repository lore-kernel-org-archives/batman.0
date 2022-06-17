Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Question about batman for ARM
Date: Fri, 17 Jun 2022 10:45:48 +0200
Message-ID: <3826484.QQW5a1qdB9@ripper>
In-Reply-To: <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <03ca01d86c61$6781b190$368514b0$@creonexsystems.com>
 <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28061830.WxQH19I5H7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart28061830.WxQH19I5H7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Question about batman for ARM
Date: Fri, 17 Jun 2022 10:45:48 +0200
Message-ID: <3826484.QQW5a1qdB9@ripper>
In-Reply-To: <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com>
References: <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com> <03ca01d86c61$6781b190$368514b0$@creonexsystems.com> <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com>

On Friday, 17 June 2022 10:41:46 CEST cchien@creonexsystems.com wrote:
[...]
> We would like to use batman with a custom radio and are trying to figure out what part of the source code we may need to modify to allow batman to work with a custom radio.
> Custom radio means that the radio is not a commercial radio, such as wi-fi or Bluetooth.

batman-adv (especially with the B.A.T.M.A.N. IV algo) only requires that the 
device itself can transport ethernet frames (with proper unicast and broadcast 
behavior). If you need something else then you either need a virtual interface 
which does the translation from $whatever to ethernet (and back) - or you need 
to reimplement the B.A.T.M.A.N. IV/V algorithms yourself.

Kind regards,
	Sven
--nextPart28061830.WxQH19I5H7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmKsPzwACgkQXYcKB8Em
e0YJiA/+N7SuPuxSwnnsH4cXFtIpfH2xuSrs1777A56CsY/XZsqFYCaknf2cx0a4
XSNHbRF48Pd+tjJlhuSTeQfdV+y2RRbVQHImcorgLBcL4M0Z2aBG768lyf5DOl3l
jGMcby9aUmoL7GQciHrDsU2c6NhhHZRbLeHDoCNPnUUsg4ipGPLaQ5KoYHLe+9vf
mQNXa/EmRqhxU4L7qolCQDeOURi2ueykpj2bpdlw1avVQL6zFo7X9my1t5tPOJLr
gcEqpEshTeBrj1qIDsFEiobQQknOsPpBQGa08X4Zrv7W/qqA6R54gDKtHQDQvedb
/iykv1DIJVHMNwMcnKahfYTV7LjK7d+YJNP+b5I7zuLcJY7G6muPgMh2nuRAqUxJ
W6OBGKDFrv6k3R6O99zGDsX9gA+bg/0fp/W3zJ3jb2DhJr1+yAqg2mTZw9BHz3Aw
Xhhga28D6dc5ymgvzF5740s/dKEcJ0gZJe880/3VsbHjxtDoYXBE+wTtizQ14HrI
N7tECkY+z3mQ0QucGn5vRoLz9giQe+sQ+UrooTIFY1cQ4bjY24sjRuk4R202JQ/h
9FxHRLorpEXe4XNEYu9lilIhm6xCqQ0JVQ66r2o81zd/Vbh5ATkF22GSRzxOCnyw
eigMbnzLAB7ssw2AsY7IoeZydmTMDCZ0vB7TqFoXRxJvVg1WMNg=
=t3J6
-----END PGP SIGNATURE-----

--nextPart28061830.WxQH19I5H7--


