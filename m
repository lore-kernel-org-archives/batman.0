Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:30:25 +0200
Message-ID: <7277042.g0rG2STMS3@bentobox>
In-Reply-To: <20160916071022.22560-1-sven@narfation.org>
References: <20160916071022.22560-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7068195.8TCJeUZGzR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [next] batman-adv: remove redundant #include
	<linux/kconfig.h>
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

--nextPart7068195.8TCJeUZGzR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 16. September 2016 09:10:22 CEST Sven Eckelmann wrote:
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Kernel source files need not include <linux/kconfig.h> explicitly
> because the top Makefile forces to include it with:
> 
>   -include $(srctree)/include/linux/kconfig.h
> 
> Link:
> http://lkml.kernel.org/r/1473656164-11929-1-git-send-email-yamada.masahiro@
> socionext.com Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/debugfs.h | 2 --
>  1 file changed, 2 deletions(-)

Applied in d9ca9a3c1687e25511fd0e8ab1cc520083664c24 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/d9ca9a3c1687e25511fd0e8ab1cc520083664c24
--nextPart7068195.8TCJeUZGzR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgfRAAoJEF2HCgfBJntGnoQP/jUwMR33FraSwHFOer2OwqjJ
L9LaUNMOEdqCLIFwsBbvO6TJFcQluy+aV6yA2ndYELU4+XsKHicd+RmZbNzTYwkS
bSgCDZWqSk2ByI7NMpnrUne9MGV54edgUosLmbAfkjoYPz+ZoNJU8fMS4Ooni4WZ
LRKZX6dyAfQkfDDII3gEhc29hXO//Gpvdy0hervjvSm3l7HzIeZPyawiP7nVluWY
vK8ObwnsP9V63N/iPavwV09fJF9lo2Uur33gcENatlYIJQzk4RsjgoFWzUDJyG3T
RRk1iBm+ADWXzPWtSxl2v0GuEAs1kI1pgzTeECSjf1+h2Q+AL8bRCwc7TY4ep8Ne
K34SQngCI/W4159BfQd8H2YKLj8yvvkT/DCMKC5JA8UzWfVGMl/ZOk3bOqy1Rpxd
GQ1c6I+1GiRltyv87vv+xGsHIwkyvHgZSwKy7ohzd/QNleUu8vdi2nl+1JXH34Qj
93TdQ6qsr4WrMGBNESbubqpR/oJjuI9Pccj0Y7RSMYsAxLklT8rlg7Qtj+qXGDfE
hZsV8n6wy879jufvlrZ5bcLxQ4YQOZC3wKyzx/daGjmem8YbDiNitFGWYX4iPV8W
TCejaQJVTgqtVfH/0qC/aPxC8q4yiLpfKb2WbWLq1IlAES/StnrN1wQLwdQkZxIS
uT0JBVw9dZ05YbK2gTxD
=fcf1
-----END PGP SIGNATURE-----

--nextPart7068195.8TCJeUZGzR--

