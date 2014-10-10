Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 10 Oct 2014 20:53:10 +0200
Message-ID: <2009038.MjEnzh0HNt@prime>
In-Reply-To: <BLU182-W6143FFCB0F3DF09663246A8AA20@phx.gbl>
References: <BLU182-W625D2EA8376C93F5232A848AA20@phx.gbl>
 <BLU182-W8782C810EEA0F5B35A10F08AA20@phx.gbl>
 <BLU182-W6143FFCB0F3DF09663246A8AA20@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1480808.gYU7IoMrp6";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Inquiry on interface alternating
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
Cc: MingAnn Ng <devil_eddie01@hotmail.com>


--nextPart1480808.gYU7IoMrp6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-1"

Hello Ming Ann,

we had quite some changes for the interface alternation which were released 
with batman-adv 2014.1.0 / kernel 3.14. Could you please try your scenario 
with the latest batman-adv to make sure that we are not talking about old 
implementations?

Here is a link which describes more technical details about the new 
implementation:

http://www.open-mesh.org/projects/batman-adv/wiki/Multi-link-optimize

Thank you!
    Simon

On Tuesday 07 October 2014 17:10:26 MingAnn Ng wrote:
> Hello,
> 
> I am currently running some powerpc machines with buildroot environment. The
> Linux kernel version I am using is 3.8.13 and BATMAN-adv within the kernel
> without any modification. I am running interface alternating test with the
> topology below:
> 
> A========B=========C
> 
> There are two wireless links between A and B and two wireless links between
> B and C. The two wireless link is using two different channel and ESSID. TQ
> of the 4 links are vary from 250-255 at the initial state. I run udp iperf
> from A to C and observe tcpdump on node B for the two wireless interfaces
> (wlan0 and wlan1).
> 
> I observed that interface alternation is not happening always. Sometime the
> route will be using wlan0 or wlan1 all the way from A to C, as we observed
> at node B, only 1 interface has traffic on tcpdump. Sometime when interface
> alternation happened, tcpdump for wlan0 and wlan1 will show traffic.
> 
> I changed the topology to the below to test further:
> 
> A---------------B=========C
> 
> There is only 1 wireless link from A to B while there are two link from B to
> C. In this case, I observed that interface alternation will always
> happened, as I observed both wlan0 and wlan1 has traffic on tcpdump.
> 
> Could you please explain to me what has caused interface alternation not
> happening in the 1st topology and why the interface alternation will always
> happen in the second topology.
> 
> Thank you in advance,
> Ming Ann

--nextPart1480808.gYU7IoMrp6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlQ4KxYACgkQrzg/fFk7axbtsACeMUx30fMoEr++R0EawuqAQvsM
mCgAmwY7df3X9EubQDeS0nSoczBfua2I
=05VW
-----END PGP SIGNATURE-----

--nextPart1480808.gYU7IoMrp6--

