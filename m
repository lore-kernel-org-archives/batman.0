Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 31 Mar 2016 14:21:03 +0200
Message-ID: <72973422.6kzv4PKiip@prime>
In-Reply-To: <3605600.IEJkB4EzUh@prime>
References: <56F5AF2F.6060904@t-online.de>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9297791.OrvNg6SBgF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart9297791.OrvNg6SBgF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Some additions below:

On Thursday 31 March 2016 14:11:19 Simon Wunderlich wrote:
> 
> So let us consider the other two options:
> 
> 1.) sysfs flags (as in Linus original patch, or similar):
> 
>  + can be integrated fast

One more comment here, fast means that we can integrate it fast in batman-adv, 
which will help if you use the external module. It will still take some time 
to dripple into distribution kernels just as Debian. However, compiling the 
external batman-adv module is easier than upgrading to have netdev flag ...

>  + is already deployed and tested
>  - requires manual work by the admin, no automatism
>  - we can't expect that other VPNs/subsystems/etc will create automatisms to
> specifically support batman-adv
>  - requires us to maintain a flag for a special userbase/use case
> 
> 2.) TRANSITIVE flag as proposed by Linus

just noticed, actually it was proposed by Marek in the mail before, but only 
Linus fancy name (in capital!) caught my attention ... :)

Cheers,
    Simon
--nextPart9297791.OrvNg6SBgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW/RYvAAoJEKEr45hCkp6hbx0QAIZ4+sHNHwFyjhj+dz83HazU
3ip9oZHM6OsDma+8qw32bIUoM5L+FmcWDzQbXvzZoaBMaNHyNC9i5yUsTHmeaOFq
5yzylO+R58TKrNzPRos/H/Bo+qLFrU1p3kR21vjYEIqlmTxt/0FRiLIoIQ/yHGnU
GJGaf52Ey6/vRu4z45X72HN4ICVn66o9idNxlSAs9EUcMxQkOp3RIvDW9t0He3h8
8lNZWW9IRiBNTImAA/NbKdVYcipbZ8ETrquX9uGeFVahHBnKm9kO8+M3QFgOEf4v
MyUq8rEW0pUybRPVBM6NreR3QG98xnpOM0zCkZmVx3vJuiygP+6d29D1VgoIM6rG
j1Vqwf97Lxp8YgPJOQURvd0N1sdZ50OX864NsFog+Nw/Bxp4K3fMkfAGO78cCu+Q
VZsJbl0Pj4CXi9G/U0cAoeZWaQVuthnfzBDnY/5IMv20kjUcI8+ir1ce9eywtRtM
l//IAXanqBoG7H1jZe5Af7ISAibDwAX4JMnES/zEhsSa7UFap7YELM5pwpc19jv7
PpOIynfRm7Sh1tMNQlwC41CAc3iT+6XB8K3mOsj/Fyns9OMqhD+7/NEhPvGxo1kY
l0cmSEOYcLo/QeQhTQALx5IFk5lyt3Fg04fvVNdOBQZ/wAsl4//FnlRM2U7M+F45
iRsojmanLPHuhfoZP722
=Z8h9
-----END PGP SIGNATURE-----

--nextPart9297791.OrvNg6SBgF--

