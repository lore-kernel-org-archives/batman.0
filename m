Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 Apr 2012 09:30:48 +0200
Message-ID: <2057245.Ntbl5TcVgo@sven-laptop.home.narfation.org>
In-Reply-To: <20120429070001.GA30759@ritirata.org>
References: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
	<20120429070001.GA30759@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6517880.W2qFhm6Mg1";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman with Ubiquiti SDK
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Jernej Kos <kostko@unimatrix-one.org>


--nextPart6517880.W2qFhm6Mg1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 29 April 2012 09:00:02 Antonio Quartulli wrote:
> On Sun, Apr 29, 2012 at 01:56:02 +0200, Mitar wrote:
> > Hi!
> > 
> > Ubiquiti provides OpenWrt based SDK for their firmware. To my
> > information, it contains some proprietary madwifi-based WiFi drivers
> > with some older OpenWrt version. My question is how it would be
> > possible to run Batman on top of their firmware (thus not latest
> > OpenWrt). As Batman is in kernel, is is enough kernel-backwards
> > compatible to be able to run also on older (2.6) kernel versions? For
> > olsrd it is much simpler: you just install olsrd package and this is
> > it.
> 
> batman-adv supports old kernel versions starting from 2.6.29.
> What kernel is exactly provided with that firmware?
> I know about someone else which still maintain compatibility with much older
> kernels, but I don't know the state. By the way keeping backward
> compatibility with older kernels is really difficult..

The oldest kernel supported by Marek's patches is [1] is 2.6.21. Ubiquiti uses
something like 2.6.15 [2] (so more or less from the stone age; please correct
me in case they ported the stuff to a newer kernel).

My personal recommendation: When you see somebody that real thinks that a over
six year old, not-maintained-anymore kernel is the way to go: run away.

The oldest kernel we support is over three years old (not maintained anymore
since 2 1/2 years) and the one supported by Mareks patches 5 years old (not
maintained anymore since 4 1/2 years). These are also not real young and fresh
and will be dropped as soon as there is any big problem in maintaining
backward compatibility. The supported versions that will hopefully not go away
so fast are 2.6.32 and 3.2.

Kind regards,
	Sven

[1] http://git.open-mesh.org/?p=marek/batman-adv.git;a=shortlog;h=refs/heads/compat_old_kernel
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-April/002519.html

--nextPart6517880.W2qFhm6Mg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPnO4pAAoJEF2HCgfBJntGPwgQANnsa8rAnwzY1v+UGGbE3QBR
+Y4+K1wG95bxka0SoTLaIMyZk7vFAokcs82FL8q4Po+woTdTu/62RuVFkZHEOAg2
GmstV69SyBKIJNGdJjd6vrYW+T9xGdCMBi22nTDzQL17VNAMd43LbPVb9XzrjIEC
bJOTqEKjZSGrbXsxM41s2XgbParf7dEHAVILWYzn+2gRMPSl04kgu+IMVhsgXs3w
WP0olrqEQTKk8cFEFTEwdQhijDVh5T+aig2s+VlOxnImgRBO+iZYA6rIVw2MTAE4
585Ex1IyrAAHUkk7iytXeJOMmxf8fOmoXbmiojnUBckkdhLNLu+DADW/ReOTAR79
OkyBrCd7E5dkTQbyDNdqMpJ07dlWU00kOfRVZq7MhX+8pZCjlFUOt6y4gt9kRH2L
48V0D7x+ZO18MTIahWpz/8cSit4JTFzCJOPBzJhFZcS8zIk9SSHNqc9a4U8XMDRc
4UjbpjWPcuyqjOl7qcKcJa6fThXneY1ceGCDtEv9OFc+d1ESP1vT050ENfqTc0Ht
27yS9ZOii9Lx4nRbiMJc/pYoiIMcZxJ7Leu6/ISJw6xn8a8jn5B92JZX/GQpFNG7
edAf4poP3mQxwO4HufHQ1c8wJcsJWs8dXyrdSgrNWpmpW5g//ZrgBZviCv8YPeEw
dRro0wdXpivhrkfcWwE1
=zjF6
-----END PGP SIGNATURE-----

--nextPart6517880.W2qFhm6Mg1--

