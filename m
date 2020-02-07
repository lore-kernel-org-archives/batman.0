Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: can't find logged information
Date: Fri, 07 Feb 2020 16:52:49 +0100
Message-ID: <1594276.uRpPO4E4fP@prime>
In-Reply-To: <b696db36-b9db-d31a-d8a6-0523f8a0986c@coolheads.com>
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
 <b696db36-b9db-d31a-d8a6-0523f8a0986c@coolheads.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1749101.mhWpf81R1O";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, srn@coolheads.com

--nextPart1749101.mhWpf81R1O
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, February 7, 2020 4:18:19 PM CET Steve Newcomb wrote:
> On 2/7/20 9:51 AM, Simon Wunderlich wrote:
> > On Friday, February 7, 2020 3:13:47 PM CET Steve Newcomb wrote:
> >> @rpc152:/tmp/log# echo "$(logread)" | grep batman
> >> Thu Feb 6 15:21:13 2020 kern.warn kernel: [174193.938445] batman_adv:
> >> [Deprecated]: batctl (pid 22747) Use of debugfs file "nc_nodes".
> >> @rpc152:/tmp/log#
> >> 
> >> 
> >> What have I missed?
> > 
> > Hi Steve,
> > 
> > you can use "batctl log" to retrieve the log. It will not appear in your
> > logread.
> 
> Alas, that doesn't work either, and I don't know why:
> 
> root@rpc152:~# batctl log
> Error - no valid command or debug table specified: log
> Usage: batctl [options] command|debug table [parameters]
> options:
>          -h print this help (or 'batctl <command|debug table> -h' for
> the parameter help)
>          -v print version
> 
> commands:
>          meshif <netdev> aggregation|ag [0|1] display or modify
> aggregation setting
> ...
> 

Oops, you are right, we have actually removed that command in 2019.2. You can 
use one of the two following commands:

cat /sys/kernel/debug/batman_adv/bat0/log

(will be removed in the future when debugfs support is dropped

 trace-cmd stream -e batadv:batadv_dbg

> > When the problem happens, you can also check "iw wlan0 station dump"
> > and other
> > debug files (batctl n for neighbors) to find out if the WiFi layer is
> > still
> > working. It wouldn't be the first time that actually the WiFi chip or
> > driver
> > has a problem, not batman-adv.
> 
> I've seen that "batctl n" works, and "iw mesh0 station dump" works, too.
> 
> I am arranging for the nodes to send me such mail when things have gone
> awry, but prior to rebooting.  I've written a tiny mail queueing system
> that optionally uses nonvolatile memory for the queue.

By "works" you mean you get useful outputs where the timeout is not increasing 
or similar? can you still "batctl ping" to one of your neighbors?

Cheers,
      Simon
--nextPart1749101.mhWpf81R1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl49h9EACgkQoSvjmEKS
nqEQnQ//Y+n2Coh4qHaNBCxNlRFdbeJ3OqznzjzVJGqwHipz9zktv+LHuv8/Qg8w
IG1s3SveXWK7ulmcGkoSDUWLIoigLXtGhzik/PX0YLtsEcW7D7u9QIvcrce6Nkbo
kzbsKiq0tJq/2HakJtx34EcNg69oAugO4iVHRFD8JAyx7j8PeBlgegrfO2kOauUQ
55a7i6aATMXC3ukBz/MMVlO3d9HdkF7/gMZjJOER1exAG64c0A/8EIcU1dYvdoE4
l8pBWYNolC1hv8OGteB8u/0Kkg4t4/2mA1H1mHFwoch7Di8jgYR4rSRiIi9SbEOy
MZPBC1tr1Z0q9TWn21LYpsgjruJAHzTTeZVoUnIQkgpJo34oMZ1PlNg7qOrGjuSa
CKDKVz9X7qklN+N8WWCYYPx5SG96naCC4n6YxGOSSpBImof9hGTkanAht1z6wMxe
I4I6e+Eu2YKd/megXrjn61DPJxiTuwogoqj5Wn30+e/O3yNKVfWvAZS2eH8veFFR
v+8I777jyW6AcuJ8+YSFPyEPxSU7VIXYcpHPfEEeDkKzA+Q5LAOUMl13qVbGS5ti
CfeXywSx897/I6VE1THS3e4qV2GKlmlJPlOQNAsm6YR1OVjMz1oUdTfuScNuGmwP
YDeHyMXwD218noC6XdmPVMcP2wwViLea3XKtp0bLVEQ6G5XYlDo=
=n2Mb
-----END PGP SIGNATURE-----

--nextPart1749101.mhWpf81R1O--



