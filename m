Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 19:48:19 +0100
Message-ID: <7229903.vTJUiGXDOz@sven-edge>
In-Reply-To: <20161006064142.20003-2-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5409712.2pjNUcSGPc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Keep hard interface
	neighbor list sorted
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

--nextPart5409712.2pjNUcSGPc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:38 CET Linus L=FCssing wrote:
> +               hlist_add_behind_rcu(&hardif_neigh->list, &pre_neigh->lis=
t);

Compat code is missing for this function

ecsv/pu: sparse linux-3.16 cfg: BLA=3Dn DAT=3Dn DEBUGFS=3Dy DEBUG=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/bat_v_el=
p.c:96:9: warning: Variable length array is used.
    /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/originat=
or.c:594:17: error: undefined identifier 'hlist_add_behind_rcu'
    /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/originat=
or.c: In function 'batadv_hardif_neigh_create':
    /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/originat=
or.c:594:3: error: implicit declaration of function 'hlist_add_behind_rcu' =
[-Werror=3Dimplicit-function-declaration]
       hlist_add_behind_rcu(&hardif_neigh->list, &pre_neigh->list);

Kind regards,
	Sven
--nextPart5409712.2pjNUcSGPc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRk/MACgkQXYcKB8Em
e0ZzDg/+IONt2aIe7vGh0HVQGQ/IWHeI0wADYBzWMxITb1Fl8Mqw1dvg7N2RenCo
F+/0HCxZ1cgGwQPcyMYPoew6VIqoMOenAlcTkaMtfbsuIN2HdI+qJDvAaXCkhhq3
lslVrTg+oBp41N2VNnWgkKf6HdyQ0vVLl5T9lgdJPQXN6/XaXjn8pxtr5aqJ2T5n
fDiWLx4vtvN48Ty8qt5T64MXUkxfNnbxiFZxnDrtXH6DB/6DMUNQKgZIyT2cPvUb
lL9W4lFUGIRniUamm+DiBm46+qI+x2j4jdCT8FFrczHUxV+1E1rgooEPw2qvZUF8
jC9FWKs5zTW9cPhcBwiCNS7GBJHpHLtLisYPLWg7ypF9DGLj56Usdsi1fLaKtai8
jqWUEsaGscjeq+qpbBCcxeQryqACwIihWIhpLtGlYkT+3+qqxtOG55fGir2U5IF0
oaAQEgSeZmVckcV2GAfwkQi5xFcY8mj/SZ5eJl0wFnL9+KjBsYm8qRI+PB1YRnDa
VhcFhJ+qooxwm5U7t83yBzNKuSnkAETIYzD3dXIvJRL7hcxNtXFoQmdrSzUjXnGC
blBRlFGbxlC92ZgzXvmuz9Pun0tOqQiok15kJ4YK7rAB+XXn/uIvpj0BMbhqLxkD
wZRDje10GJQJL6badgamcNzrW5EmmUO+Em4YZa6dr3e1T6P2pXI=
=eQTA
-----END PGP SIGNATURE-----

--nextPart5409712.2pjNUcSGPc--

