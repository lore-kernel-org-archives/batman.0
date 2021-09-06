Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Some bugs in batmand(Github)
Date: Mon, 06 Sep 2021 15:05:58 +0200
Message-ID: <22655069.kYlCe6xmuC@ripper>
In-Reply-To: <B47F117D-81FF-48BA-8AB2-CDBB8A9BB450@gmail.com>
References: <B47F117D-81FF-48BA-8AB2-CDBB8A9BB450@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5350538.e81NDu2FWj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Ryan Cai <ycaibb@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart5350538.e81NDu2FWj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Ryan Cai <ycaibb@gmail.com>
Cc: Corinna Aichele <onelektra@gmx.net>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Some bugs in batmand(Github)
Date: Mon, 06 Sep 2021 15:05:58 +0200
Message-ID: <22655069.kYlCe6xmuC@ripper>
In-Reply-To: <B47F117D-81FF-48BA-8AB2-CDBB8A9BB450@gmail.com>
References: <B47F117D-81FF-48BA-8AB2-CDBB8A9BB450@gmail.com>

On Monday, 6 September 2021 14:59:12 CEST Ryan Cai wrote:
>           I am Ryan Cai, coming from HK. Recently, I am looking at batmand, which is really cool. However, I found some potential improper locking bugs due to the unreleased locks like here, https://github.com/open-mesh-mirror/batmand/blob/df6fcb8706d325b3fd4c7000493e64d57c852755/posix/unix_socket.c#L261-L284, the lock could not correctly be released when the middle break statement is executed. The bug pattern also exists in [1]. Could you confirme these? I would love to create PR for these.
[...]
> [1]
> https://github.com/open-mesh-mirror/batmand/blob/df6fcb8706d325b3fd4c7000493e64d57c852755/posix/unix_socket.c#L500
> https://github.com/open-mesh-mirror/batmand/blob/df6fcb8706d325b3fd4c7000493e64d57c852755/posix/unix_socket.c#L565

Please contact the maintainer Elektra and the mailing list about it [1].

Btw. I don't see how the break inside the loop should affect the unlocking. 
The pthread_mutex_unlock comes after the loop and not as part of the loop.

And we are also not doing any work via Github. Please use the normal 
contribution [2] procedure and don't open PRs on random github
repositories.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/MailingList
[2] https://www.open-mesh.org/projects/open-mesh/wiki/Contribute

--nextPart5350538.e81NDu2FWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmE2EjYACgkQXYcKB8Em
e0YSAg//WllFPn8yl0YEpvU8b59EqrFuF5+fLAa8p4C+ZTm+BYhFmLlUcB63P820
jpNgROzSL0vWjFvEYZWb55tUix5WM2pXgXAjKI2Sl/WiKDoC11M4fHSoz/fW1NsM
IXOqRptG+CaH4Rqti8/ip7z+XwtDs9+JE1eTz1OKiU0kYFHrD0bisOFd5NrD457Y
2GGEzs1GgGxaDold1QuKJSps6+eW44/VNvGZitSz/eM9cXihE/XydjaiHyni3Dtl
wf2rZnoHzNtub3oWSMItUJ+oxg3UiZKl0nSIi3r+Y67rGAf8+yqdCERK89xHl/8c
eF92MUdOEHrVIPhfP0Z6fjwFe7cicJYlOBTUgMpoAqUN0pb7zIzefQ7zKVbRyRgK
M+2AUyOPqlc6Lhm7aYCTtO2TPgJT6qVDw/g4wD6VUGKDCIAprgt0CjcwdtDoUNxQ
Qx8xWdTAssoDECxXiRVQbe7HW/HgGnDA6TwlCPXVNxSbY1ZxQwsfFQeox81TASTx
GzDkNsj4skUIPIkdbFAlqSAuT4o5ruMtOUIzouJIKS57LSASTIsitXhMt6jOxnnG
73OtX7/8F7U3o8G+rvnq0OZWwZpOWA1q6pDqxo1dQEK9BL9ZfQ1goA0h3xsVjb7c
uq0f7RwaOWTUNTuOBqHK/R4AIAC+RF6bRRcrP9+WBq6zZc77QiU=
=E9J7
-----END PGP SIGNATURE-----

--nextPart5350538.e81NDu2FWj--


