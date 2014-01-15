Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 16 Jan 2014 06:56:33 +0800
Message-ID: <3472529.36863DVfs0@diderot>
In-Reply-To: <20140115143029.GA20992@medion.lan>
References: <20140115143029.GA20992@medion.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2242535.GhV5qgxGsK";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 OpenWrt] [batman-adv: Makefile: add
	depends for 'crc16' which is still needed but removed accidentally
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


--nextPart2242535.GhV5qgxGsK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 15 January 2014 15:30:29 Bastian Bittorf wrote:
> batman-adv: Makefile: add depends for 'crc16' which is still needed/used in
> BLA-framework (Bridge Loop Avoidance) in bridge_loop_avoidance.c. Thanks to
> Antonio 'ordex' Quartulli for confirmation. The problem was introduced with
> 1ee5b17e4f7b2c145524edfb51617c911fad7cc4 ("upgrade package to latest
> release 2014.0.0").
> 
> Signed-off-by: Bastian Bittorf <bittorf@bluebottle.com>
> ---
>  batman-adv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with minor changes in revision b5a0b78.

Thanks,
Marek

--nextPart2242535.GhV5qgxGsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS1xItAAoJEFNVTo/uthzAgKAH+weVAOK0wGRS+0i0Lu2UjVCQ
z+QHXhIWA9SBw37MLxefHmA/ekwpTXASx2UbbB3bmyPMKH9tM/xWzNdXEYl30JCg
CKqIBJ3P9LS2ru1RR/t7IQvUDMxaNQS4SzQewydBINa7FK9Wk7MjO1VIc+SVl5Ug
hQwkj8zMyfV78kLmBeSQ8vvXM1JdZ+KzCfd4I1APkD/ogP5dtVn5h5DvUnHSCjBo
ewVgJo0YrkMPkKW0f3QmsPZzqTQdoC7vD37gxcnMPs9uZ1iJHcsdPsbpCrtjpnp7
KXeHXGs3EWFga2K88y0cx8xilG5LV4C3jx7OVE7F7VJFUI1qLmGJLbu+gG2xgYg=
=uQIu
-----END PGP SIGNATURE-----

--nextPart2242535.GhV5qgxGsK--

