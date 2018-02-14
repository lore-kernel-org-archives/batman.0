Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Feb 2018 10:03:44 +0100
Message-ID: <3678642.ZAPEa3b1nE@prime>
In-Reply-To: <839a5aa7-ed42-27d5-1453-6b152943d811@FreeBSD.org>
References: <839a5aa7-ed42-27d5-1453-6b152943d811@FreeBSD.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6355617.sW6ZeaDrje";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv and/or batmand porting effort to
 FreeBSD
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
Cc: Mahdi Mokhtari <mmokhi@freebsd.org>

--nextPart6355617.sW6ZeaDrje
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mokhi,

On Tuesday, February 13, 2018 6:52:51 PM CET Mahdi Mokhtari wrote:
> Hi,
> 
> After some time of playing with the B.A.T.M.A.N protocol and
> net-interface on OpenWRT and Debian I was thinking to use it with
> the servers I use everyday (and maybe on routers/appliances I have
> nanoBSD on).
> 
> So I started an effort...
> (As a background) I already ported some applications to FreeBSD [and I'm
> maintaining them] and
> also I did work already on the Linux emulation layer of FreeBSD (FreeBSD
> has a Linux syscall-emulation and Linux-KPI layers).
> So my approach (as naturally I didn't expect the build of batman-adv.ko
> to be successful as is),
> was based on the approach that we [at FreeBSD] did to port Linux's
> drm... <https://github.com/FreeBSDDesktop/kms-drm>
> I ended up in adding some header-files to FreeBSD Linux-KPI (like
> average.h, percpu.h, ...).
> Now I'm at a state that Netlink blocks me and I'm to determine next step :-)
> [Which I don't assume it being trivial with my current approach]

That sounds interesting ... will you be able to follow up the port with our 
development, or what is your plan on that? I'd assume that you need to rewrite 
a rather large chunk of "Linuxism" as you say, and I would assume that porting 
newer versions as we release would be quite some manual work.

> 
> So I'd like to ask:
> 1- Is it better approach to "rewrite" batman-adv.ko [at least
> Netlink-ish (let's call "Linuxism") parts] than what I'm doing now?

I don't have enough knowledge of FreeBSD to answer that. I would assume that 
the skb handling and netlink/debugfs parts are Linux specific. You'd at least 
need to rewrite those. You better don't touch the routing code, I would not 
advise rewriting that.

> 2- Any other efforts are being done out there?

I'm not aware. At least nothing serious (I remember someone demanding batman-
adv to work in web browsers). :D

> 3- is batmand deprecated [So I should mainly focus on batman-adv.ko]?

We agreed to not call it deprecated, but there hasn't been any developments in 
the past 7 years except for some build-specific issues. I'd suggest to focus on 
batman-adv.ko. batmand may be easier to port though, but I see more people 
using batman-adv today.

> 4- any other comments do you have? :D

Good luck! :D

And please keep us posted!

> 
> P.S. sorry if I'm not really good at starting conversation from scratch
> and out-of-nowhere :D
> but I hope by continuing the collaboration we can have better (more
> enriched) FreeBSD and better (as in more portable) B.A.T.M.A.N :-)

Looking forward to it!

Cheers,
     Simon

--nextPart6355617.sW6ZeaDrje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlqD+3AACgkQoSvjmEKS
nqH9OQ//UdEiIUUidWE5aHMtE6EMo1GZYu9O68FUFkkDPPAbaENOPwt1+hqj/7wY
v2L5o9KFsSpOyNIvPSYKRGjNFP0DLX2dueyQDdnmXgkEpdHx3L/QP0dffKz6dnsy
7/UkU/0gy6mBGZgql54cjfGynPctqZLBVHaceesS/eK5Wv63qyAqp9YcIsRXGIgJ
9vngN3+aokhbqhDQV7xXjWTpsC7PoQPSwZ3y4pvB1U9r14UBrGD0GcXUp5CIL0Ug
soA4VGF3CXqWn5nKH6Xfn52mHr7QZiMskFbqKV+zhYeiu72I28vx9XYLwbvA+4MH
L2U8nSND5MgohdJjUAX8W6QMsydLRPXIe2eM9AE4StLydziNFPy0fAt/49TH3jBj
hdJY2kkdXIAkOg/qpv6g7ZVtv0Hnqn8tVR0CV4F1Iogmy8mYVP1FKtm51NOV3ZZ9
3eePYW28kREcRt+ngyN3XzwDpvneum3gzrNfR5sbWyLPD6MnMDRGD5OlD+fM2QJF
by1vyIOYfLd8C6u+fPGM7YGu79r2VLmxpql6gqgO3EsUTwgebtlYaoeXvCEu0iCv
G/cJzTFbSWqKr0dPHFCdhivqej9aZc0SJb1wYdLv4BAqYspxcigLOQusO0Bfa4rH
lVqLIvIvBzar0BmFN4sPJX8L6I3rihzkB3ddvquCLXS4Z7/FCYo=
=OFbA
-----END PGP SIGNATURE-----

--nextPart6355617.sW6ZeaDrje--

