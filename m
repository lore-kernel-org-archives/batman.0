Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 29 Jul 2018 23:38:53 +0800
Message-ID: <1833430.pAuEAP8rMv@rousseau>
In-Reply-To: <CALb7xhz53Z+ykBxAGgEb5oixf-KVHXTc_ooECZ2ZMARxDvvnfg@mail.gmail.com>
References: <CALb7xhwsssLtKnT+Y8pmVch7OOUdUQ_n+yN61tUfQx7RE0KOCw@mail.gmail.com>
 <5556611.7sBE4ScoTE@rousseau>
 <CALb7xhz53Z+ykBxAGgEb5oixf-KVHXTc_ooECZ2ZMARxDvvnfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2921347.pXAQ2IlO0X";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] ICMP6 flood or nodes limit ?
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

--nextPart2921347.pXAQ2IlO0X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 26 July 2018 14:14:14 HKT Nicu Pavel wrote:
> I'm also not sure about the originators list, if you look at the
> attached file, all originators TQ is pretty low and also each
> originator has all other hosts as NextHop. Not sure if this is correct
> or can affect.
> All these 30 hosts are pretty close to one another.

It might be (as Linus has suggested) related to poor connectivity / airtime 
overcrowding. Though for that to be the case, I'd expect a more gradual packet 
loss symptoms - not a complete collapse when you switch from 31 to 32 devices.


> > If you check the mailing list archives you will see the wifi driver issue
> > coming up on a regular basis. This example discussion is merely a few days
> > old:
> > 
> > https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-July/017952.html
> 
> Yes, I found that thread, but problem is quite different as with
> RealTek chipsets seems like nothing really works.

My point was rather to consider that the WiFi driver has its fingers in the 
pot too. It is somewhat unlikely that your issues are exactly the same as 
mentioned in this randomly selected thread. 

By the way, searching for 'brcmfmac adhoc' returns quite a number of hits 
mentioning complaints concerning Rasberry PIs. Have you tried running your 
setup without enabling batman-adv at all ? Since all of the devices are so 
close to each other batman-adv is not needed. Pure adhoc mode will work just 
fine. This test will help you figuring out whether the ICMPv6 misbehavior is 
related to batman-adv or not.

Cheers,
Marek

--nextPart2921347.pXAQ2IlO0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAltd340ACgkQU1VOj+62
HMBnqAf9EnJoz8CjwQdopNIHB4mEG+/gfoAL4I3FCr2XrKJz0Kac+e8ve0rdlWVB
L0hHjO0ZR5yXRhFbuAR+gj1St8UJimEe+fRFGfqbNp7s7VVS3+OiRwFeXxdDH6Yp
nWSkbIi2pPXjAA0rDTqkYFUQrRXV0SbPCVQphBAQ4eY6lgFlidJcPeeD75IkhRQH
9VZA59dg9bTmLGp6tB1mbVaFHbxOkAgYRgQ+qRi+n5G4tuAH2MKbocTx/9rTRLQT
UfCsl3b7SMbXCY/udPAlqsIwge3FZK8rYrrDipvJbJ0XSy+f5XxYR+Rj1ewmnJwF
VhcqJeTG/cyfluY52uid0Y6qohFKMA==
=8/sX
-----END PGP SIGNATURE-----

--nextPart2921347.pXAQ2IlO0X--



