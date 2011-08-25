Return-Path: <sven@narfation.org>
Date: Thu, 25 Aug 2011 07:51:58 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20110825055158.GA27922@sven-atom.home.narfation.org>
References: <4E55724D.5000405@linux-migration.net>
	<693220585.935033.1314230621559.JavaMail.root@mail7.gatech.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <693220585.935033.1314230621559.JavaMail.root@mail7.gatech.edu>
Subject: Re: [B.A.T.M.A.N.] Comments on Lifenet?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Hrushikesh Mehendale <hrushi@gatech.edu>, jon roland <jon.roland@constitution.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24, 2011 at 08:03:41PM -0400, Santosh S Vempala wrote:
> Sven:
> Thanks for scrolling through the code. Have you actually tried it? Do you have any improvements to suggest? (even if you're not an expert at kernel programming)

I will _not_ try to use the code before the obvious problems aren't solved
(make it thread safe, don't access memory and then check if it was good to
access them, don't implement your own linked list, general error checking,
don't clutter up proc, fix skb handling/checking in general, ...).

But don't understand me wrong. I think it is not a good implementation, but the
idea itself is interesting and I would like a real paper/journal article about
it. I know that there are at least two other papers available [1,2], but only
one [2] is linked at your site. So maybe they don't show your current ideas...
but I will read both of them later in the train.

I personally don't understand Jon Roland's comments. It is good that research
is done in this field and also that people think about different goals they
want to achieve. And I would also aggree with Marek that it would be
interesting to show your results at small mesh related meetings like Wireless
Battle of the Mesh (not real to "battle against other meshes", but to exchange
some information). But be aware that the worst participant is eaten by wild
animals ;) (just look through the pictures of WBMv4[3]).

Kind regards,
	Sven

[1] http://conferences.sigcomm.org/hotnets/2007/papers/hotnets6-final57.pdf
[2] http://dritte.org/nsdr09/files/nsdr09_camera/s4p2_paranjpe09nsdr.pdf
[3] http://battlemesh.org/BattleMeshV4/Pictures

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJOVeL9AAoJEF2HCgfBJntGzLMQAIBoSpYbgZCxbmH/vTnGSVHO
Fb7sFYIazRHPu+2bdED6FfE1z97Hk7trCO2H53BjfnM/zqizE6vWr5LNtS8x6ES1
j5NUOlJMEp/ADXS4a9eZ5bv5BX4lbCZuS3fL5qFNJ9+x/tjyZQx0dFK1wa1vGCed
CRjJxyYVzXrZ+2vOEj1HMMqvnEpoga23GMBzNlUNago+Y0q3o24kfCBTXMpZ4Ro9
tb/hLIaQK19K9wi6Ajfq2yZT5xO447BY9anO/+8l+R0rxlqWGC2+mDzwdUGS9MVT
PNrE+TnH3ZP8R2/p7dxV2DBSw4BoqNb7zAwhjKvZVIpULDaoDXx+UeZjhrd5Io12
h6Qm4kizlO5XRpwHcaKUI1z57xuZcaAIce0ad7+7qMBooaWKKSxvdaJ/5YyE7JAq
h4mzDRihBl7jsm3UCh+dV5hP/U8ip91o4jhstsF+uKEtBkqVJnk/1AI7NLyLTWLU
7f43mGUkcbhklNCXcvEdSXH3chdvWkUmZSvyt3Zhg4d5ywQXIxtl7+LUwhjmaomB
I69eR5tIWyYa3h6JKW+jMYnzc9CLZx7zL+UPdcpH55ePe/7jIgfL7drEfOSybKgc
mTXlziCU66yReLW08Zqdstyxh1pQOjXDLD7t6igbjprH2fRr7ZV8l22KgcmAHkmr
+MxzWp7iNmKGxSdZSTmA
=EW49
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
