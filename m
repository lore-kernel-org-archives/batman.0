Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Mar 2016 16:07:26 +0100
Message-ID: <2403718.s2TxdbNBZZ@prime>
In-Reply-To: <1456492719-29748-1-git-send-email-apape@phoenixcontact.com>
References: <1456492719-29748-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7401462.enXTBsQLuZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/7] batman-adv: prevent duplication of
	ARP replies when DAT is used
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

--nextPart7401462.enXTBsQLuZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 26 February 2016 14:18:39 Andreas Pape wrote:
> If none of the backbone gateways in a bla setup has already knowledge of
> the mac address searched for in an incoming ARP request from the backbone
> it must be prevented that multiple ARP replies are generated and returned
> to the backbone by the dat address resolution mechanism of other dat
> enabled nodes of the mesh.

Isn't this patch somewhat redundant due to the change in patch 4? In that 
patch we already drop unicast packets, and this patch just adds a check for a 
more specific unicast subtype ...?

Thanks,
     Simon
--nextPart7401462.enXTBsQLuZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4Y2uAAoJEKEr45hCkp6h450QAMMNiIndTb3X+xS/KPIGIcvP
kNFWektqKu/lxtxqmsQMwEUoXxZQDhyGZQqDglD83UtlH5IE4lZgJvexlxzyf8Bs
M1pz8GdAMNoLggjx7efjLYIY3R5Ls/H+TIQhaCh8b3xj5wvwiG9lO2G4q1OGbBEZ
GLcu9h0iOLBJPi5J/9GdjIaq/1PpUIpvf5jbwS5latS5mqoyfLbQ/dVrxoKmKY5A
TSRQ2YH4oFNlRDZMH7fr2bMCt/A4VczfnSD2EhfwWbLLyR8bUYq7i5MVP5pBcSvI
bhFaZ/7SrTgVN8pM4C3a9gkKE6uFhrAw1rRbWCjsgRDwaC/4mqP40Uqu0py3dUof
PE0p4F8UtfTBqBKJo9ofiCxePCHawQr8LWNz37iFiIZ3Sb4UFpfsO466kf4g5+WL
S2mpPgnBDv/wvODkm8kH5ySEIBSxhkUqI2ydYqIabRxbnIIXrrV3TOmiXhGV2ae1
I3YzXHLuOYLGW/tPnAKjvjPME5qGp6Fwr7IeHbgPrLFe/B/pCcRB1xH7xO5V1dM+
L1hudzyQY855y5gV8v1JiCZhHLLVQz6cWDnN3TNovZN8tssZl3aFXZaVtdd5rFSO
7Q6qTRUS4K57ahwXHdSPZvjMjwBGNlVJnI5eh++uPaAxKldvYglBBIx3k+aqNYvY
HeWPqdQUda9g4PNsRXRs
=nPeb
-----END PGP SIGNATURE-----

--nextPart7401462.enXTBsQLuZ--

