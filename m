Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 22 Nov 2012 19:00:43 +0100
Message-ID: <1587719.gZG6lsm63o@bentobox>
In-Reply-To: <CAMVTf1ieWEkLOjcK0w2prCvFRmR4W+BYMett7ySrTQP1Yt2m_Q@mail.gmail.com>
References: <CAMVTf1ieWEkLOjcK0w2prCvFRmR4W+BYMett7ySrTQP1Yt2m_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3037692.ehIj7Oi897";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Compile batman-adv code
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


--nextPart3037692.ehIj7Oi897
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 22 November 2012 10:14:31 Esteban Municio wrote:
[...]
> "We want make some test with batman-adv and we would like change some
> parameter of the code.
> So I suppose that I have to add the "new code" to the trunk of openwrt
> and compile them together(batman-adv module and openwrt). But this
> procedure takes quite time...
> I think this because the kernel in which I compile batman-adv must be
> the same that the kernel in which I`m going to run the batman-adv
> module, mustn't it?But I think that I'm missing something, what am I
> wrong?

Not in which you compile but against which you compile. But yes, you have to 
compile it against an ABI compatible kernel compared to the kernel which is 
used on your target platform. (ABI can also be changed by just changing the 
kernel config, compiler, ...)

> Is there any way to compile only the kernel module of batman-adv so
> that it can work fine with the kernel of openwrt and don't last so
> long?

No idea here because I have no idea what you are doing right now.

> What should we do for try our own changes in the code of batman-adv?

You should just clean the batman-adv part of openwrt after each change instead 
of compiling everything again. You can for example modify the prepare part of 
the Makefile script of the batman-adv openwrt package to copy the 
.c/.h/.sh/Makefile* from your development folder. At least Martin did this (or 
at least something similar). A simple
`make package/batman-adv/{clean,prepare,compile,install}` after each test 
change would be enough to just get the new code, recompile the batman-adv 
module and to generate a ipk package for batman-adv. This ipk file can be 
copied to your testnode and installed using `opkg instal *.ipk`. The new 
module will be loaded after a restart.

But an initial compile of the OpenWRT target kernel is still necessary.

Btw. you can get write access to the batman git repositories when you like to.

Kind regards,
	Sven
--nextPart3037692.ehIj7Oi897
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQrmhLAAoJEF2HCgfBJntGhoIP/1cQTueoQEd8S+mhLJkdFA+z
9S4vGeB+f5MFCQHO2xqXtJoRYmMmycjnPhLJD0hQzUm4JppYmNnbENXIz3FYgV0n
TRDq1dU9vdueqDdEPzQTCm/hPOa6TH7GuK9OYK0qHxX5/4u5jkcCzFraZEGVtn+T
r+ZDVqKsYimUHVXye7m3qLF/qgerBHd9s5w5xhVOtJd3XKpF+ksJ5nKpz/6ECgDa
SsTGRonP5TQ3LSnS4tJjm6j2p1XqW09A5d+kM8FZ9RDmjAPrIKqNP7MrRaoPQg+9
J6qRtJ0c2CbxDYJhf5ZmIEksQ7+G5pZZqZLhwCH37Hkvn8TbHyJO4ClNNLs1kHae
tNT5TPYpCN2vgwFtPDws/2ptqbT8YkEI7xQdflrL2ryXCdYXs5oZmpGNX9+vmlzB
JK9ZrW05Q49vCxSrxV8zCoWqxD7gdBigqXwjUIkBFkWDFlcFoImspZpJgJuutbdc
AOfsODXcYqH+CKGOBMPs9MDvFSXE2mhGOiWDQ8hC+KLCBjajpalTLnw7VWNrN1kV
gedqGGYHo1OgyXTGuHKqw6EOz3JK3x5idelFPMo9lZ7CxiWwaZpm4oNgrBCP3z5v
m96iBY1yZNIRAh+Qf0N5sl5Ssi4ftUNIpvtJvwUdQkQVdTgac6CMRwk1eO7q72dg
iNvOnhJY1tBkjSQRfp8Y
=HW0Q
-----END PGP SIGNATURE-----

--nextPart3037692.ehIj7Oi897--

