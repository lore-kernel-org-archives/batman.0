Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jul 2012 01:43:25 +0200
Message-ID: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1662757.DZoEmrFK65";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] RFC: Migration to a new git server backend
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


--nextPart1662757.DZoEmrFK65
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

maybe some of you have seen that I talked in the channel to Antonio whether we 
should migrate to a different solution to serve our git repositories. This is 
(in my opinion) a good idea because gitosis [1] (the software that we are 
currently using) isn't maintained anymore and will be dropped [2] in the next 
version of Debian. My preferred replacement is gitolite [3].

I already talked with Simon and discussed what side effect this could have. 
Maybe side effects is not the correct word to describe it... lets call it 
options. Gitolite allows to define access rights for refs. For people that are 
not familiar with the storage in git: You can for example say that people can 
only commit to branches with a specific prefix.

Just to give an example. We want that only the release team can create tags -> 
refs/tags/ is only marked for the release team as read-write. Now we have more 
interesting features like ordex is only allowed to write in branches starting 
with ordex/ -> refs/heads/ordex/ is marked as rw for ordex.

Now the question is: Do we want to use this feature or not. We had following 
ideas:

1. 1 repository per project

   use only one repo for each project (batman-adv, batctl, batmand, ...) and
   use branch namespaces for individual users:
   * master, next, maint for the main stuff
   * ordex/ (for example ordex/dat), hundeboll/, ... for users
   * tags only for release team

2. 2 repositories per project

   use one official repo for each project (batman-adv, batctl, batmand, ...)
   and one for other people
   * master, next, maint in both repos (synced from the main one)
   * ordex/ (for example ordex/dat), hundeboll/, ... for users in the second
     repo
   * tags in both repositories allowed (but in the second repo only with
     user prefix)

3. 1+x repositories per project

   Keep everything like now
   * master, next, maint for the main stuff
   * each user has his own copy of the main repo in his user folder
   * tags can freely commit in his own repo

Special repositories with big differences like linux-merge are kept in a 
special repository.

Any other suggestions? Do you prefer any idea? Please also add other ideas 
like "user folder names for idea 3 have to start with a ~ and non-user folder 
names have to start with a +".

Kind regards,
	Sven

[1] https://github.com/tv42/gitosis
[2] http://packages.qa.debian.org/g/gitosis/news/20110909T215628Z.html
[3] https://github.com/sitaramc/gitolite
--nextPart1662757.DZoEmrFK65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQCz6dAAoJEF2HCgfBJntGubUP+wcsVhrQgup+vBqckuQirj7I
BmYWJr7Zuk9nC1FIjeNEUuQKs8qS43LCTxJr/X3Zhhd0ojff3x/laEMBFFZ8506F
j2pN33cyC7EYOodZOEy1mDEl7h3iAtFIPrMwQWy0UpILSvoN0mSvBRGTwuRHa+C9
HfYNuwIjqZeIQDJOzgpvfKx/bQIyln/bBXEVIOjSKN0nXBQOOlMkX2bpXUquEA0R
ObXmf/G1mV1IGLnKURZM/afTQO2VzzuKriP78qzLobjyxKTdrR1Ak//byShfKvmx
5gw6RQjN8w4b5eIlejtw+b5Ll2zaFj87wO9uAautkroPVhlv3jDIv9S7rv0Obj7T
yCPl7yffTgqwCZlS9RmrO9ykmAhY+YvGe/h0XT7yDseI2endgSDgrO4Jg4a3iIRd
BhLOhC/cfcS/nEA3iGx67seGzW412vBHn/gO6yPZsLNZ8mnGt1QJ2H9SFM8AQUdf
8X8RaCp9QCt0zjvtzAvS3HP6HLUFYVrUL8LpQsZqD/A46/FeAvnFGsX6FNqtEcSy
SCpXl1Z9wXBRlc7obXiMjhFeHEusOYp3I5W3f5DC9lYI3Tw8Oegvjokk5RM6mbk1
Rr3Ps0tT0/qQs4FHDleNBSOPBcuw/etoVDZ140CZhbsAqiVy9O8ut7jXWuOr53oS
aV/+YXE1qC++vlAWC14d
=piEa
-----END PGP SIGNATURE-----

--nextPart1662757.DZoEmrFK65--

