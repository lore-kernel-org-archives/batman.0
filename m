Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 Jan 2017 13:49:26 +0100
Message-ID: <74264595.mJidA94r61@prime>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19043309.p5yLf1qLYS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/9] batctl: relax root privileges check
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

--nextPart19043309.p5yLf1qLYS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 22, 2017 1:20:42 PM CET Sven Eckelmann wrote:
> Hi,
> 
> batctl has a "root" user check since the beginning of this tool. It even got
> a TODO comment in 58525b8330e9 ("batctl: adjust vis.c coding style"):
> 
>     /* TODO: remove this generic check here and move it into the individual
> functions */
> 
> This patchset is now trying to resolve this TODO.
> 
>  * batctl: Move root privileges check in separate function
>  * batctl: Use geteuid for checks of root privileges
>  * batctl: Return type of error on netlink_get_info error
>  * batctl: Make root privileges check function specific
>  * batctl: Allow to retrieve interface stats as non-root
>  * batctl: Allow to read loglevel as normal user
>  * batctl: Allow to read gw_mode as normal user
>  * batctl: Allow to read sysfs settings as normal user
>  * batctl: Allow to read list of interfaces as normal user
> 
> "Return type of error on netlink_get_info error" may look a little bit odd
> in this list. But it was required in my initial test to avoid that
> "originators" and "gwl" try to start a debugfs access when the netlink
> function should have returned a "-EPERM" (but did return a -EOPNOTSUPP).
> 
> Kind regards,
> 	Sven

I've adopted this series into 91b23ca..515cf78.

Thanks!!
     Simon
--nextPart19043309.p5yLf1qLYS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliHTVYACgkQoSvjmEKS
nqFpcg/+MWjKKTCOUX/A34NQY+NvmQkK33JErgtY2HpRuUiW8PCk99L3AqSXQSbw
+3n40K/X1t+EcnldXlNI0Hg6tK4fSI/iwsQKHCHH2I+oH4AoFy/+PzQ67QNPHhdX
/MmzWQ4MsvsRX5/fsKV3vNcjgM3VM1tcpSu37AfFXbfaToCN8WVS5+kdl0jsHvAu
Bz7Q7wh275VxwYricnabJ9XuVSUL8pk/IQP8z/y9LcTGEg8BRq40gNI5MXZ8eNca
3dXEcZlEYgnQphmPNGSZ6c/VXqfJ330JNTQHDol/uIZxnbKu6yzSumh8czMVylnY
S1zlkq2bje1mDCEV6hH5+b7uFaS15Fw59betIGrMJ4+QcCUQdeJLgase4eqPubFF
o+i4sDUXYajK8bw4fvmMm0x0ehbd+aN17ZjYco5+rCxPROr/UyhwyR1da7mWM3y4
gp2sbJeakgaxCsM+V3+UmkLbXuw5OL55gDfJU738x1Gtj7AR/Qva+QPJY+BwqJ5V
9RUVRdlIwuV6zy7FTa04q46cb3k37B349h6NrweqAuRl4PgJSnodB4QRRFUo3+W0
SdClm3EfEI1MC9sYvfbncf2EUv4Ekke9okKkkrL82TaBjLW25q+prTicwdpvVkc7
D9wEgV9/I8afo/ptA+pgwBlvf8mYKeHwxvdW88Heb4ZsTQpRDP8=
=s1PD
-----END PGP SIGNATURE-----

--nextPart19043309.p5yLf1qLYS--

