Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 10:26:42 +0200
Message-ID: <1491626.gIFIcyJNig@sven-edge>
In-Reply-To: <1941799.temDJMhclT@sven-edge>
References: <20150516221537.2a6fad9a@i3.local> <1941799.temDJMhclT@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2026916.GPOGIRdPc4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patch which fixes a uint32overflow ;
	fix algorithm which was unintented changed on 2014 update
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


--nextPart2026916.GPOGIRdPc4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 17 May 2015 00:11:52 Sven Eckelmann wrote: 
> And please also include the commit which caused the regression. This makes
> it easier to find out which kernel versions must be patched in case the
> problem is critical. Here is an example how this information should be
> included:

You are most likely want to fix the regression introduced in 0853ec7 ("batman-
adv: tvlv - gateway download/upload bandwidth container"). The gateway client 
code for fast node selection was previously using batadv_gw_bandwidth_to_kbit 
to convert the input parameters to Kibit/s. After the TLV restructuring it 
should have multiplied the TLV value by 100 to get the exact same result 
because the batadv_tvlv_gateway_data bandwidth_down/bandwidth_up stores the 
throughput with the base unit of 100 Kibit/s.

The problem here would be to decide if it changes the result of the algorithm. 
The code goes through all gateways. For each gateway it calculates the formula 
(gw_down is in 100 Kibit/s; gw_divisor is constant	):

    gw_factor = |_ (tq_avg ** 2 * gw_down * 10 ** 4) / gw_divisor _|

You want to change it to

    gw_factor = |_ (tq_avg ** 2 * gw_down * 10 ** 6) / gw_divisor _|

The rest of the algorithm is just comparing the gw_factor of each gateway. The 
question which should have been answered by the commit message would be:

   Why is this constant of 100 affecting your results? Is it rounding related?
   How much does it affect the algorithm?

tq_avg is a value <= 255. A realistic value for bandwidth_down is maybe 
something like 20. gw_divisor is 2 ** 18.

So each difference in "tq_avg ** 2 * gw_down * 10 ** 4" for each gateway must 
be larger than 2 ** 18 to always be distinguishable by the algorithm. For a 
fixed tq_avg value of 255 the algorithm could currently compare two gateways 
with a gw_down difference of (1. / 2480) and still distinguish them. It would 
still detect a difference when the tq_avg is 6 and the gw_down difference is 
1.

For a fixed gw_down value of 1, the current algorithm would have problems to 
distinguish the tq_avg values < 14 when the tq_avg difference is small.

Your change would make it 100x more precise for gw_down. But I am currently 
not seeing the actual impact. Maybe you could explain it in more detail in the 
commit message.

Kind regards,
	Sven
--nextPart2026916.GPOGIRdPc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVWFDKAAoJEF2HCgfBJntGm6UP/1Fs2nJEoxTMJ64NOFKwDLeg
7kmga5FSkDxkgSPXvZ09do/gyc2px49ztKn+lKpxry3kB5F+JsCk3zt5XSt3T35n
AQ2vg4HmAbO4lFn02gGSf8alWQwxEWJo89DM3P3WHa+YVkyYYVeV0/8qNeGeTYye
ndToEVzGnTHtRLQqKDhPLKXBASB8y9iJegcb/yoRdDh97kW18bgOsZoCGE4BgQBA
K8t3yfk6fHKimOBFiyqD3zj5O3/C3m1kR+fimcJuQ0lMmCJ7RV34QFRfsyhRZ7Ma
6ifpK8I3kPerW2R3CDQslBwN1IjYQbvSF7/3/S7Rmz8KKPQ5Dyqo3pEKA1ee8ZtF
1oAH61vFb02bEIciRqbKFYKUh4rxuPndMV2SDMZ2NxoWipejpqq7I8i4UyTUlXNv
9FX2jEz95Wke+PgexVMiQRgLxxh8TmAcG/gdBmFgzLtl0fev/7Hx6YsJXtU/8OXT
pF4sIHe3y1oaqowxYxwBIlXZIDld+tRujMyE75u+tOPyHbEuF3XphOHLZt9GlEh5
CNw2ZMOh5Xv/lCFUMr/JyLx6fpwp4F469Bn2GQ4cJ6QiMjZ8xfn3v62UlneS7HzI
S6ctLnWIBL35sPeoAkdUVdsZscSaofV1nzv6hIp7qo+W6MNncBaHyypTpt9dHe+O
VEGJqiyjJfL+mAScPlvc
=HEIw
-----END PGP SIGNATURE-----

--nextPart2026916.GPOGIRdPc4--

