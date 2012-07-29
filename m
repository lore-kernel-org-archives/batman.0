Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 Jul 2012 19:49:28 +0200
Message-ID: <103358323.nGoy97EWao@sven-desktop.home.narfation.org>
In-Reply-To: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
References: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12562556.7yIp170ZLG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] RFC: Migration to a new git server backend
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>, Spyros Gasteratos <spyrosgaster@gmail.com>, Marek Lindner <lindner_marek@yahoo.de>


--nextPart12562556.7yIp170ZLG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 22 July 2012 01:43:25 Sven Eckelmann wrote:
> 1. 1 repository per project
>=20
>    use only one repo for each project (batman-adv, batctl, batmand, .=
..) and
> use branch namespaces for individual users:
>    * master, next, maint for the main stuff
>    * ordex/ (for example ordex/dat), hundeboll/, ... for users
>    * tags only for release team

The vote ended with candidate one as winner. I dedicated my sunday to t=
he=20
migration from gitosis to gitolite and think that it is now in a usable=
 state.

Following repositories were removed:

hundeboll/batctl.git
hundeboll/batman-adv.git
hundeboll/catwoman.git
marek/batctl.git
marek/batman-adv.git
montik/batctl.git
montik/batman-adv.git
northpole/batctl.git
northpole/batman-adv.git
ordex/batctl.git
ordex/batman-adv.git
simon/batctl.git
simon/batman-adv.git
t_x/batctl.git
t_x/batman-adv.git

The branches were migrated to the main repositories batman-adv.git and=20=

batctl.git. Simon Wunderlich, Marek Lindner and I have full access to t=
hese=20
repositories. Following users have full access to their own branch name=
spaces

refs/heads/hundeboll/ - Martin Hundeb=F8ll
refs/heads/linus/     - Linus L=FCssing
refs/heads/marek/     - Marek Lindner
refs/heads/montik/    - Edo Monticelli
refs/heads/northpole/ - Spyros Gasteratos
refs/heads/ordex/     - Antonio Quartulli
refs/heads/simon/     - Simon Wunderlich

I would like to ask these people to change to the new repositories. All=
 URLs=20
to the non-user repositories weren't affected by these changes.

Kind regards,
=09Sven
--nextPart12562556.7yIp170ZLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQFXeoAAoJEF2HCgfBJntGV80P/i/iJvIlq3lFoRWnIJnfKQOR
yYdTkgps+b13ejhlwSgo2AOLDEJNzQYs8RNVat3VEQBUgVqQE/NO6dUrSIFvOcwY
65Js0TWPhkPadp6NhoQqZKJUw5gwo7H2GUonn2XUan2eXfZdqdtYBXb4uRFw6khl
+fEivta0egLW4yJsnLCd/+YXZn7nlQaD7UXFHVJIZCnXRG3JuEAaT2U16iZ6GFcd
OiMpfiYPMyRQqpivNnbF1SHwy6Q+H2GgvkufCEufO7AcuziMQTUJ7eA1tBjdRmXa
zyJkRYB2D+CSMU4OK4bNRt7vqKCGRPECG+5Z7lYLKNQksBCsm/muQfQVIjzMKMhg
QjlIUmWWMygHGtgT6xJHYMyLhddi5+X+b0aEwsajq2Vfq3AOLbVVi1w1dAQOgSVq
+Nn2et92JO9nFYSKpqd5p4EgFxdpFvcn3xj9fcKUd8+tQ8xRUNbjQxxjO0Viyv9e
BHOO0SM5lv8KBlOFbS3IRDysEGrjnTBgiy0ulhO1UF6+3xMUsFoSEdtQz10f5bD/
zkD8RI3RjrQ8wllavzw8S5kqGi1j4dAts6+MnDZKoavuPfTVUshQbbzAmP+OFKBu
7W7dism4j5JYV5eXh13jbsZl8TNiRBS6jAnC9Cm3PenKHM9iOB1A/Kelu59IpFkb
pBiOuRO5/IuXRF3YI4O8
=j1y9
-----END PGP SIGNATURE-----

--nextPart12562556.7yIp170ZLG--

