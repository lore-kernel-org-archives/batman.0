Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 22 Nov 2012 22:25:48 +0100
Message-ID: <4821015.mIvdhMMzeK@sven-laptop.home.narfation.org>
In-Reply-To: <CAMVTf1jTfdwLzOm9_n97VVO4t8fMxyCX_w0tbv-i6euMUAy71A@mail.gmail.com>
References: <CAMVTf1ieWEkLOjcK0w2prCvFRmR4W+BYMett7ySrTQP1Yt2m_Q@mail.gmail.com>
 <1587719.gZG6lsm63o@bentobox>
 <CAMVTf1jTfdwLzOm9_n97VVO4t8fMxyCX_w0tbv-i6euMUAy71A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart50137921.MPHmZSR5oH";
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


--nextPart50137921.MPHmZSR5oH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 22 November 2012 16:10:52 Esteban Municio wrote:
> I'm not understanding well your advices...
> 
> >> What should we do for try our own changes in the code of batman-adv?
> > 
> > You should just clean the batman-adv part of openwrt after each change
> > instead of compiling everything again. You can for example modify the
> > prepare part of the Makefile script of the batman-adv openwrt package to
> > copy the
> > .c/.h/.sh/Makefile* from your development folder. At least Martin did this
> > (or at least something similar).
> 
> Do you mean that I should modify the makefile (my path to this
> makefile is .../backfire/trunk/feeds/packages/net/batman-adv/Makefile)so
> instead the download the code of batman-adv, it compile my own code?

I thought you wanted an easy way to modify and test the batman-adv code. And 
this is a way to do it.

> > A simple `make package/batman-adv/{clean,prepare,compile,install}` after
> > each test change would be enough to just get the new code, recompile the
> > batman-adv module and to generate a ipk package for batman-adv. This ipk
> > file can be copied to your testnode and installed using `opkg instal
> > *.ipk`. The new module will be loaded after a restart.
> > 
> > But an initial compile of the OpenWRT target kernel is still necessary.
> > 
> > Btw. you can get write access to the batman git repositories when you like
> > to.
> But, how can I compile only the batman module and generate ipk package?
> If I compile directly the batman-adv code, the batman-adv.ko module
> does not work in the testnode.
> Can I generate a batman-adv ipk package with out compile the whole openwrt?

I already told you. You can do it with
`make package/batman-adv/{clean,prepare,compile,install}`

But first you have to compile a complete image of openwrt and flash your 
device with it. All following builds for this image/kernel can be done using
`make package/batman-adv/{clean,prepare,compile,install}`

Kind regards,
	Sven
--nextPart50137921.MPHmZSR5oH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQrphcAAoJEF2HCgfBJntGNssP+wWV1p6Vy6FaxzNNaGJqmpWs
SHpfIOUJkyvR+cKDPBv4xHLbPmnxf6NFqkSEEQv8gfYfhwTGzB8oNQ/mVtJ1VXSA
7UUOibnXhZM5Haey1GgKEckOKmrpSS3Ay7qP3m8z+QLYVBlFjkecGqpYS+M4WW72
f99bueVaTj5CDzRGHR9ffwNtQdOeOzb0jdk8eabhpGIk8JAvU597+bor3cu7AQv9
SOEO83YvqUL/NW+/AAQ89pyanEOUbXEVrLQv/qFkbBNr6r6GUOtJdeBLS/84Hl9q
OvBU3yhct1YDnfDcUsayp9wFNtw0PLKbi/qCACqvTUonSeAXZRnfF2VZeyC0g4oJ
5kHqcsCclZ4aWUcYY+pbyR0vyakpkirCFKx8ibTkReC8A625BHUdVtL92ekrKzMK
CpF74+x4FNhmu66/6qBb6mw0c5TrxqFxQ0rZH65pxfSf5NxLLZhIwpDgaks2wNMn
07Y/MQx8OcdJqSJ8H8fgbZG76Zntr0jwzPmgOEcqHZ8IR5YFGO73lBvqSIkcfoU9
llgRFNVI1THWpsKwItiz9aMpFURlbdSYfjRmeyqXBhSQUl6Kuork1UdZa8D+dVjc
v37j2fcE0wty+c58FXMoDP5Pq8RsHujuDoD86z8cnDrxoStCrpwJWV50bj7n3CeF
3aryxKLy92Yzbs69gUyu
=B7W1
-----END PGP SIGNATURE-----

--nextPart50137921.MPHmZSR5oH--

