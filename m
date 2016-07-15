Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 11:16:21 +0200
Message-ID: <16322396.eo658KfjTQ@bentobox>
In-Reply-To: <1468574017-20993-1-git-send-email-sven@narfation.org>
References: <1468574017-20993-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8593059.VYPk8z8WSV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Allow to disable debugfs
	support
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

--nextPart8593059.VYPk8z8WSV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Juli 2016 11:13:37 CEST Sven Eckelmann wrote:
> The files provided by batman-adv via debugfs are currently converted to
> netlink. Tools which are not yet converted to use the netlink interface may
> still rely on the old debugfs files. But systems which already upgraded
> their tools can save some space by disabling this feature. The default
> configuration of batman-adv on amd64 can reduce the size of the module by
> around 11% when this feature is disabled.
> 
> Before:
> 
>     $ size net/batman-adv/batman-adv.ko*
>        text    data     bss     dec     hex filename
>      150507   10395    4160  165062   284c6 net/batman-adv/batman-adv.ko.y
>      137106    7099    2112  146317   23b8d net/batman-adv/batman-adv.ko.n
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is build on top of the netlink patchset. It is 100% like the RFC

And now I remember what I wanted to change - can you please remove the
"Before:" in the commit message before applying it?

Thanks,
	Sven

--nextPart8593059.VYPk8z8WSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXiKnlAAoJEF2HCgfBJntGbpQP/3mvtA81mJjBlSg7rd2mEcQ0
4hVEwUUvmVamhLvor2RCwetXcjQwrYBi2ApNUT/Rl+C61uV6smKKvoN0gKQ+dHK2
ZAPSrZqwYgh8Hqj8VWyiFHvp7PgqFgzxXjEQNrVIOpCF7Gy32htFUxP5iqxubIN3
IStnPRbP+rjxD4V9rNY/PmUmMAhax3+R6dtXSLgGt28EQY/dGa3JYj23OcmhKJLn
Up529frduV7ZGtJUQNCJXpRbjvGmRsm1DWzWdCgtCrJvg0LAUq0ADgRtsyNAYxow
RQqiNOdkwmfQ98WEF49Jn5VNQdcbeNODRv5J5WD5VWFgCnnJuSRCWZUxoie5ojDr
9mgAWwBJWbgfS28+KgQ+eZyCDAsXy4G0DgOnJjCX28wE92yXcMwBNt/GgGWBNx1Y
mV3YfqC1RE+fIVEiCH5BJ0m0UnpEePVNNet8ptgBPoa1iDSIAiWJC6Wd6T48ajKg
mbCsw03Tr2z7Ty/2Ai9jpaZe0ebs02sYq+5u5VNOT773vUbqjSNgU8UdBY4H2rXw
2t6X6w8hQsNvq+MfZF6eTriioqHWa/cXCcHDKQAaXk1ZkN0VgDu9gsT+PCNkytoB
bKlemCRTtn0O95CTIRVA0/xStfO1r8d3fQMV9ao4YHQtU5wAEIpF/v5GCozoKPNO
4LSb0nhtuktniUlhq4HP
=UpXS
-----END PGP SIGNATURE-----

--nextPart8593059.VYPk8z8WSV--

