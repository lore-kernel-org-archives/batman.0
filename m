Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Sep 2012 16:55:32 +0200
Message-ID: <1860743.fUGhpHrPxd@bentobox>
In-Reply-To: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
References: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1843012.Z27DMFsXqh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix change mac address of
	soft iface.
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


--nextPart1843012.Z27DMFsXqh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 18 September 2012 16:41:58 Def wrote:
>  Into function interface_set_mac_addr, the function tt_local_add
>  was invoked before updating dev->dev_addr. The new MAC
>  addresse was not tagged as NoPurge.
> 

Please don't add extra whitespaces before your commit message.

Your Signed-off-by: is missing.

[...]
> -
> -	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
> +	

Please don't add trailing whitespaces.

I have no idea whether this works... *looks at Antonio*. But thanks for
bringing this up in the issue tracker and sending this first version of the
patch.

The problems mentioned here can be found using
checkpatch/cppcheck/sparse/smatch [1]. We need to drop this patch due to these
problems because the next authorities (David S. Miller/Linus Torvalds/...)
would not be happy when we forward them this version of the patch.

Kind regards,
	Sven

[1] http://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches

--nextPart1843012.Z27DMFsXqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQWItkAAoJEF2HCgfBJntGQrwQALi+WiKt1XQ0RxaM4XWzccSk
81JGGvoQfDzvNm+kJO9ij5EAIYKDO2kcdXDCL1GumXECqZejyQva4K6lpCMsaa4w
4fWwuGCyil718ZAzwMhWwIXsZsDDpt+gZqReV0rREIflBc3J+NMBluV1m1j2ALEx
/J7bQMNQimUb0maZEa9uU0NYtKd5+PxKQGQnTPgJC7gtMImgTyFK1UteukRzxxuG
6cVDdpkZj8J7i4b2uvZVHc6uJX8w5ACPN4HVAcvrq86rtR23jl90DJvnAXbtMrJR
F2e5cImdD7dOdzEMgcyhvdMKpC10I9KZ4C5sFobN+axbxTOD3AVNPRKiv6MdHc0x
X7wuGhihq7Tyd7/8oyulVqo3w4TVb4YcfnWLqCJgezPWnBRFWt4/JK8mlKmAWRnv
+D8cYWONsuhGL7/DC1kb+H5wFYxb0X4jCcvYyhlARTgzbsqJQ4v3gIjj8dp4Ed2F
Fx7SBTQHO/cpOzTm0Xws03AV3XZFO4XQBoma2zJiagYujHdAt4NryxNhvYLZbytT
m4o9Ee45ETg9HIJxv9HJcLfW2/STCpqJWmXBzpOwpT4SVo5uT8kfbDZyA25E+7Wy
PsUOCZGTMmOcYYxdXmRa0+OcIQowvbh/T6kV+bHOZJC9gneTD3k9hcgtLJrnVm8J
1tIxSra/j/CDE/f6WmR9
=v9eC
-----END PGP SIGNATURE-----

--nextPart1843012.Z27DMFsXqh--

