Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Feb 2016 09:27:02 +0100
Message-ID: <10278318.qWhkaFWykG@prime>
In-Reply-To: <OFB1894E97.63E32850-ONC1257F57.004C41B6-C1257F57.004C4F9E@phoenixcontact.com>
References: <OFB1894E97.63E32850-ONC1257F57.004C41B6-C1257F57.004C4F9E@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2577224.aCydo9OkA2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: prevent duplication of
	ARP replies in BLA setups when DAT does address resolution
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2577224.aCydo9OkA2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 12 February 2016 14:53:31 Andreas Pape wrote:
> From 2cc1e9eb153d0c2d64cb0fb0747063ba63472925 Mon Sep 17 00:00:00 2001
> From: Andreas Pape <apape@phoenixcontact.com>
> Date: Fri, 12 Feb 2016 13:19:25 +0100
> Subject: [PATCH 3/4] batman-adv: prevent duplication of ARP replies in BLA
> setups when DAT does address resolution
> 
> This patch covers the case of a bla setup with enabled dat if none of the
> common gateways of the
> same backbone has already knowledge of the searched ip address and
> therefore has to ask via DAT some
> of the other mesh nodes. A broadcast arp request is coming
> from the backbone and each backbone gateway starts an address resolution
> via other DAT mesh nodes.
> In this case it should be prevented, that multiple answers from DAT
> enabled mesh nodes reach the
> backbone gateways leading to multiple replies in a common backbone again.

I think this approach and its methods as implented are good. However I think 
we should generalize this case and forbid UNICAST/UNICAST4ADDR between 
backbone gateways, as discussed in the other thread. 

What do you think, or does anyone else have opinions?

@Antonio, in what way would be the DHT in DAT be affected? Basically, we would 
exclude some orginators who are on the same backbone.

Cheers,
     Simon
--nextPart2577224.aCydo9OkA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWwYvWAAoJEKEr45hCkp6hpJYP/A7o2l/RnrdxO/l38ntPbR9t
ov2/VVI6iklWZ+sdhy4BADtXa5qiry+VRNFTgvOYf0jtc3wCzAQ4EMogGCaGpRVl
q1GAL6aHX6+mefGliun0EVREYCnFf+RIBcoFOQSWYus3A1SWVW9wJekqTD9eEWkk
oRP3sROwTslEqoEVyfcf42+1Cnl5d/bsZyn20a3+QRq57t7X5cR7WvNh9F4EtCmw
rEu/4xN/bB7JsTa1/VHL2/krZvPDlvBAhZdQB+9uv5IOyTpemkaOHd5SpnqbSk0b
NF77HfiRMcQS2nkXLFb/KRsJ0S8OkoPmrPvh965YYsr1ARRyVUug7QW08m2tTovv
i96I4Ercsrk+B2rzmpj6cUulkraMJ9ttNVzV1zsep6HG6C6hlWtaxy4PHYdESVIh
Z5mOlQoVs5t+rW1Hd/48BzQl2M2kW58rC6TfIufS7Y6mWHHPacBbGZe8d4O2PAZ4
iS35Cur/D7bU3tKnVrQKhNWm16P+SBgSmsUTsU3kqVwfPJrkbVYLtQI9Gv2KDpOM
xMUcgXVhtBm2ZqKkTtg3ELIqYDSZlmzhOnZ5wwtTD3YIOdPWfG2cTxPmPPGIRYt4
4AIayBa3gWpROi5odERmZL88EcGYS7almF94FcoLqw9KdfppMPOqppltBaA40a9W
3B02+JEKj1+1TSljA4FT
=Xklz
-----END PGP SIGNATURE-----

--nextPart2577224.aCydo9OkA2--

