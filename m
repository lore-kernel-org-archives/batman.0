Return-Path: <a@unstable.cc>
Date: Thu, 12 May 2016 16:57:49 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160512085749.GE21549@prodigo.lan>
References: <CAKOC6KQMSca-tSOoKFm9t1LXrOnwHKbf3Ac0hXT6QZWxM_uwtw@mail.gmail.com>
 <1588847.AaxGtfAtFh@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <1588847.AaxGtfAtFh@sven-edge>
Subject: Re: [B.A.T.M.A.N.] Problem with DHCP on batman-adv V
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2016 at 07:05:20AM +0200, Sven Eckelmann wrote:
> On Wednesday 11 May 2016 18:58:48 Alvaro Antelo wrote:
> > Hi everyone,
> >=20
> > I am testing batman-adv V5 from the development feed on Chaos Calmer
> > and so far everything is working except for DHCP IPv4, only static
> > addresses.
> > In the same setup wich involves bridges connected to bat0 interfaces,
> > if I change only the routing algorithm to batman-adv IV, DHCP works
> > fine.
> >=20
> > Is it a expected behaviour?
>=20
> Afaik there is no working gateway selection logic in B.A.T.M.A.N. V. At l=
east=20
> Antonio works on some patches for this:
>=20
> https://patchwork.open-mesh.org/patch/16139/
> https://patchwork.open-mesh.org/patch/16140/
> https://patchwork.open-mesh.org/patch/16141/
> https://patchwork.open-mesh.org/patch/16142/
> https://patchwork.open-mesh.org/patch/16143/
>=20
> This includes splitting up the logic and use the metrics for each routing=
=20
> algorithm. But I think he can tell you more about now works (or doesn't) =
and=20
> what will work after his patchset is applied.

Sven was right. In our current code, the GW selection logic doesn't work wh=
en
using B.A.T.M.A.N. V. We are working on it.

Maybe you could try applying the patches suggested by Sven and let us know =
if it
works for you ?

In the meanwhile you can just disable GW mode (batctl gw off).

Cheers,



--=20
Antonio Quartulli

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNEWNAAoJEJ4aZjxxc6bK50kQAKZLL6TNlz0XSMiP3/LSBTaX
acDGQvjN9vL8+LfJY6TDgIdKk/ZduNZEYk6cqWNYmu46QTnmIte7F2ST/uzPbn6H
1SjCMrUR7Lbe+6TCZBfFzeb8pn6r5XDUKyTQH1J6I6OXYu9IQSheHx0ce8Txgl1M
fzZOaFtxNMR2dLdMc6yEttnwbii8gWFjqqZU5+q28X43V7PrHE1zGdUUWmjFeuic
8+vUkH60gRbbqlghuVTqQdr+hAlK7ujG2EP4Tl/A9zPP0BMrOH7Exa4WLtmRJ1IB
37knJ5AAlF13WfqUyhmLFgfYP4AE5gkIKBesHUl94bW903Qd4/Uaa+XXLrWKAToJ
SNIiCthBfZNwTXWuodJe8wXblKrTgrxgOM/2thFFI3/b8blpzYiXKEv99Y4+OP5V
CRm6ZYAfvkDZJ6Ks3GFqK6ryyCZg6K9bllFahPWEKAt90dkUXrprWbWoHmNGo4ls
GNsxfESuNLKZqVQw0IGrZo0J3cuvQenz1NAvgj4gLo4Pyj9hXvSElSvwy7aPxUwQ
qvdbpmDr8TN2XHxmeDvgjxf3QWjnUkdiCfO38cwNgS3Z0M48TxV/hcoav9gBtdh7
Ick7muMudR6hjgmVHbkZDI/SUwGxwUC95Zdkd6CY4YHUXXXEAXrkYiX5Gj3dUA8x
X7G+TaFQY8jPAi0XZDOj
=E36o
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
