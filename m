Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Feb 2019 09:22:53 +0100
Message-ID: <50037565.hLq9mJvEzh@bentobox>
In-Reply-To: <CALYz8yqCAkcrvjcBhgf-2YYTrejhEXnnbRWP3bCtv-joXfP3jA@mail.gmail.com>
References: <20190224165113.15726-1-sven@narfation.org>
 <2667717.mmYbNj13ue@bentobox>
 <CALYz8yqCAkcrvjcBhgf-2YYTrejhEXnnbRWP3bCtv-joXfP3jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3194159.aSf94Evgts";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC openwrt-routing] batman-adv: Split batadv
 proto in meshif and hardif part
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
Cc: =?utf-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= <klukonin@gmail.com>, openwrt-devel@lists.openwrt.org

--nextPart3194159.aSf94Evgts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, 25 February 2019 09:03:52 CET =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=
=BB =D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD wrote:
> But what about ELP interval parameter?
> As I think, it should be covered by UCI config too.

Please first provide a batctl patch to support this setting. Then we can=20
discuss the uci integration.

Kind regards,
	Sven
--nextPart3194159.aSf94Evgts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxzpd0ACgkQXYcKB8Em
e0ZtzxAAgf2wG1ZkEdvHb19SjA17QKpV/NEe+M5y9HCwzammqRy9iqeIzcuHzHMi
/OfghmBGpoiY/33BEEoPrc0/0aNC6uS9K1G1rS48Nj+EZFuN5ARtWe/CLrd4CB4q
9iKs6Ca7Am+4NNLTAF++/a2zOkCjLd59gQ4enX05F9t1Fw8di3pzE3Ouyj3vJRnb
aoRoVQdwf/TsKInkeHFd4jujXwhDyTfGAy6mvkATrEPQh3kYmrX65OmzsXOYFHhW
uep8xnWQtabvLJ1NC9rT+eLJ3N60LfHKywxUuUmmNaprRxVLEyqh7RMiPQtox1Yz
fsTEtEDpDTTX+zayfJBtn3R7dOUfX91IitnZa+GKBlhSnYKbf3ao4h49bcrRGJ7z
Tmp7p9wy1NCTo4c9MYgJs/yV59iJBXw8zVlcWO4j1OLjyKlT7w7KkxBtFfUy4owX
qLf1Am908XOvXKbgbIYi5TcDMpAKXHoShao+QdvAe/xhtud5EBP3m2l3tx6mzxA4
+gtWW4whJQjdGj2hpiGsJToSqxZ3DKjdEQa0XveJqoWqUS6AMEP/75KqugRZFv19
ZOXMfKm7UXrWG6kfYC5SZ3kks+gZF+MK0tVEHQDG/kdirDi2Uu5pHePdK2wYLH7y
FR2ZMjeFPkMiXRjYegFMvHfUYs5/sZBmo8+gjMpLoyBnKS0cPEY=
=wav4
-----END PGP SIGNATURE-----

--nextPart3194159.aSf94Evgts--



