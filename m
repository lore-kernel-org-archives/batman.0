Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Apr 2011 20:16:18 +0200
References: <BANLkTinVGKaEjSOgHrsXN0E8BRzKzuCQWg@mail.gmail.com>
In-Reply-To: <BANLkTinVGKaEjSOgHrsXN0E8BRzKzuCQWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3322926.HazP9ggeqa";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104222016.19810.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Changing bat0 mac address
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3322926.HazP9ggeqa
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Gioacchino Mazzurco wrote:
> Hi!
>=20
> Is possible to change bat0 mac address?
>=20
> There is some batman-adv specific way or i have to look for how to
> change mac address on a interface more in general?

$ ifconfig bat0 hw ether 02:ca:ff:ee:ba:be
or
$ macchanger -m 02:ca:ff:ee:ba:be bat0
or
$ ip link set dev bat0 address 02:ca:ff:ee:ba:be
or
=2E...

Regards,
	Sven

--nextPart3322926.HazP9ggeqa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNscXyAAoJEF2HCgfBJntGdGgQAIYvVklQpzPaH6kw9uxDINyA
ji08p14glqMneWQMztJwAa7GW7zSQW4sJE9GY5ViZAi1kRPtT3n1rbF4bsGXMlXL
eaUH7PDAyL1ZcvcZRCte0rq9pivk4nvWkQNWgxwy7UFdBru4ipwmHxrQZo6lIOMQ
VnKTzJZCoOvts2zSJxZxTv9WNiuBNWOfE71CTnSSh5A7TTyaefDaMf0fsO0LCiKJ
ZE5g5Gix2FjeQoz7isaae+2Hi87r7CPO/+d/EmfaK5qY/m57VlZK0PbyLKikndCg
VJLEYntXblxCsmKoFwSl3r/WhcmiDSlRcvJiwi5q6bcUKHgSgjdSqpJlU98fpcJc
7h3eqW63fuGcYNgSqqkGKXGg8AVt5d9NZA+AaMEWiTVDV6bH9jTbfW4g3hVv+eO2
Ei9SKRHdI9ODxx62MyezsLla8LC04sAfw9VvsLvYUd+vN5UslBJ4XrPJ042rm3pM
wbTH5QS2WlHkZ9/jygc5g7n9kyb7qMDBMtPscWZFPTsyl8/iymfpTvni+Wp9Saee
GQx3Ii45pzuVJ20w5CLcZtt1GZYFcKNcukM67XWCXdEyhwYSO8cUtgtMNgXMul6w
GH9XLrLY7tC4sPyqR8cJX96pMJz7Cu1buYzb9FCjVxpIBi7QIM5MyCk+SwhIPsmm
BokozvoVpbz/uKtExMn9
=zvnB
-----END PGP SIGNATURE-----

--nextPart3322926.HazP9ggeqa--
