Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2016 17:11:08 +0200
Message-ID: <2284104.QWR2gm6sJD@bentobox>
In-Reply-To: <1744565.jjMyA2xSBQ@bentobox>
References: <580A26A4.5030005@yahoo.com> <1744565.jjMyA2xSBQ@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2571323.utbtpb8aZP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] High latency with batman-adv on ethernet
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
Cc: johnzeng <johnzeng2013@yahoo.com>

--nextPart2571323.utbtpb8aZP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 21. Oktober 2016 16:43:41 CEST Sven Eckelmann wrote:
[...]
> > because i tested between ethernet network port ( i don't test in wifi
> > port ) , whether it will master reason ?
> 
> Should not be the "reason". batman-adv doesn't care much about it. It just
> requires an ethernet compatible device. The re-broadcast is a little bit
> less aggressive on non-wifi devices but this has nothing to do with your
> problem.

Just created a small test setup via ethernet with batman-adv 2016.3 to show
you how the results are here. They were connected via a single cable:

without batman-adv
------------------

    $ ping -c 10 192.168.2.196
    PING 192.168.2.196 (192.168.2.196) 56(84) bytes of data.
    64 bytes from 192.168.2.196: icmp_seq=1 ttl=64 time=0.478 ms
    64 bytes from 192.168.2.196: icmp_seq=2 ttl=64 time=0.682 ms
    64 bytes from 192.168.2.196: icmp_seq=3 ttl=64 time=0.392 ms
    64 bytes from 192.168.2.196: icmp_seq=4 ttl=64 time=0.642 ms
    64 bytes from 192.168.2.196: icmp_seq=5 ttl=64 time=0.574 ms
    64 bytes from 192.168.2.196: icmp_seq=6 ttl=64 time=0.466 ms
    64 bytes from 192.168.2.196: icmp_seq=7 ttl=64 time=0.602 ms
    64 bytes from 192.168.2.196: icmp_seq=8 ttl=64 time=0.619 ms
    64 bytes from 192.168.2.196: icmp_seq=9 ttl=64 time=0.658 ms
    64 bytes from 192.168.2.196: icmp_seq=10 ttl=64 time=0.440 ms
    
    --- 192.168.2.196 ping statistics ---
    10 packets transmitted, 10 received, 0% packet loss, time 9000ms
    rtt min/avg/max/mdev = 0.392/0.555/0.682/0.098 ms

with batman-adv
---------------

    $ ping -c 10 10.10.130.66
    PING 10.10.130.66 (10.10.130.66) 56(84) bytes of data.
    64 bytes from 10.10.130.66: icmp_seq=1 ttl=64 time=0.489 ms
    64 bytes from 10.10.130.66: icmp_seq=2 ttl=64 time=0.675 ms
    64 bytes from 10.10.130.66: icmp_seq=3 ttl=64 time=0.552 ms
    64 bytes from 10.10.130.66: icmp_seq=4 ttl=64 time=0.562 ms
    64 bytes from 10.10.130.66: icmp_seq=5 ttl=64 time=0.612 ms
    64 bytes from 10.10.130.66: icmp_seq=6 ttl=64 time=0.573 ms
    64 bytes from 10.10.130.66: icmp_seq=7 ttl=64 time=0.534 ms
    64 bytes from 10.10.130.66: icmp_seq=8 ttl=64 time=0.622 ms
    64 bytes from 10.10.130.66: icmp_seq=9 ttl=64 time=0.454 ms
    64 bytes from 10.10.130.66: icmp_seq=10 ttl=64 time=0.468 ms
    
    --- 10.10.130.66 ping statistics ---
    10 packets transmitted, 10 received, 0% packet loss, time 8996ms
    rtt min/avg/max/mdev = 0.454/0.554/0.675/0.067 ms

Kind regards,
	Sven

PS: I've changed the subject because it was extremely unspecific and
too long.
--nextPart2571323.utbtpb8aZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYCjAMAAoJEF2HCgfBJntGcHIP+QGX/q60tboevzJd8diW5PVY
p4YZuQ9NCO/8X9FQyDclbvtGMjvWT7tUIWBE48alRW8UjmT7/cOrRz9Q4lviBvy1
NkifOPDKd+OkiiiIGnpV9s37/kqBxBjjnhEAsb+4ohh8aUbdOzYQxpGbDf9RuEPM
TBONX3EbqnxmxYwmQwcLf8E1TSNLlX4fw6S+tfsqIMA7dRLR8h0XxMRmLXtZiHwj
yhVN8z3udQ8LgV4EA07BTy7E4wUJD2Sde1WECYYlv+3wA34qyksvco3tG+yL5yj2
P/uK7WqS4TYxRK/W/3+TfReWqczNstCPpDlbXp/B8tzo1NHG3vvJYpbkjkF680gS
sb/Xex1vYZMUBcYQu6aCQztIXWGhOON4WX9y7TjFmeFeVZmazU4/lfxyLUjxmG0k
E+cmNiGQdaWoldVBXjrzNit2nRYOovVICN1tLvTcmXHhBat//R3iS0R/bUE5wux5
rWlF3M8ws8rU1V7NRg+fckToSzT5KS36RteDzAbJt0Io2prJRU/sKCIHOgbLpmyI
UoWt3kpIIFdcy3mbXW9U8yYZ7lCETh64DBP2qUbO5zUSC1DEpQwXNfbuwZTqcg2k
SFdQJfExMrVvmePyWJOY0SKSW6srwP6J2Nm5LQCzNnrrdNCAWq7bpOaFQJAVMOxZ
SYClNAMSPfRdAf/Yqk1x
=KCHF
-----END PGP SIGNATURE-----

--nextPart2571323.utbtpb8aZP--

