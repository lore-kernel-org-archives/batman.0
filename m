Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Apr 2016 14:17:41 +0200
Message-ID: <1716190.DTWDRvZav4@prime>
In-Reply-To: <3605600.IEJkB4EzUh@prime>
References: <56F5AF2F.6060904@t-online.de>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2559810.qZ2jKbem2r";
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

--nextPart2559810.qZ2jKbem2r
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 31 March 2016 14:11:19 Simon Wunderlich wrote:
> [...]
> 
> 1.) sysfs flags (as in Linus original patch, or similar):
> 
>  + can be integrated fast
>  + is already deployed and tested
>  - requires manual work by the admin, no automatism
>  - we can't expect that other VPNs/subsystems/etc will create automatisms to
> specifically support batman-adv
>  - requires us to maintain a flag for a special userbase/use case
> 
> 2.) TRANSITIVE flag as proposed by Linus
> 
>  + outside of batman-adv (no maintenance work)
>  + can be set by the user through sysfs, similar to settings of batman-adv
>  + semi-automation possible: Other software like VPNs, or network drivers
> could set this flag without specifically need to integrate with batman-adv
> (not sure if this would ever happen though)
>  - will take some time to be adopted: first it goes into the Linux kernel,
> OpenWRT will have it when it updates to the new kernel. That could easily be
> 1-2 years
>  - requires more work with on other components, don't know if the various
> upstream projects will want that
>  - linux-net adoption unclear (but there are already ~18 flags, why not have
> one more)
>  - Personally, I don't like the name TRANSITIVE. What we really want to say
> is whether we expect all other nodes in a broadcast domain to receive
> broadcasts sent by anyone. Maybe we could use a more clear/easier/common
> name?
> 

short heads up here:

We had a longer phone call yesterday with Marek, Antonio, Linus, Sven and 
myself discussing this issue and how to move forward.

We agreed that the sysfs variant should be our last resort since we don't want 
to expose too many "tuning" options in batman-adv as we already discussed in 
this thread.

Instead, we want to try getting the TRANSITIVE flag into the kernel, which 
would not only leave the tuning outside of batman-adv but also enables other 
protocols and applications to do the right settings. Linus agreed to prepare a 
patch for that, and we will help pushing it.

Let's see how that goes. :)

Cheers,
    Simon
--nextPart2559810.qZ2jKbem2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXDjjlAAoJEKEr45hCkp6hiWMP/3e6woYsftcj3dOoNSxncFsp
ypq9w7WvXWmeKPSzFF5wT9oWSO0z0MiqgysugxpV52jRmxNgZAdvMrQbV5qDRPk8
NO/31OYWQh/MJgq+bKaLm2HmHSkKGwtY1CjbalObkTs9nXAiOoKpOkQvxrHvOhSZ
/JLb3lqNSgeEqdElU7Neg93MYMSKYH91CE8PtCOF8HNhEq/HQS2Q7KoQKCNyoOKn
JvJ/qilHRp/gb+GZaRoKkjxjdv0Ujfz6mOxYQJdZQYkWLZPrPztryeoLrRYDJNd9
x6KZvuvX1cBe3B5MBB67u2vzbs65Tsp+I3Wit5ZXniyXr653UoGovnrvuMMKLTuV
ibnpOHE1SGCTnRL6Neid8Mm6kubof3RHpZsbzdVJ6FsbcEUZ9gr8sg7MtdIJdv0j
fCVqtc5mkw87aRGGn1mwDr87v9uuP4a6XbeBwmwK6o6wv4zF4w9UouG2B8N74lfP
Ew9rEnHw0zwsgac8xrLl0RXjUAQAg51rjfSOKPbwjwSbhjCSU5Tk96aGtnocdObO
ISp7SEQq/D4yvCJga6FQ4fY0jgDYAxmTB0pogfA2pZMNy3ZMwWDCQRdth9PZiYED
nj2dRrhPlENksSflfDNAdU+JvvHwzEJ9NjM/Zz3bUTOgmWeftuabpJDr4DTbPiJI
zThdb6gzxfZ9/N3U7ubb
=MD4Y
-----END PGP SIGNATURE-----

--nextPart2559810.qZ2jKbem2r--

