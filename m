Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: batman-adv: User defined nonce in packet header [was: batman-adv related query]
Date: Sat, 30 Jan 2021 10:36:42 +0100
Message-ID: <1708045.1bVLHfgjVF@sven-edge>
In-Reply-To: <CAJZjC1surX81hwZLchC6jfETiFGE9F1tZbUJKhbbwE7Q5UOqXQ@mail.gmail.com>
References: <CAJZjC1surX81hwZLchC6jfETiFGE9F1tZbUJKhbbwE7Q5UOqXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9597460.aHTAh1YC2F"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Moullick Mehra <dedamamoge@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart9597460.aHTAh1YC2F
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Moullick Mehra <dedamamoge@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: batman-adv: User defined nonce in packet header [was: batman-adv related query]
Date: Sat, 30 Jan 2021 10:36:42 +0100
Message-ID: <1708045.1bVLHfgjVF@sven-edge>
In-Reply-To: <CAJZjC1surX81hwZLchC6jfETiFGE9F1tZbUJKhbbwE7Q5UOqXQ@mail.gmail.com>
References: <CAJZjC1surX81hwZLchC6jfETiFGE9F1tZbUJKhbbwE7Q5UOqXQ@mail.gmail.com>

[please use a relevant subject when writing to the mailing list]

On Saturday, 30 January 2021 10:25:51 CET Moullick Mehra wrote:
> Is there any way to add a nonce value to the
> packet header? The reason being that I want to add an authentication
> mechanism where the firewall permits only selected headers that have
> this nonce. Hope this makes sense.

Not with the mainline batman-adv. But you can always add your own changes to 
your code - making it incompatible with mainline batman-adv.

But I would highly recommend to handle authentication on a layer outside of 
batman-adv.

Btw. "nonce" is a "number only used once". And you wrote here that the 
firewall only whitelist one specific nonce. Which would imply that your nonce 
is not used only once...

Kind regards,
	Sven
--nextPart9597460.aHTAh1YC2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAVKKoACgkQXYcKB8Em
e0buSg//SKAmti2Z5h9tmTjHrgQHvfkqC6nf4IxugxNmlCq3Vt3goFEpm58PppNT
6ONsIMLgGceLkH7YHMDRhXg6uUuJSlkFpcvoGtc1nlEemDVQEBJzrwtTIBjoy757
9ym0bpi3dIMqzf5NET5/GocJTQNt1CNE2EFz0FlySNqRylBcwgIp5p8AurnEnLg7
/hvZ3MRn10z0WH2+g3UbcBelgNyVGpK9ZLpcVmL2f2PCdx1dP09FZ7tuUFt3oChJ
VTwwNZfRyvSh+aj/VpfHz9Eel23nLMHBkxDqBqOux609ML/tuhHR/2XU1IzEvV+b
vpE/ZGKfvE/gQ71ezIT29P0AqSF7gY1HmjjH8fpZdsWwXqZuoSle6NrY0nmS8ILE
7ayHPH/UdGW1JRqt4lbAlsVz2ip384qrPDRCau0TJVtWM5+nbtp1y30cJho/dEvl
8emhnxBG4jHUeBjs1O+y8qWxj0rErDL4wK+iUt7LnDRgVxaOUhpPBRA3xGpy4kFr
MjAuZPQBMwSuGUqL2ZBdX0q8ONBK3dt6cz6w48k88lmvi23eDIXj3oOUE5PkRAgu
PxetbefMD/Xzhm7PaX9IvtAcA/fwfR/BhVGfY4hDgLCIlokUs546SdsIBNS4+1ED
HOVpl8hWO+OrRKsPfAVi2QWPZZqCRzQcNcXoQ0/ezKccLVxz9B0=
=wFrx
-----END PGP SIGNATURE-----

--nextPart9597460.aHTAh1YC2F--


