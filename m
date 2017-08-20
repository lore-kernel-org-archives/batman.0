Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Aug 2017 09:35:42 +0200
Message-ID: <5468456.iLjU66Egku@sven-edge>
In-Reply-To: <CAA_JP8UHmeHu_UavyVt9tXQ27AVOdNcznZnuCib3xoSDB0V8Tw@mail.gmail.com>
References: <CAA_JP8UHmeHu_UavyVt9tXQ27AVOdNcznZnuCib3xoSDB0V8Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17084205.sxvBOJnbhZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] wired performance
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

--nextPart17084205.sxvBOJnbhZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 16. August 2017 09:39:00 CEST dan wrote:
> Anyone done any performance testing over wired links?  ie, if two
> ethernet ports are gigabit and are added to bat0, what kind of
> throughput is expected across these interfaces and how much CPU is
> needed to get up near wire-speed?

I can easily reach gigabit here between an i5-3230M (receiver; r8169) and an 
i7-6700K (sender; igb). I was able to reach 926 Mbits/sec in a single stream 
iperf 2.0.9+dfsg1-1 30 second test. Both ethernet devices were configured with 
an MTU of 1560. Both systems were idling most of the time (> 90% of time while
also running things like xapian, akonadi, ...).

There are some ethernet chips which have offloading features which work for IP 
or similar layer 3 protocols. This layer 3 specific offloading will not work 
when batman-adv is added as a layer between the ethernet header and the IP 
header. I have even seen chips which then went completely slow and got only 
fast again after the offloading features were disabled in hardware (either 
using ethtool or by patching the driver).

And there is currently no special batman-adv support for the flow 
dissector [1] in the kernel. This could be also a reason why multiple flows 
are not distributed well to different cores when you enable RPS/XPS. It is not 
yet know whether this will actually be helpful but at least someone interested 
could do same research and implement a proof-of-concept patches for further 
testing.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/net/core/flow_dissector.c?id=d6e1e46f69fbe956e877cdd00dbfb002baddf577#n576
--nextPart17084205.sxvBOJnbhZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlmZO84ACgkQXYcKB8Em
e0aEtA/9Gatn9mVhP1SXCKDUq51Hb9phGKppR2df9XV+pWNlyubq2/tHOFqVUASR
PudbVEasU0VyL4LVATzkwJAmW2INUTRMlQtoSQphmXN9HkwqQ+1fwKZx7TbSLr/i
b3R9mqbt9tBsRhV1VFydZp1nPvHH8E384X1RjpTkIikEfAivq470HIrRIpMq0/5o
c0TW/C+QxP1llvPOGcZkfYSbGVKafveSTZwpsT2+sUaGN3yeoO5fWiglvBT2vZtZ
uwjCeXIieLyq0WYrrD4gs2bN4dqJY1ISPwfsRI6VdVkcJtsvcifoLuGStjxZAbSl
lDeRZnVxdrm8y30pDa0mGwpfE6TwmMHub+a/IA7j+VJ+1LhEpNwpfGKndjBR2Caa
Udb2az6Gmd5lm20KxlS17Iyehm4963NMx7ry0oyAvAhS2GZTszmlEun4M2WppUO4
LnLYxA6PhFNSuYTHlPKCKGsF1QTK/YLSRqwHZGIqwtAml1Rr/aD/Qu/b8eFjxrzh
XHx83ab7aNQ+BRPqkbM9gmsIc+c5+EIdUQ32WW+yNT4ouDw9SbU8zZlBLf6d09PF
hKaNMDf/1G4nM03pTs/NWbHBXVDpCgHTAZTZaS9OI/+o/AcmMbonkeR1vvziexJE
Kf3XbYOW2ecDRHVPprTZRYda6QK55g9j0rBg7u/BfNbbqFUzdEI=
=CCeZ
-----END PGP SIGNATURE-----

--nextPart17084205.sxvBOJnbhZ--

