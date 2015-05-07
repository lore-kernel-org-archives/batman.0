Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 07 May 2015 09:33:17 +0200
Message-ID: <1572715.c14tfryD1Z@bentobox>
In-Reply-To: <1430940562-12148-4-git-send-email-linus.luessing@c0d3.blue>
References: <1430940562-12148-1-git-send-email-linus.luessing@c0d3.blue>
 <1430940562-12148-4-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/3] compat: Compat code for IGMP/MLD
	report unicast forwarding
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

On Wednesday 06 May 2015 21:29:22 Linus L=FCssing wrote:
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  Makefile                              |    4 +
>  compat-include/linux/igmp.h           |   13 ++
>  compat-include/linux/skbuff.h         |   14 +++
>  compat-include/net/addrconf.h         |   13 ++
>  compat-include/net/ip6_checksum.h     |   18 +++
>  compat-include/net/ipv6.h             |   17 +++
>  compat-include/net/mld.h              |   52 ++++++++
>  compat-sources/Makefile               |    3 +
>  compat-sources/net/core/skbuff.c      |  136 +++++++++++++++++++++
>  compat-sources/net/ipv4/igmp.c        |  169 +++++++++++++++++++++++=
+++
>  compat-sources/net/ipv6/mcast_snoop.c |  216
> +++++++++++++++++++++++++++++++++ 11 files changed, 655 insertions(+)=

>  create mode 100644 compat-include/linux/igmp.h
>  create mode 100644 compat-include/net/addrconf.h
>  create mode 100644 compat-include/net/ip6_checksum.h
>  create mode 100644 compat-include/net/ipv6.h
>  create mode 100644 compat-include/net/mld.h
>  create mode 100644 compat-sources/Makefile
>  create mode 100644 compat-sources/net/core/skbuff.c
>  create mode 100644 compat-sources/net/ipv4/igmp.c
>  create mode 100644 compat-sources/net/ipv6/mcast_snoop.c

The split header files were only there to fix the problem of the header=
 mess=20
which couldn't be resolved with a single compat.h that forced a specifi=
c=20
include order. It is not really necessary to have the same for the sour=
ce=20
files. Maybe your solution is good or maybe not. Only the future will t=
ell. :)

The other solution would be more like backports [1]. They seem to use o=
ne=20
backport-/compat-*.c file for each kernel they support and introduced f=
eatures=20
which they require. So all kernel < 3.19 will build the content of=20
backport-3.19.c to get the functions introduced by this version. But th=
ere are=20
also some larger ones for special stuff. Maybe you can check this out a=
nd=20
decide what you like more.

To the copyright stuff... hm, if you didn't write it yourself then the=20=

copyright stuff from the original source should be there. backports [1]=
=20
doesn't seem to do this very well. They have for example used larger po=
rtions=20
from files marked as copyright Yu Zhao <yu.zhao@intel.com> but have onl=
y the=20
copyright header with Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-=
not-
panic.com>. Not sure that I can give a good answer here. Maybe someone =
else=20
has an opinion about this part

To the Makefile integration: I did it with compat.c similar before drop=
ping=20
it. The only difference was that I only had one file

    export batman-adv-y +=3D ../../compat.o

So you solution seems to be fine.

Kind regards,
=09Sven


[1] https://www.kernel.org/pub/linux/kernel/projects/backports/stable/

