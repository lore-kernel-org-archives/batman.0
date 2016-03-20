Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Mar 2016 15:02:11 +0100
Message-ID: <2637858.f0vB1PRA5z@sven-edge>
In-Reply-To: <1456817617-5762-1-git-send-email-sven@narfation.org>
References: <1456817617-5762-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1484410.SiK5lWoyNo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2] batman-adv: Disable
	__ethtool_get_link_ksettings compat on < 3.2
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

--nextPart1484410.SiK5lWoyNo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 01 March 2016 08:33:37 Sven Eckelmann wrote:
> The __ethtool_get_link_ksettings is currently used only for kernels >=
> 3.15. But the compat code is read by the compiler for each kernel. But
> kernels up to 3.1 never had the function __ethtool_get_settings which is
> used to emulate this function for kernels < 4.6. Therefore, kernels < 3.2
> will fail to compile when this compatibility layer is enabled.
> 
> Fixes: 3515604d82d5 ("batman-adv: ELP - use new ethtool_link_get_ksettings
> API") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - correct version number of the supported kernel

This patch rejected in favor of the compat(-include) cleanup [1].

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/15942/

--nextPart1484410.SiK5lWoyNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW7q1jAAoJEF2HCgfBJntGfEAP/0vOVje7XtCG0Ixjq3Jlqur3
cZwJ1YTSc6ZN4R/B7BVElQFrjjRR0xaaOYHyvvEyMapOa7JO+VK96VB/C4A2iIEa
TPjNxp3lgFnCN7kIPQ8Ch9zUSpUcsjJfT7R7WqshCT2rQKcj1rU25CffQC0FR2C0
qmWBg4bupF/L5VcwJjVMNHLUbt/TCl3RRxI8jNAio5kTIoJFziY4k9ygq6MA5pIr
m6UKx7j+MypcQpzPrRbki2cy7XgEu3mASu+vrS/UERwt0I/8SVuoCYYYFJGYPmT4
H0QF49PLK3nxeQJ0hRvJGWDfWJSGCq0jXIbjZnK7IJTHDIrI0PTBsnSQT/GKCExi
2gL3eWgzqlE/RqZsdLuhkNsyABzAA1QNQn2Z383XxpBl9y4W37IEg/Xsx1L0tVMK
LItCMcNgfl0vl6Tfnt64wp3h/wtuguRDkPf5AbP1U1zQGCO/Nb4twWOuAql0+dlb
al/IhdmYPJ/wypa3tE9k8bVgZmH3WowZQqDrRMsgQvNVqjeYGK6ZeI/iX2xaS918
toj+0anIPo9vautv2e+enoLuv/yxaljRJbsovkE0OUSC6bzsjrQbMXGDJ7nDWs//
5jw2dwtY51vYTif6afPYlUs08aQBiShGIUtGWaM1Q7n0dPhztxWA4l+cGaZwWz0N
b5UPciwGlaMpcVj+kJ21
=awqy
-----END PGP SIGNATURE-----

--nextPart1484410.SiK5lWoyNo--

