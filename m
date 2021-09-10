Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Bonding Alternating
Date: Fri, 10 Sep 2021 09:15:18 +0200
Message-ID: <8679334.VDzE56WMh6@prime>
In-Reply-To: <20210909200939.1153.2026@diktynna.open-mesh.org>
References: <20210909200939.1153.2026@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2376895.ekzGPWulC6";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: brian.edmisten@viasat.com

 
--nextPart2376895.ekzGPWulC6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: brian.edmisten@viasat.com
Subject: Re: Bonding Alternating
Date: Fri, 10 Sep 2021 09:15:18 +0200
Message-ID: <8679334.VDzE56WMh6@prime>
In-Reply-To: <20210909200939.1153.2026@diktynna.open-mesh.org>
References: <20210909200939.1153.2026@diktynna.open-mesh.org>

On Thursday, September 9, 2021 10:09:39 PM CEST brian.edmisten@viasat.com 
wrote:
> Before Adding radios to my setup I connected to computers with three NICs
> each.  I added all three interfaces to the mesh interface bat0 on each.  I
> then run iperf across it and all the traffic seems to go on one interface. 
> I run iperf3 with -p 4 so there are multiple streams.  Changing it to
> bonding does not seem to change the behavior. batctl o - shows all three
> interfaces
> batctl n - shows three interfaces -This I thought seemed odd as its one
> neighbor across three links batctl tg - shows all clients Via one address
> 
> If anyone can point me at what to look at next or what might be wrong would
> help.
> 
> I am using BATMAN_V version 2019.4 in kernel 5.4.68.

Hi Brian,

can you perhaps post the output of those commands?

If bonding works, it would even spread one iperf stream among the multiple 
links. For bonding to work, the TQ values must be on a similar level, 
otherwise it will not be activated.

I haven't really tried bonding with BATMAN V, you may want to try with BATMAN 
IV instead.

Please note that bonding will schedule the packets over the available 
interfaces, but will not perform any reordering on the receiver side. This can 
upset TCP which handles reordering as losses. In experiments with WiFi links, 
I often actually got degraded performance because the queue depths of the WiFi 
links were growing differently, therefore causing reodering ...

Cheers,
      Simon
--nextPart2376895.ekzGPWulC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmE7BgYACgkQoSvjmEKS
nqFA4Q/9GQh57HZRV3K2Qv/8oGKzUPRfOVo5wFqkyRzqkYS2Sz5bk8V/A+qQEigL
Yj1pHh9ik7K2FzujOHK7K9q61+6OGAb1+YWdDE2MsIKUeJug7ZJWugV5hdkACeMd
rXoIRWd/8GX5nERpElq9DCd6T5wZOD6ZxvItPhraIw19UKYUJIyszdkTVzkXEmN8
lfwPkXBnHRg3a61g4mEeeMx+v1iMvo6mxT85SG84FScgd78GXnpK6D9+cK4N2I+X
MzGtfqMgaiubPJDK44f/OTbUaXOvoVxvnlv0R8trShZuLKSZsAAU8xqrcpn6TiS7
MoTDkn27RwtZImV1I36778na/Lmofq1MHmYn0j8zjJA31YRoeGRcEavJVlCV1WnW
3+Rg1hj/IfuvAD50hVCsJAAwKE+WzelNLCbaSNtIEevK3aUztaFxQtCpRZEFBVy4
8FWiJfMG1yd6r6R1XaWNJVrM3rwr4XOShrnuwX9NZZLasuuisgjZCrd+4Ikx507J
SoG/lsrT7gTUfdRuDyEu9VpyzNhQgfcJ/X2o9WIZmFo9eip2b8IkBJ+zFOIWSaJ9
YKZq4XcGJFZZtrt/6zw7ojxy0Ycat6w8hWVhrTObxleK4XLohO67nP7HVCp0pYya
Ep4CrpFlc7/89E2mvrzV1Frjb4eQGwWv/n4lzrDVCuWkIQZR5BY=
=ZmZP
-----END PGP SIGNATURE-----

--nextPart2376895.ekzGPWulC6--


