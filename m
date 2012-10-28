Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Oct 2012 15:33:36 +0100
Message-ID: <2076407.4ZuCQzhV7z@sven-laptop.home.narfation.org>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAKjiaB1rjc5LlgmOWy8Wfa0BAAAAAA==@gmail.com>
References: <1351423037-5292-1-git-send-email-ordex@autistici.org>
 <1351423037-5292-17-git-send-email-ordex@autistici.org>
 <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAKjiaB1rjc5LlgmOWy8Wfa0BAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5345294.qCRIM2i3Yr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: add kernel-doc for
	enum batadv_dbg_level
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
To: Walter Robert Ditzler <ditwal001@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart5345294.qCRIM2i3Yr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 October 2012 14:32:46 Walter Robert Ditzler wrote:
> hi batman list,
> 
> i recently saw there is a bounce of email in the batman community regarding
> patches.

Please don't reply to a random posts to start a new topic. And don't write to 
the Linux networking mailing list and the Linux networking maintainer David S. 
Miller when you actually want to ask the "b.a.t.m.a.n mailing list".

And yes, you will see patches going over this list the whole time. Either 
because somebody wants to get stuff integrated into some B.A.T.M.A.N. related 
project or because the patches were sent to our Linux networking god David S. 
Miller.

So nothing unusal happened.

> is it safe and reliable to use the version from the open-mesh.org
> site:
> 
> - inux 3.6 => batman-adv 2012.3.x (get batctl 2012.3.x from here)

Ehrm, ehrm, ehrm, ehrm, oehm, aehm.... I will not guarantee anything. It is 
safe to use this stuff until anyone proofed it otherwise. But we have some 
fixes in the maint branch which weren't released yet in form of 2012.3.1 or 
2012.4.0. But they are included in the stable releases of Linux 3.6.x

> for production use onto the following configuration:
> 
> os: debian 6.0.6
> kernel: 3.6.3, batman activated
> arch: geode lx and amd64

Now you baffled me completely. Linux 3.6.3 is the stable release which 
includes batman-adv 2012.3.0 + stable fixes. And you want to replace it with 
2012.3.0 without these stable fixes. Can you give me a reason why this sounded 
to you like a good idea? Even without these stable fixes... why would you 
replace the in-kernel module with the out-of-tree module of the same version?

Kind regards,
	Sven
--nextPart5345294.qCRIM2i3Yr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQjUJAAAoJEF2HCgfBJntGYrsQAIGNsGywkO6Evju9o9omBL1+
JfdLakcDwLyeMPaAG9RUIPLpBwLf7KROK+zlVDlMFO4KH4EfsrYDBMB4J2o1O9Fa
hDG+n2zUS3jYxMP/vIKhnZD09B0fc4rHF0RQkhlsDAEs24APHHoGqNuFCN1xa6cv
91CuXFZaRqvCq/E+YrbntQd6YkPlg6qa8uDGhRxFKiWC26c0a6PeZudFCli0wR3c
KXrbvvgIyCBR6mcX+qdtMXjXhi/aP0iLx9lBjRmWX3rxGZQEBXxPME91n+Yhaq/g
37bJYij/lksjUXurWgmf5iYFqwssBWDN3fHj/0QPIBxNv0aaxg9HkMkqdmiwT87z
vqZS1Vaoh0VKQChx4+fNjDN+qlEP0HW/M71Q0pkAm7KOg9h2T/gcsb/rb3R4Gntz
TlTs5W7reTILXfyqECuAYBhDPO95Ae8hVsDLbAq0ntLXehRFr6VcY8bJsivO466D
1FJkkkWhMzQKLLuIg5pc5AB7Ntj919/2o5mOq5c8tJUn83SWBL3QYUZdaEKk3q9P
bOB1y+tsEz1CZrMO3Rlh3QYrXWhO/qdBwiNrIF5lh+JgZogh8MrLvbju5DNmMoef
umOyKelGAlUEakzimnYXo+BXigKzXuoOnHEGhNICh+9AApx2g6xznZ701uC0IeQS
cgY0zs0DNjs8Cqj3xmeI
=JCa6
-----END PGP SIGNATURE-----

--nextPart5345294.qCRIM2i3Yr--

