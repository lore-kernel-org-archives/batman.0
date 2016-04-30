Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Apr 2016 12:02:18 +0200
Message-ID: <1674670.e5OSy8hi8m@sven-edge>
In-Reply-To: <1461970765-24615-8-git-send-email-andrew@lunn.ch>
References: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
 <1461970765-24615-8-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1501387.d1lN5L59Lt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 07/12] batman-adv: netlink: add
	originator and neighbor table queries
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

--nextPart1501387.d1lN5L59Lt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 30 April 2016 00:59:20 Andrew Lunn wrote:
>  /**
> + * batadv_hardif_neigh_dump - Dump to netlink the neighbor infos for a
> specific + *  outgoing interface
> + * @msg: message to dump into
> + * @cb: parameters for the dump
> + *
> + * Return: 0 or error value
> + */
> +int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback
> *cb) +{

Ok, having the kerneldoc here is also nice but I actually meant the kerneldoc 
of the struct members. kernel-doc is still warning about the missing member 
documentation in your new version.

Kind regards,
	Sven
--nextPart1501387.d1lN5L59Lt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXJIKqAAoJEF2HCgfBJntGdXgQAIjzRh9eQNgB+ZOHxt4TRcJw
ub26eDfZ0iJkkQCY3cdKlWQK84/3mWOLu//15Mk/4fReMe4M4kiFec6/dWmUYCGu
pV594uMTqdJEoe2COk3rt4JQlJemynjWowKFGSTqGqumuYAA4PnFWkIew9foNKNN
N4mGMUOsbN6ue3BaNpDfoHsRdC4jefUGj6bMemU0O2V63ogFi/30bxMOH4mQO9j/
C3CDxuy1I1RMgCqmmeppDDFpkislonJoayDOAOjPEVud6n+UpSqHHfgRRtgI41Bt
0kcRxzDjjBcbhx805gKE2KgkUi0E3y+OH2QQpso7cMbNlZwjNiOzqOcZfUSLzHgE
oHUiIVeSef6T86jfUWNSu82Eb/SYGcx5uaa6463/ku7NOS3WXWkrJXTS20ntXENc
JEBhrOMyATQV8SmuvrWyYaQQMhi5Vhw/5EQaxWx0yaevzP99b1chF5Iht/yuEiMG
fDepgHN8BHDTuLTev4GHF/JgZATtro4OnPCfonmXvuxhru1HZJA5ViSNiM8GhB0g
2QHztK66TZOTmZA4ADiqI5k9d07lLJc/zYAdJsT6XcG0LU6zw6tnKvfaKV+L9e80
LUZRjnpqoeA5Ulc0x+HID1yXJNUhDslGGXsjDef2Q3xvyZ+HvUxQyXym0goL3nAx
Lfj4ixSHEXzfbSe+R+mx
=tN+N
-----END PGP SIGNATURE-----

--nextPart1501387.d1lN5L59Lt--

