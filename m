Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 23 Jul 2012 14:08:25 +0200
Message-ID: <1400466.YNqhOhO1a1@bentobox>
In-Reply-To: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
References: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2695843.Bfbx76XdSy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
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


--nextPart2695843.Bfbx76XdSy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I was just asked whether the repo urls will change. I can only say for sure 
that the administration URL url will be changed. But to the rest...

On Sunday 22 July 2012 01:43:25 Sven Eckelmann wrote:
> Now the question is: Do we want to use this feature or not. We had following
> ideas:
> 
> 1. 1 repository per project
> 
>    use only one repo for each project (batman-adv, batctl, batmand, ...) and
> use branch namespaces for individual users:
>    * master, next, maint for the main stuff
>    * ordex/ (for example ordex/dat), hundeboll/, ... for users
>    * tags only for release team

I would like not to change the repo URL for the main repository. The other 
repositories would disappear and therefore their URLs get changed.

> 2. 2 repositories per project
> 
>    use one official repo for each project (batman-adv, batctl, batmand, ...)
> and one for other people
>    * master, next, maint in both repos (synced from the main one)
>    * ordex/ (for example ordex/dat), hundeboll/, ... for users in the second
> repo
>    * tags in both repositories allowed (but in the second repo only with
>      user prefix)

The main repo would have the same URL as before. The other URLs get mapped to 
the second user repo.

> 3. 1+x repositories per project
> 
>    Keep everything like now
>    * master, next, maint for the main stuff
>    * each user has his own copy of the main repo in his user folder
>    * tags can freely commit in his own repo

We would have the same URLs for the repos as before.

Of course, if you have any other ideas about the folder structure then please 
discuss it now.

Kind regards,
	Sven
--nextPart2695843.Bfbx76XdSy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQDT65AAoJEF2HCgfBJntG9P4QALXT4KwWGdYTuLaJvTa6FauQ
v3YccnO+nwH5T+0FE2D8VPNTsm1Q2p0uK5jno06A9JCKMridvtPBME0TNF9yK9yj
mgXFpFYimcY/3HH+5r29IlWJ+CrvlzSdiK2EBbEL+0zEPFut6KUKjHTaEUOp8LFL
TUzfSLvvRFrqsZqLpqqn4CSj4z1F83pBRS7ks3XiF4AnJeop2AM8Ej5lYbHf6W+S
k6lOx1O3rO5/5Aj+00FUZCNtnLRePiYZgQivPwFsAMYNcSMNpjGtscBKheoom0Vf
dLEZilIaUys0QcOborTq1w7L4Ys3lRM/rFcCBUHUu6tLOYLwgnSUwxugu0P9vmD5
zKcCyUkiDDOqiokRItxudgZX+6ZRoy+HVgk1L51QdwhMqUCpyasvzYikjQ3Bkue1
wPoV2LhN08dXQTLQwvedP55zXoZ1veqb5ycWcshTKLEcNdsnpodysJrU5DH3oisw
K5jiKi0HBjUgI7dC5a8vrtamlI4T+f0cIh0HGB9I/XYQ3y8HMT9uF3/zR10e1T6t
IDRfHtU5BoUMWoq2zKsEcyHuU9db9JQAvnkIgeozpULiP4sLmVzM9jYqu0kpsLbv
Vjt4cLW2UxgbB5eGOPPTFtkJDVBcICJFa8upzFWE/yt7MyAAw0bHzIeIdnunCSWE
tKndYDAcBJ5sVO6aPBrB
=fksR
-----END PGP SIGNATURE-----

--nextPart2695843.Bfbx76XdSy--

