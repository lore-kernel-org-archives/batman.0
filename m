Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Aug 2014 14:34:20 +0200
Message-ID: <2752578.H2iNbLeYOX@prime>
In-Reply-To: <CAA51LVpzYaMEkrsKwo2yXkMg9+zTtBtqGO7=96mB0Pyv+NSB6w@mail.gmail.com>
References: <CAA51LVr2ogEGnJNCepYRm2eAZvE_TpPFTeLf6BXkVpjyFfHSFg@mail.gmail.com>
 <1463029.4iWUHdE7x7@prime>
 <CAA51LVpzYaMEkrsKwo2yXkMg9+zTtBtqGO7=96mB0Pyv+NSB6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart52148385.iAzYbuNGqs";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Testing example of interface bonding
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
To: Ray Gibson <booray@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart52148385.iAzYbuNGqs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Ray, 

On Tuesday 12 August 2014 11:21:18 Ray Gibson wrote:
> 
> I've put all the output in a pastebin as to not clog up everyone's inbox:
> 
> http://pastebin.com/6fqUUUYq
> 

Thanks! The output actually looks fine. I've tried a little bit myself in a few 
VMs and noticed two problems which were preventing bonding to work, at least 
for me:

 * There was a trivial (and rather stupid) logic bug in the check whether 
bonding should be considered or not. See "[PATCH] batman-adv: fix and simplify 
condition when bonding should be used"
 * Another not so trivial problem is that bonding with the multi interface 
optimization checks the originator tables for the different interfaces. However 
since you don't use WiFi and all links appear perfect, the same router is 
often chosen for the different interfaces and the bonding has not enough 
candidates to choose and do round robin. I've sent an experimental patch 
"[RFC] batman-adv: experimental sysfs variable to always apply half duplex 
penalty" which allows to turn on the interface / half duplex penalty for all 
interfaces, not just wifi interfaces. That patch will most probably not make it 
upstream, but should be good enough for testing. Enable it with:

echo 1 > /sys/devices/virtual/net/bat0/mesh/always_half_duplex_penalty

Please apply these two patches, set the new option and try again!

> [...]
> 
> Regardless of its potential impact on performance, I think it's worth
> a look and test to see if there may be some potential benefit.
> Currently this setup is working nice in that it's a true case of point
> to point redundant links.  If additional links could be added or
> removed at will to enhance throughput I would see this useful in a
> variety of applications.  Currently, I'd like to just reproduce what
> the function was originally designed to do and then go from there.

OK, sure, it can't hurt to try it out - maybe you can even find ways to 
optimize it. In any case, we would be happy to hear about your test results 
and experiences. :)

Thanks,
    Simon
--nextPart52148385.iAzYbuNGqs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlPrW1EACgkQrzg/fFk7axZZiQCgmy5andRq/lmMNDstSxdWRB1W
aNcAn0N/1P7V8OYGYQNqpiiNysQvBjtz
=UwO3
-----END PGP SIGNATURE-----

--nextPart52148385.iAzYbuNGqs--

