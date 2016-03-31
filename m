Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 31 Mar 2016 14:11:19 +0200
Message-ID: <3605600.IEJkB4EzUh@prime>
In-Reply-To: <20160330135842.GA19985@r2d2.s.lihas.de>
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2240462.Olj3zPcZEI";
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

--nextPart2240462.Olj3zPcZEI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Adrian,

On Wednesday 30 March 2016 15:58:42 Adrian Reyer wrote:
> [...]
> > So far, I see the following scenarios:
> > 
> > Broadcast needed:
> >  * WiFi Ad-Hoc
> >  * WiFi AP
> >  * Ethernet to WiFi Ad-Hoc bridges (is that even used?)
> > 
> > Broadcast not needed
> > 
> >  * WiFi Point to Point links
> >  * Ethernet
> >  * VPNs (at least common setups)
> > 
> > As a very easy rule of thumb, we could say that rebroadcasts on the same
> > interface should always be enabled on WiFi and disabled on everything
> > else.
> > Even if we still agree to introduce a flag to change that, that could
> > still be a sound default. Would you agree?
> 
> No, a sound default is the behaviour we have now. In worst case it
> wastes bandwidth, but works. No matter what exact capabilities an
> interface has. A changed default would instantly break every
> freifunk-community using batman as to my knowledge they all use a vpn to
> connect to GWs that *needs* rebroadcasts

That is a good point - having the automatism (if we have any) falsely 
disabling the rebroadcasts may break setups and would be very hard to analyze 
for users, but the current behaviour is "just" suboptimal but always works. I 
agree that we should better to default to that.

I thought a little more on automation, but I'm now at a point to agree that 
there is no good way to do it - at least I'm out of ideas. If anyone else has 
some ideas, please speak up NOW. :)

So let us consider the other two options:

1.) sysfs flags (as in Linus original patch, or similar):

 + can be integrated fast
 + is already deployed and tested
 - requires manual work by the admin, no automatism
 - we can't expect that other VPNs/subsystems/etc will create automatisms to 
specifically support batman-adv
 - requires us to maintain a flag for a special userbase/use case

2.) TRANSITIVE flag as proposed by Linus

 + outside of batman-adv (no maintenance work)
 + can be set by the user through sysfs, similar to settings of batman-adv
 + semi-automation possible: Other software like VPNs, or network drivers 
could set this flag without specifically need to integrate with batman-adv 
(not sure if this would ever happen though)
 - will take some time to be adopted: first it goes into the Linux kernel, 
OpenWRT will have it when it updates to the new kernel. That could easily be 
1-2 years
 - requires more work with on other components, don't know if the various 
upstream projects will want that
 - linux-net adoption unclear (but there are already ~18 flags, why not have 
one more)
 - Personally, I don't like the name TRANSITIVE. What we really want to say is 
whether we expect all other nodes in a broadcast domain to receive broadcasts 
sent by anyone. Maybe we could use a more clear/easier/common name?



Cheers,
    Simon
--nextPart2240462.Olj3zPcZEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW/RPnAAoJEKEr45hCkp6hKe0QANPApBbjm/mlEONabqJb7P3b
yXBUpGf/LLeIZ/iRaei4741wJXC4fWNCfUYkT+kzdAQ6f9L1JB2gq2qbYBxDJa/+
ARqd/osxTYZWNjW3H7PxvN3qc2Bcmz9E/aTNMHgWqLp17k9hvt0yeeasy2glxMF7
OwpJswT74g3nERbRCm/QliaTkY++YjJLs5gYLAPP67xu9BVwempqr968qsFzWwsE
rg49dqydV5wl5B/Kl70OdYDLybKyDsMSoCLC3RbxOC6BjHpmwPFjyyI/xjZn3P+5
potbljVzIBW3Dvja/sfyBhInHU8x6nWJRvJvCPSnCuyyoXhh9dPFgOYSpxJlgjQB
BtvtCigF3nm032TD29+RI0ELEIrXwLAJ1MZ7n41J9FDlfeu+RaLMy5Jmo4R1kcwK
EwhTqgjlv280BhxppkNW/10LLD/bGWRrcBYivFlZxenDANvBxj23uIiSSsn4zqaj
ADzAmIxYHaIyRmkTq7HLffWI/lvJ3fArb+qXYnqfRACgL7CiiiHyUeCqLBMBmxLJ
WSbi1CZ0+gnKYt65ayj883LDh88AT4ZsBGuGrTYqiw9w/w+m2kmnfq7oCYKMbINr
JFkxKrfeYayw+tFV0uHgvdwt459i8qnP29S9rlbImzEoUN90HGCJZ5/H++fa2GKN
d4rAWlE+1DHWySCMK8Om
=m9CS
-----END PGP SIGNATURE-----

--nextPart2240462.Olj3zPcZEI--

