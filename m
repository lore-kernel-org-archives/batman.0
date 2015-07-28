Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 28 Jul 2015 23:26:39 +0200
Message-ID: <4295569.IGlg6EAz40@prime>
In-Reply-To: <CALaFpeUeV9sOnBp=oj-gfjbFd=hd=SPMBPE7+VS+Q6S0e9tsbg@mail.gmail.com>
References: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
 <11411625.XETR6nI4Wt@bentobox>
 <CALaFpeUeV9sOnBp=oj-gfjbFd=hd=SPMBPE7+VS+Q6S0e9tsbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1613113.xYEmyrkb4a";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recover in case of node fail
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


--nextPart1613113.xYEmyrkb4a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Carlos,

On Sunday 26 July 2015 19:27:28 Carlos Meralto wrote:
> I tried "batctl ping -R MAC" and the node recover well. But when i try
> "ping IP" does not work and the ping blocks...
> It is normal that this happens?
> 
> Best Regards,
> Carlos Meralto
> 
> 2015-07-23 8:57 GMT+01:00 Sven Eckelmann <sven@narfation.org>:
> > On Wednesday 22 July 2015 20:01:51 Sven Eckelmann wrote:
> >> This was not what I said. ICMP ping should work perfectly fine. I just
> >> suggested that you try `batctl -R`
> > 
> > batctl ping -R ...

it seems strange that batctl ping works but normal ICMP ping doesn't. A couple 
of things you could try are:
 * compare tt tables before and after you remove the router (batctl tg, batctl 
tl)
 * check arp tables (arp -an)
 * check using tcpdump (or batctl tcpdump) if the packets are actually sent, 
and if yes, where they get lost

I assume you are using batman-adv in a recent version for your tests? Also, 
are you using ad-hoc mode? If you need more help, you should try to describe 
your setup in more detail.

Cheers,
    Simon
--nextPart1613113.xYEmyrkb4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlW3848ACgkQrzg/fFk7axYsqQCg3gdzgjQXHk/nTK0vwgs8KKBL
iagAoIi1DQ6+956IMWVYZOtlrIcW7xs5
=wTxf
-----END PGP SIGNATURE-----

--nextPart1613113.xYEmyrkb4a--

