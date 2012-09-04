Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Sep 2012 15:05:27 +0200
Message-ID: <1522799.RKjDCIBmI1@bentobox>
In-Reply-To: <A677A9FB362B2F499BEFD6F80687FE972AF159C4@umechphe.easf.csd.disa.mil>
References: <A677A9FB362B2F499BEFD6F80687FE972AF159C4@umechphe.easf.csd.disa.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2363069.gK1UlaF1lo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman, TTL, broadcast, etc. (UNCLASSIFIED)
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
Cc: "Karan, Cem F CIV (US)" <cem.f.karan.civ@mail.mil>


--nextPart2363069.gK1UlaF1lo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 04 September 2012 12:48:00 Karan, Cem F CIV wrote:
[...]
> 1) I'm guessing from the following pages (which only describe roaming and
> announcement behaviors) that the TTL field of all packets is decremented by
> 1.  Is this true?
> http://www.open-mesh.org/projects/batman-adv/wiki/Client-roaming
> http://www.open-mesh.org/projects/batman-adv/wiki/Client-announcement

TTL fields of the batman-adv specific TTL fields are decremented by one for 
each hop.

> 2) Follow up to question 1; are the TTL fields of Batman packets and IP
> packets linked in some way?  The library I'm using (zeromq,
> http://www.zeromq.org/) has a reliable multicast transport built on top of
> OpenPGM (http://code.google.com/p/openpgm/).  My plan is to simulate
> reliable 1-hop broadcast by using reliable multicast and setting the TTL
> field to 1.  However, this will only affect the IP layer.  Unless batman
> also decrements the TTL field of the IP packets traveling over it, I'm kind
> of stuck.

No, batman-adv is a distributed switch on layer 2. So it operates on a 
different layer and has no knowledge of IP or its TTL field (please ignore the 
gateway feature for now... this is the only exception were it accesses L3 
stuff).

> 3) Finally, does batman have the equivalent of multicast or (better yet)
> broadcast for data packets?  That is, if I send something to a multicast IP
> address which all of its 1-hop neighbors are listening to, will all of them
> listen to the packet simultaneously, or will it act like a series of unicast
> messages?

It currently has layer 2 broadcast support (it resents broadcast packets 3 
times to increase the propability for a successful tx). Multicast is handled 
as multicast. Linus Luessing has a patchset to implement optimized multicast 
[1]. I am not sure about the current state. But maybe he can give more 
detailed information about it. But you should know that the optimized 
implementation may use unicast in some scenarios.

Kind regards,
	Sven

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-ideas
--nextPart2363069.gK1UlaF1lo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQRfyXAAoJEF2HCgfBJntGO0YQAI6pWvB+YAkkmB+TWsYy+4hB
Tep7RV5JZ+DbqY678EWaglRe2YnFXlN9ge0ZMrPvXClqbhes6yYQSQIu3MEOJNlA
p0V38T4RVzGQeIMFPRoL0ANtz+izl80CwvO0B9ATd7n38RZJo0P2lZ7qh2jGQNuT
U/GRvcdPtylsRbjYxLNKhc9sBDaDerienZ8H5tn7exrH9w/DsocUYenqgjDxelZ8
5qoEysG16yAkLFGfBIGSSUErGkKBo0M5m+lhL+3fYZBYAoRSc90tRG3iWrydzorb
FVtXFM2TaCIDAEerDF6J/7D5+M49JxjkmDkoW28tmPzfTuGKF2pzia+y94rdQkqo
jnp1Ru8mKDgn1BuOkOb27tGF9YcdbVmsJp/nY1Cnbj4Xj0D4FEONIJQ2kLB0s43a
gPXADVccsp0x2LKkFxiLU1tB/VWRqNJlZmfaURIlcqnbSs1BOlbZrMz0PsL8pMGW
Pzp251CUv2ui9ODQbw5wn8PfWoqoySneII8vQ4SVtSQK8RROpWghTbtNOOiTrwkl
O88pVxuDxNWu0FCLWxWiZmBT5+Kg7wtYXIkUtR/jHVAe2xUSa1fiGWjsPjazbLhO
bvboj9neimdY82kP8zoP9Vw0L3vVniBEzAUQviru/lEqcshFIs+B/nadhVpd3g1F
c2CD/k5r1J65vKhg6AHs
=sbE0
-----END PGP SIGNATURE-----

--nextPart2363069.gK1UlaF1lo--

