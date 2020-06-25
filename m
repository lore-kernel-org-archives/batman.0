Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Batman-adv Tweaking - bonding
Date: Thu, 25 Jun 2020 14:23:13 +0200
Message-ID: <2538029.hbpEtBUb1E@prime>
In-Reply-To: <CADg1mwL-H_PULsXqVb0r58k0_zkAYWTOm=cM5QZrDoqRxKqdLw@mail.gmail.com>
References: <CADg1mwL-H_PULsXqVb0r58k0_zkAYWTOm=cM5QZrDoqRxKqdLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9544746.drM8O5kHlz"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Mark Birss <markbirss@gmail.com>

 
--nextPart9544746.drM8O5kHlz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 25, 2020 2:14:06 PM CEST Mark Birss wrote:
> Hi
> 
> With reference to the wiki topic at
> https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking
> bonding
> 
> Available since: batman-adv 2010.1.0
> 
> When running the mesh over multiple WiFi interfaces per node
> batman-adv is capable of optimizing the traffic flow to gain maximum
> performance. Per default it operates in the "interface alternating"
> mode (which is suitable for most situations) that switches the WiFi
> interface with each hop to avoid store & forward. Alternatively,
> batman-adv can be switched into "bonding mode" in which batman-adv is
> using all interfaces at the same time to send & receive data. However,
> this mode is only recommended in special one-hop cases. You can read
> about our alternatebonding test results to see what suits you best.
> 
> 
> The wiki shows that this is the only change required on both nodes to
> use it in default interface alternating mode
> 
> batctl meshif bat0 bonding enabled
> 
> The wiki does not say how the throughput was measured after bonding was
> enabled
> 
> Will batctl tp be ok?

Hi Mark,

bonding was measured on 802.11a/g routers (yes, before there was 11n) back in 
the day using iperf. There was no throughput meter at this point, but it might 
work just as well. In general, there were many situations where bonding 
actually decreased the throughput because the buffers of the radios were not 
synchronized, causing packet re-ordering on the receiver which TCP is very 
sensitive to. In general, I can't really recommend to activate bonding at this 
point, but you can enable it and see if it helps you.

Cheers,
      Simon
--nextPart9544746.drM8O5kHlz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl70lzEACgkQoSvjmEKS
nqHe2g//YkyCM0u+DJ3qy626RfTKWSEMChhmtGE/VEP+FnFS272rmUWcSz5hTJhu
pqm6UxCOaPkmkhnec9h2b/SEa2Py2eVuCKL3k3t0h7N+mvSMsHAF1SrvDQ3p+qj8
bcny2DiF9rA96MG/Tz+Ya+tEXO6DWFL8T3mKZR0JOkyWGChxAAoM5wkIq8DfydoX
ENyFl2TFVEDsGDQx16zexqMPij/4ukk3yY5sKHEpsJ7Ee8emAqU2vmcg51yNQWmT
E8nBzHc3IeL0nnf9u9geqOtevaPL1TMHHGek6C7OxnBAmWAjBlEGBvLJBh+KopI0
153Asal9nXqNd3+HoT1OarRROnSvi+xiPWRQZTMc41pxJi6Ex3O3U2GY4tfMobwh
di85y8QRj6teD5+OO36HarD6FVLpIwPEHwXtEHVcoVA8NpOIkadwMmpol2i811nA
6AnjmX473pRHlaWb7I1rPi84+cdULfNyFAHxA0yKsUmMVtfqD+9hjhhhrYthdawr
Lbkof+6BEP+KDL2/syGa+ZLQW78Nj22+ujrR9rRbEvKsclsYyd3flI0wk8pL+PI/
rErcNNqcyOGinOyT9gtCRDs1Cqd3DDHdJQHB5WBcoYh58Bs1uB7sTBjoVFLCdSCr
/yqrM8gBSrUr9uAaXcnid9PxZJrn3MeFLNYdixjjvfbfiQeWsbc=
=Nlk1
-----END PGP SIGNATURE-----

--nextPart9544746.drM8O5kHlz--


