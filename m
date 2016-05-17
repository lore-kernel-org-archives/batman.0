Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 May 2016 08:33:06 +0200
Message-ID: <2256828.JfWKWoeer9@sven-edge>
In-Reply-To: <1463419689-3580-2-git-send-email-andrew@lunn.ch>
References: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
 <1463419689-3580-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2495001.g5g5M3NNb7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 01/11] batman-adv: Handle parent
	interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2495001.g5g5M3NNb7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 19:27:59 Andrew Lunn wrote:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
> +
> +/* WARNING for batadv_getlink_net */
> +#define get_link_net get_xstats_size || 0 || netdev->rtnl_link_ops-
>get_xstats_size
> +
> +#endif /* < KERNEL_VERSION(4, 0, 0) */

This should be "|| 1 ||" to enforce the immediate return in the function 
batadv_get_link_net. This was also the version submitted to gather some 
comments [1] about the compat-hack.

 * v2 had "|| 1 ||": https://patchwork.open-mesh.org/patch/16003/
 * v3 had "|| 0 ||": https://patchwork.open-mesh.org/patch/16024/

I think I removed this multiple times but this misalignment seems to be 
immortal:

>         return (dev1_parent_iflink == dev2->ifindex) &&
> -              (dev2_parent_iflink == dev1->ifindex);
> +               (dev2_parent_iflink == dev1->ifindex) &&
> +               net_eq(dev1_parent_net, net2) &&
> +               net_eq(dev2_parent_net, net1);

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/15996/

--nextPart2495001.g5g5M3NNb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOrsiAAoJEF2HCgfBJntGgOIP/0PFFR6UIlxv0Y+olbNkfZSm
tN8HTtMwBrIepnZy1D9S+wbVAf/yc7Fh1+HZkzAziCLgYjeP6RcNGc+3dshC42ht
BkyDEeiWm7KNnKxBUJkuy/mlQN3ESa9QvC2n8zitFxymg+HpOcd8YZNS7d56hyph
Myho7DXVorTDT3Izmz2QPMvRmUelDeo7bVS2/IBOdzuD4XkkWs5KfI2ceVJSmyus
baqOha/nFsN/8TQZiqZ5nHfHGPLVCLT+wNT/5R8RYmkVdmIrtjq/LjjGrnlcGIdb
0lfQhZ9UdnPh2/VbiftHuYka207+P8S6jr7RaGUFBVSETDeR5UNrdQ0li3axcCuZ
yekxoSqTWBK7JX7UZryesGrwmAR8YnlZ9e13Zo/o6RgvGyoNVOpni2RLCgsyuC9l
A63sDmn4UMEfe69H3iF3H2Rlzh4f+pOmz/oWPj8qYQI7Ay2aORudaj82B4QillCs
11xhm9kjrkLwaPC/jQ4LoJ4YtGnkg/qnVer+V8DMk+uDCDxtnoEIeyPhEd8+AVlj
1h8eYbX1lPQIn4gEnLY+HfFsfYvAyjZ/uVIQeqDEz/Ma6KFFfTK6Ad56f9Tg77Vq
hF/bmHancZxWBIu62dY1hM4rieO6Ji0gZManWBlPJ5JF+1QErfHUYzdbByAjJ1Fd
ZZSaePnw030qy09Zce3p
=j6ry
-----END PGP SIGNATURE-----

--nextPart2495001.g5g5M3NNb7--

