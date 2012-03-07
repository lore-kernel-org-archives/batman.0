Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Mar 2012 09:05:52 +0100
Message-ID: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2836504.sMgOrmJc0k";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] Fix of nightly checkpatch errors
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


--nextPart2836504.sMgOrmJc0k
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

it seems that checkpatch in linux-next has new checks. I would like to propose 
some patches that removes these problems from batman-adv. We have some patches 
for next and some for master. The master patches can only be applied after 
merging next (after the next patches are applied). There are still some merge 
conflicts. Therefore, I would like to send a bundle that can be used to merge 
my version (for checking purposes or to really apply the patches).

Here is an example how to use it:

$ git pull checkpatch.bundle master:master
$ git pull checkpatch.bundle next:next

Regards,
	Sven
--nextPart2836504.sMgOrmJc0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJPVxbgAAoJEF2HCgfBJntGAUQP/3HDZPtqU9p9BwX8r/JauzSK
n5J/FtCiiSY6Ch7EubMEHmkbE2SJKkgQ191mYdQR4OM3L65XeevHFb66YrQql3Cj
ZTGdNuz/8N27RC5k+fJVDjuYVnJJl8o8zW+9fuxlcU/7lhP59AQyObZ3KIx4OvoZ
K7jf9+Xd1hV42Sgq3GRsNDK92qlxqbucVOsWdJ93uoX+gPoWLN3baFEhHkRdmI40
dWlqanCmrN0bK/HZiko4GJ2roicS9lwsPf80kPplu5IP36v7CLLyDBKURz2S6H89
wH9vl63RFlrcdLQM/5E8n/IMYpvkpz0QAJ1pwqn4Em8r3NPDRL1ar6Ii7oT5ShR0
xE53dS1Zd0b/lcdohHaqB55NYT/N/mKeMYUbnvO01466jZnJk+Giq6cs+pCWfAA+
xd1iMX6UnHLqiR3frCZ1+xfM/2UY+ycLZYWR9X8lsJTk4J2XCuuoE65XMS0zGC4q
WTbW1j9Y6mO21tRjv5Iu50JimDNNYEfkryvMkV0ySyLIUB6veSOHVNA4iVEjh9NI
4qGnRQ7M+5D0wviFEvZoFaRJq8UZWzubjKxMh9hXr6DYHqNwC4wte/ZRmCquvBZx
K5wwgdDxzagHMv1xBc04Wau4vUOXaDn4lJ2+DyU2LkT3QfpM2eV4B20ycquMlXCL
d8xWCp5pBmuVfS80q4nr
=yzO0
-----END PGP SIGNATURE-----

--nextPart2836504.sMgOrmJc0k--

