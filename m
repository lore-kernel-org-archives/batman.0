Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 29 Nov 2012 21:33:49 +0100
Message-ID: <5057225.7jCkgzL2hk@sven-laptop.home.narfation.org>
In-Reply-To: <CALDpWg6Ci0DDUs=Y8TKWn98uwLXnhG1Mdb5NEje1jdvJJoiFdA@mail.gmail.com>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
 <CALDpWg6Ci0DDUs=Y8TKWn98uwLXnhG1Mdb5NEje1jdvJJoiFdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1955488.7jYvWVJX7x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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
Cc: liu muye <lmy19901031@gmail.com>


--nextPart1955488.7jYvWVJX7x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 29 November 2012 14:52:08 liu muye wrote:
> Hello:
> 
> By looking at the packet.h from the batctl source code. I found this:
> 
> #define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype
> */
> 
> I guess it would be the packet type batman would recognized. When I
> set the type to 0x4305.
> However, I cannot even see any output from the receiver side when I
> run batctl tcpdump bat0 on it.

I think we already had this topic and I've already explained you that you 
should not fiddle with batman-adv internals when you try to send data from 
point a to point b.

> Just wondering if you guys can have simple examples about the socket
> programming on B.A.T.M.A.N.

As I told you more than once that batman-adv is transparent for your 
application: http://beej.us/guide/bgnet/

Kind regards,
	Sven
--nextPart1955488.7jYvWVJX7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQt8atAAoJEF2HCgfBJntGNoAP/08GknaIP5b8xBFCiF6aEC1q
OhglIYNGCexKY9TjkX6ZHm4VRlaetOVAleU3I2ifJkjshl+y8HI4dXJUXYL+pNhn
RXkCK1ptMyb1yk23JFOo5wFBq/A7xq0/0iv8m5oY8vQls6GoIuvJOPDFuj8K++lB
xSlLNPGNdL/vqUXsxdjfTjLxOpnyk01XCf9cIWVgr2+xq/9Gm38ydeuPZeTXcNhe
ZiJukRMOaqYvDV3F9eRZzGwE2oSy1OLL5gRSouf6SVGLg9wipV+w/PB2mPuxNwbA
X6dIH3v2lSZZyxsE9Bw9wjra+cKRotLR14SSPedn8vDXHh/IG+hBJur/oO7v0Zkm
APLWOrj2QCWpSIeoiUowLA1ssWQb1vbjhrVdNX2Eb/L/rW01wJu1yWU+HXVZX89E
OpWYTsLR6xI356B+KuwzBjGzNcbBlpo12EobkZR4fjYUMl9UZgZZItjBylZRK3lD
fDvMFCwQG+2WJYgg36DEcFm/q1mFdkSBz0jL7cF3D2sLv33DHS0xT4HPcwXt+Itr
eflxgjXHXy0pEtW2kXDtzvE1Cn19NB1uCdnwCL3RMSp/iEXT3AY8mUVIzYAiYOYq
QML+ilxNozSxcvBI6NcI8q4FqlFaH62WYicME0D4JtwjXM4d3VG/Jeb3J54iRnlV
nMllDn5qykmiS07oe3wq
=TAQN
-----END PGP SIGNATURE-----

--nextPart1955488.7jYvWVJX7x--

