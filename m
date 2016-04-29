Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 07:55:23 +0200
Message-ID: <1765345.Svy6en6aiH@sven-edge>
In-Reply-To: <1461876897-12677-3-git-send-email-andrew@lunn.ch>
References: <1461876897-12677-1-git-send-email-andrew@lunn.ch>
 <1461876897-12677-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4108370.9ugzr8ZGAE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Use netlink when available,
	rather than debugfs
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

--nextPart4108370.9ugzr8ZGAE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:54:57 Andrew Lunn wrote:
> The kernel has gained support for exporting information via netlink.
> Use this when available, rather than debugfs. Netlink has the
> advantage of being network name space aware, where as debugfs is not.
> 
> If netlink is not available, batctl will fall back to debugfs, so
> should be backwards compatible with older kernel versions.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
[...]
> +	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
> +	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
> +	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
> +	ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
> +	last_ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_LAST_TTVN]);
> +	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
> +	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);

You are accessing a lot of data without checking if it exists and is from the 
correct type. This was discussed in an earlier mail [1].

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014722.html

--nextPart4108370.9ugzr8ZGAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXIvdLAAoJEF2HCgfBJntGt7gQAL7uR1limnAVyh++DGZSSmhQ
bw1780YMAuV5B+Ny7CUzOX5x0FuQUI45bemdaJr8+uKoMSpS3OLGhBVVc3H9GNCX
DdAYP7ZRt9d25F6n1UoV9Oi24RQC2cCUys0urVvf5uAGriE5+i2D+1nQQ7t/SEg/
Nm/0EmELOBglUJNG4QgJWJEcU/BjIB7AGuAxniu2k8iJwpnlVtOh7aHFv7ZmLtMG
Yeyf+YyqAsLhUm3oiQm7dY2nzhZlikjIFGTY8MKQ8XorRjJPk6qlRltHI6FJkiCn
v83zlxFzqF79Oc2hHjbL5Bk07LUt/0aY/vYQ0DdPBATIIIPQOAIuc746JXUJbkYe
yCjUbs2vWvBv9TP1Wx0gJe7jTwNbkmtaJd9efazZxAKeIIhEnhrvhaaDQmMZig0Y
a+Y+PLbDlJ3q0okYBC2diGrISPZoh6uxHZ0iINfieObFrMHaHqXfWHcv80DGv5Ba
lb4j8oNVIh+UOQidD9mkRSDEsv5n1cnXLP/o8z/OHfucBAp6efa5Q17PHgqRicOI
SHsTROXYI44tdc3ZQvxykJqocPNonTmrJhRmVEzF7VmFNwPr15EQQppuTVqy3M8l
t+5A+Nk4Vbk2bK6hI2nT2fxhtk+AU1A68yivW+7GfeeJaYe4UWmnL3gpbEIGyik2
HdFWP2PumPS7errxG7FY
=FgLZ
-----END PGP SIGNATURE-----

--nextPart4108370.9ugzr8ZGAE--

