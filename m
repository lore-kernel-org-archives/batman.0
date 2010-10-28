Return-Path: <xiaoxianghua@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTima7xg=zOz5M1PKwfoyTJc1LO_XZ23efjVh0oZ9@mail.gmail.com>
References: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
	<1288044374-11771-1-git-send-email-linus.luessing@web.de>
	<AANLkTim55WkJkmC8u-BidPaVH1J=hEJs2v09d-NUH4KH@mail.gmail.com>
	<AANLkTima7xg=zOz5M1PKwfoyTJc1LO_XZ23efjVh0oZ9@mail.gmail.com>
Date: Wed, 27 Oct 2010 21:02:11 -0500
Message-ID: <AANLkTikemzJPeFGQCjGi636pJ21TF3JDHtFGfqTWV80b@mail.gmail.com>
From: Xianghua Xiao <xiaoxianghua@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv multi-hop route
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, linus.luessing@web.de

On Wed, Oct 27, 2010 at 8:17 PM, Xianghua Xiao <xiaoxianghua@gmail.com> wro=
te:
> On Mon, Oct 25, 2010 at 5:16 PM, Xianghua Xiao <xiaoxianghua@gmail.com> w=
rote:
>> On Mon, Oct 25, 2010 at 5:06 PM, Linus L=C3=BCssing <linus.luessing@web.=
de> wrote:
>>> Hi xianghua,
>>>
>>> for such test cases basically this patch had once been made to force ba=
tman-adv
>>> onto certain routes but needed to be removed again as the way ebtables =
is
>>> used here is not standard-conforming. However, this shouldn't bother yo=
u :).
>>>
>>> You can then just use ebtables to prohibit certain routes:
>>>> ebtables -I INPUT -s MAC -j DROP or
>>>> ebtables -I INPUT -p 0x4305 -j DROP
>>>> (and the same for -I OUTPUT)
>>>
>>> Antonio had been doing tests with this ebtables patch, too (see this
>>> mailing list's archive from about the 10 May 2010).
>>>
>>> This is a revert of the revert of commit 660d20261343e0b2ff57e51e50d7eb=
0e557d5e5b.
>>> and applies on top of the current git master branch. If you need it for=
 any
>>> other version of batman-adv, try 'git revert 660d20261343e0b2ff57e51e50=
d7eb0e557d5e5b'
>>> and if that doesn't work, just bug me again :).
>>>
>>> Cheers, Linus
>>>
>>
>> Thanks!
>> Will give it a try.
>> Xianghua
>>
> ************A*******************
> $ git revert 660d20261343e0b2ff57e51e50d7eb0e557d5e5b
> Automatic revert failed. =C2=A0After resolving the conflicts,
> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
> and commit the result.
> ************B*********************
> $ git diff
> diff --cc send.c
> index 16ffd03,283c6bb..0000000
> --- a/send.c
> +++ b/send.c
> @@@ -28,6 -28,8 +28,11 @@@
> =C2=A0#include "types.h"
> =C2=A0#include "vis.h"
> =C2=A0#include "aggregation.h"
> ++<<<<<<< HEAD
> ++=3D=3D=3D=3D=3D=3D=3D
> + #include "gateway_common.h"
> + #include <linux/netfilter_bridge.h>
> ++>>>>>>> 660d202... batman-adv: Revert "Adding netfilter-bridge hooks"
>
> =C2=A0#include "compat.h"
> ****************C*********************
> $cat send.c
> <snip>
> #include "main.h"
> #include "send.h"
> #include "routing.h"
> #include "translation-table.h"
> #include "soft-interface.h"
> #include "hard-interface.h"
> #include "types.h"
> #include "vis.h"
> #include "aggregation.h"
> #include "gateway_common.h"
> #include <linux/netfilter_bridge.h>
>
> #include "compat.h"
> <snip>
> ****************D*********************
> ~/devel/mesh/batman-adv$ make
> make -C /lib/modules/2.6.32-25-generic/build
> REVISION=3Dv2010.1.0-52-gdbfbc90-dirty
> M=3D/home/xxiao/devel/mesh/batman-adv
> PWD=3D/home/xxiao/devel/mesh/batman-adv -j 1 modules
> make[1]: Entering directory `/usr/src/linux-headers-2.6.32-25-generic'
> =C2=A0CC [M] =C2=A0/home/xxiao/devel/mesh/batman-adv/main.o
> =C2=A0CC [M] =C2=A0/home/xxiao/devel/mesh/batman-adv/bat_debugfs.o
> =C2=A0CC [M] =C2=A0/home/xxiao/devel/mesh/batman-adv/bat_sysfs.o
> =C2=A0CC [M] =C2=A0/home/xxiao/devel/mesh/batman-adv/send.o
> /home/xxiao/devel/mesh/batman-adv/send.c:31:28: error:
> gateway_common.h: No such file or directory
> make[2]: *** [/home/xxiao/devel/mesh/batman-adv/send.o] Error 1
> make[1]: *** [_module_/home/xxiao/devel/mesh/batman-adv] Error 2
> make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-25-generic'
> make: *** [all] Error 2
>
> so, where is gateway_common.h?
>
> thanks!
>

sent out too fast, I removed that offending line and it compiles. never min=
d.
