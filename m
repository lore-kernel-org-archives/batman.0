Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 09 Feb 2017 08:33:13 +0100
Message-ID: <1505249.1X2o3mks0n@bentobox>
In-Reply-To: <CAA_JP8VHB3amFyjwfTtJdc-2E1DgDU5q4NdmVJ6HGVL5g97cZg@mail.gmail.com>
References: <CAA_JP8VHB3amFyjwfTtJdc-2E1DgDU5q4NdmVJ6HGVL5g97cZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1884335.rR9ciycqZz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] bat0 trunk vlans?
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
Cc: a@unstable.cc

--nextPart1884335.rR9ciycqZz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 8. Februar 2017 16:40:38 CET dan wrote:
> Assuming MTU is great enough (1528 right? 1500+24 batman-adv+4 VLAN),
> can the bat0 interface act as trunk for VLANs?
> 
> 2 Nodes:
> bat0:
> eth1
> 
> bridge0:
> eth0|bat0
> 
> 
> 
> device connected to node1-eth0 tags vlan20, does that traverse the
> bat0 mesh and come out node2-eth0 with tag in-tact?  Does it traverse
> node1-eth0 at all?

Afaik, the VLANs not on configured on batX will be rejected since TT was made
VLAN aware [1]. I think Simon and Antonio can clarify this.

Kind regard,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/HEAD:/net/batman-adv/translation-table.c#l715

--nextPart1884335.rR9ciycqZz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlicGzkACgkQXYcKB8Em
e0bqPg/9Hf7TTPPAXfsmYVPzCAGRPxk7KYoWGI7ONKdCrQtv9Sl/RFNbDpR3Sxfj
Z0j/kaYZVqm8RrryXE4Pg4VTOK127013ymrhS4++NTOqaNdSM0RsWR7iNfBUEOcQ
zffBRAoabCBELK1vndz8My3QeIOZV8/mlt7kz63g980UW8PFgZV0EpaibHc3LZ55
WuBpfQxjZHAX/f802qbHpzQJsD8nTw0RcT4bn1Rhu11PnRs7+uEt/4G+Fu5wiSwS
ZJ2t3Mi5kDN+LpBdraBW1aV69TWV5/cM81Z8KafxYG8mm/wHpcXmPhl3XjB1bdb8
XLJTdl+OeGNm3/piU03VfkqLjWdJO4B6sG4djKThcFI0+b5e/Y8naCsQcsBzLXI5
oTAP3/rKFPWewJuDZcGmCWCaQtteI86A5GtYAQqXakLC8IMCSOwOl5qkqTcyFMIF
khNof+TdIY+h9V0lMtkZJuIFLTg36vbLey9LDmwQ17Plsn8inxqIs3SD3vZXECU0
L6kNHWmY46zz0/i+LVqaQvzQjF/RvfwXWYgIf3QmVQdPTVtLp9BDP/09pNCaKXFH
Mxo9KXFzIO6qN/Ic7C1A28Op+6SZIlloCZSYP6S1HbOlSxkCfLmHr+GlX+1K0I0z
PD+GvY0xK3rU1bwnpnGKgUGQR/o3jUVRAePg9jsytdlxz5MZ2hI=
=558U
-----END PGP SIGNATURE-----

--nextPart1884335.rR9ciycqZz--

