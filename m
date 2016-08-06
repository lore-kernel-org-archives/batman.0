Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 16:29:28 +0200
Message-ID: <1513365.CMgdGlnam6@sven-edge>
In-Reply-To: <2277921.TikbSnUKEq@sven-edge>
References: <1468793741-4606-1-git-send-email-sven@narfation.org>
 <20160806044244.GA13676@otheros> <2277921.TikbSnUKEq@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2827611.l4CacGYnjJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't allow zero and
	multicast sender address
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

--nextPart2827611.l4CacGYnjJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 6. August 2016 10:27:08 CEST Sven Eckelmann wrote:
[...]
> > For data packets, I'm not quite sure, though. Could be interesting
> > to not restrict that now to still allow enhancements regarding
> > privacy, I think. And zero-source MAC addresses shouldn't harm
> > anything in the case of data packets, should they?
> 
> So you would prefer here that is_broadcast_ether_addr is replaced
> for bcast and ucast packets with is_multicast_ether_addr? Same for
> patch 2, right?

Hm, no. This doesn't make any sense for patch 2 because patch 2 is about the 
destination and a destination with zero mac address isn't valid. Or do you see 
any reason to accept zero mac addresses as destination in the outer ethernet 
header?

Kind regards,
	Sven
--nextPart2827611.l4CacGYnjJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpfRIAAoJEF2HCgfBJntGve4P/2MZFTu6uHLUdqwodRsni7dG
0aClsyOzYFIou+pw0RzY+vD2U95k5o+is73s6CheGFyUq4cqKupULZpzqZb9W7hD
l6bOPWaMgQ/i3q5uhiJ4O3PeaL+uPyHtvel2lbLGzQMEluKDrBzw9odZdPRRLLhH
wCnsE/FFPzp9SeKhdEHMPFU/vn2Z0qq+Onn/GfB0IZ6hNzJj5oxqMHBT463ix+Y3
40PoqWIzZPasIto8xVZXt84VHG1M3kQJyu8E/fcGA5nBfFQGaemJJKD3fs1W1ACh
EFuskDFiDgomWovyiNEASFdYC0V5UhH+XmVpq5QafeWijM7v8M4Bq9lN7yRSE4Jq
HfmIF24bYER36ZsTfIbXNDpuyk3gAdNyqkjFPuBR2JfU9nvG74z1CPHTisIfD5xx
E5PZls1ylXIg3jPhu1GVRr0d8/e1nNEPQ+C5HGm/vViAuzKdtZc3/MtTtGiAK6i9
IAeVxu/p6e/qxm+HdOpCYVEl4DOHTj3aVIzlTuVYYMOuXVQzPO7t2A4fLW7Xtnn8
VFtYwCFsq6TaiV0baNM+O69oDhjzWECR11sFs2ix6hy9mA5abTtIgHYIA+Rs2ZyC
pxIvkphMvGygmECxuigEIJ20Z+EjFjPAhnltRJs6awazEOK97HYitEe71v46P0h0
sRk4zLnKiqKTqSCIrEpw
=Yz8S
-----END PGP SIGNATURE-----

--nextPart2827611.l4CacGYnjJ--

