Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 08:19:46 +0200
Message-ID: <2174113.skRZnUNyof@sven-edge>
In-Reply-To: <20160428204610.GA11920@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <20160428204610.GA11920@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2293280.PWE3ElQh1j";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/10] netns and netlink support
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

--nextPart2293280.PWE3ElQh1j
Content-Type: multipart/mixed; boundary="nextPart3409601.3W4c3jLxyU"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart3409601.3W4c3jLxyU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:46:10 Andrew Lunn wrote:
> On Thu, Apr 28, 2016 at 10:37:18PM +0200, Andrew Lunn wrote:
> > This patchset completes netns support, by disabling debugfs entries
> > when not in the default name space, and correctly handling interface
> > stack loops when the parent is in a different name space.
> > 
> > It additionally adds netlink support for most of the information found
> > in debugfs, and is netns awaire.
> > 
> > Note: BLA is untested, so best assume it is broken...
> 
> I forgot to add, no attempt has been made to compile this on older
> kernels. So it probably does not...

It doesn't compile in some configurations. There are also some other problems. 
See the attached mail.

Kind regards,
	Sven
=2D-nextPart3409601.3W4c3jLxyU
Content-Disposition: attachment; filename="2016-04-29_netlink.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="2016-04-29_netlink.mbox"

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-04-29
From: postmaster@open-mesh.org
To: sven@sven-edge.home.narfation.org
Message-Id: <20160429061127.C34CA3418B7A@sven-edge.home.narfation.org>
Date: Fri, 29 Apr 2016 08:11:27 +0200 (CEST)

Name of failed tests
====================

 * headers master
 * kerneldoc master ./net/batman-adv/types.h
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y

Output of different failed tests
================================

headers master
=2D-------------

    diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
    index 2d66621..ffb4b72 100644
    --- a/net/batman-adv/bat_iv_ogm.c
    +++ b/net/batman-adv/bat_iv_ogm.c
    @@ -16,7 +16,10 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
     #include <linux/bitmap.h>
    @@ -48,7 +51,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bitarray.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
    index d8d4920..de14754 100644
    --- a/net/batman-adv/bat_v.c
    +++ b/net/batman-adv/bat_v.c
    @@ -16,9 +16,14 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
    +#include <linux/if_ether.h>
     #include <linux/bug.h>
     #include <linux/cache.h>
     #include <linux/init.h>
    @@ -30,7 +35,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_v_elp.h"
     #include "bat_v_ogm.h"
     #include "hard-interface.h"
    @@ -39,6 +43,8 @@
     #include "originator.h"
     #include "packet.h"
     
    +struct sk_buff;
    +
     static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
     {
     	/* B.A.T.M.A.N. V does not use any queuing mechanism, therefore it can
    diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
    index 4509511..db0c96c 100644
    --- a/net/batman-adv/bridge_loop_avoidance.c
    +++ b/net/batman-adv/bridge_loop_avoidance.c
    @@ -16,7 +16,10 @@
      */
     
     #include "bridge_loop_avoidance.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
     #include <linux/byteorder/generic.h>
    @@ -47,7 +50,6 @@
     #include <net/arp.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "hard-interface.h"
     #include "hash.h"
     #include "netlink.h"
    diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
    index 3c05f3b..0014585 100644
    --- a/net/batman-adv/bridge_loop_avoidance.h
    +++ b/net/batman-adv/bridge_loop_avoidance.h
    @@ -20,6 +20,8 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +
     #include <linux/types.h>
     
     struct net_device;
    diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
    index 7a31e07..9727f0b 100644
    --- a/net/batman-adv/debugfs.c
    +++ b/net/batman-adv/debugfs.c
    @@ -19,6 +19,7 @@
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/compiler.h>
    +#include <net/net_namespace.h>
     #include <linux/debugfs.h>
     #include <linux/device.h>
     #include <linux/errno.h>
    @@ -43,7 +44,6 @@
     #include <linux/uaccess.h>
     #include <linux/wait.h>
     #include <stdarg.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "distributed-arp-table.h"
     #include "gateway_client.h"
    diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
    index 3083f0a..58301b3 100644
    --- a/net/batman-adv/gateway_client.c
    +++ b/net/batman-adv/gateway_client.c
    @@ -16,9 +16,14 @@
      */
     
     #include "gateway_client.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
    +#include "net/sock.h"
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
     #include <linux/byteorder/generic.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    @@ -40,7 +45,6 @@
     #include <linux/stddef.h>
     #include <linux/udp.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "gateway_common.h"
     #include "hard-interface.h"
     #include "netlink.h"
    diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
    index cee397d..b1883db 100644
    --- a/net/batman-adv/gateway_client.h
    +++ b/net/batman-adv/gateway_client.h
    @@ -20,6 +20,8 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +
     #include <linux/types.h>
     
     struct batadv_tvlv_gateway_data;
    diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
    index d3e46b3..2360e30 100644
    --- a/net/batman-adv/hard-interface.c
    +++ b/net/batman-adv/hard-interface.c
    @@ -19,6 +19,8 @@
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <net/net_namespace.h>
    +#include <net/rtnetlink.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
     #include <linux/errno.h>
    diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
    index ca135b3..c22aa69 100644
    --- a/net/batman-adv/main.c
    +++ b/net/batman-adv/main.c
    @@ -48,7 +48,6 @@
     #include <net/dsfield.h>
     #include <net/rtnetlink.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_algo.h" // IWYU pragma: keep
     #include "bridge_loop_avoidance.h"
     #include "debugfs.h"
    @@ -57,7 +56,10 @@
     #include "gateway_common.h"
     #include "hard-interface.h"
     #include "icmp_socket.h"
    +#include "linux/netlink.h"
     #include "multicast.h"
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     #include "netlink.h"
     #include "network-coding.h"
     #include "originator.h"
    diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
    index f4e0f8f..797ee02 100644
    --- a/net/batman-adv/main.h
    +++ b/net/batman-adv/main.h
    @@ -191,6 +191,7 @@ enum batadv_uev_type {
     #include "types.h"
     
     struct batadv_ogm_packet;
    +struct netlink_callback;
     struct seq_file;
     struct sk_buff;
     
    diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
    index 5ee4e8e..2321108 100644
    --- a/net/batman-adv/netlink.c
    +++ b/net/batman-adv/netlink.c
    @@ -15,13 +15,24 @@
      * along with this program; if not, see <http://www.gnu.org/licenses/>.
      */
     
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
     #include "netlink.h"
     
    +#include <linux/errno.h>
    +#include <linux/fs.h>
    +#include <linux/if_ether.h>
    +#include <linux/init.h>
     #include <linux/netdevice.h>
    +#include <linux/printk.h>
    +#include <linux/rculist.h>
    +#include <linux/rcupdate.h>
    +#include <linux/skbuff.h>
    +#include <linux/stddef.h>
    +#include <linux/types.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "gateway_client.h"
     #include "hard-interface.h"
    diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
    index 31022d4..2f53795 100644
    --- a/net/batman-adv/netlink.h
    +++ b/net/batman-adv/netlink.h
    @@ -18,7 +18,12 @@
     #ifndef _NET_BATMAN_ADV_NETLINK_H_
     #define _NET_BATMAN_ADV_NETLINK_H_
     
    +#include <linux/compiler.h>
     #include <net/genetlink.h>
    +#include "linux/genetlink.h"
    +#include "net/netlink.h"
    +
    +struct nlmsghdr;
     
     void batadv_netlink_register(void);
     void batadv_netlink_unregister(void);
    diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
    index a9ffa22..0a3ef3a 100644
    --- a/net/batman-adv/originator.c
    +++ b/net/batman-adv/originator.c
    @@ -16,9 +16,11 @@
      */
     
     #include "originator.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    @@ -35,7 +37,6 @@
     #include <linux/workqueue.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "distributed-arp-table.h"
     #include "fragmentation.h"
     #include "gateway_client.h"
    diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
    index cdef186..6e33c6a 100644
    --- a/net/batman-adv/originator.h
    +++ b/net/batman-adv/originator.h
    @@ -31,7 +31,9 @@
     
     #include "hash.h"
     
    +struct netlink_callback;
     struct seq_file;
    +struct sk_buff;
     
     bool batadv_compare_orig(const struct hlist_node *node, const void *data2);
     int batadv_originator_init(struct batadv_priv *bat_priv);
    diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
    index 27b9b3b..db29d6f 100644
    --- a/net/batman-adv/translation-table.c
    +++ b/net/batman-adv/translation-table.c
    @@ -16,9 +16,13 @@
      */
     
     #include "translation-table.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/bitops.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
    @@ -43,10 +47,8 @@
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/workqueue.h>
    -#include <net/net_namespace.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
    index 889a071..e1a12a9 100644
    --- a/net/batman-adv/translation-table.h
    +++ b/net/batman-adv/translation-table.h
    @@ -20,6 +20,9 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +struct sk_buff;
    +
     #include <linux/types.h>
     
     struct net_device;


kerneldoc master ./net/batman-adv/types.h
=2D----------------------------------------

    ./net/batman-adv/types.h:1329: warning: No description found for parameter 'bat_neigh_dump'
    ./net/batman-adv/types.h:1329: warning: No description found for parameter 'bat_orig_dump'


smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
=2D--------------------------------------------------------------------------

    /tmp/net/batman-adv/bridge_loop_avoidance.c:2075 batadv_bla_claim_dump_bucket() warn: curly braces intended?


sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    /tmp/net/batman-adv/debugfs.c:81:9: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:81:9: error: got 2
    /tmp/net/batman-adv/debugfs.c:89:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:89:13: error: got !
    /tmp/net/batman-adv/debugfs.c:89:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:92:22: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:92:22: error: got &
    /tmp/net/batman-adv/debugfs.c:93:9: error: Expected ) in nested declarator
    /tmp/net/batman-adv/debugfs.c:93:9: error: got =
    /tmp/net/batman-adv/debugfs.c:94:41: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:94:41: error: got (
    /tmp/net/batman-adv/debugfs.c:97:16: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:97:16: error: got =
    /tmp/net/batman-adv/debugfs.c:97:9: error: Trying to use reserved word 'for' as identifier
    /tmp/net/batman-adv/debugfs.c:97:36: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:97:36: error: got !=
    /tmp/net/batman-adv/debugfs.c:97:43: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:97:43: error: got ++
    /tmp/net/batman-adv/debugfs.c:100:24: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:100:24: error: got &
    /tmp/net/batman-adv/debugfs.c:102:9: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:102:9: error: got &
    /tmp/net/batman-adv/debugfs.c:104:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:104:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:104:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:105:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:105:1: error: got }
    /tmp/net/batman-adv/debugfs.c:112:9: error: Expected ) in nested declarator
    /tmp/net/batman-adv/debugfs.c:112:9: error: got =
    /tmp/net/batman-adv/debugfs.c:113:39: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:113:39: error: got (
    /tmp/net/batman-adv/debugfs.c:114:35: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:114:35: error: got ->
    /tmp/net/batman-adv/debugfs.c:118:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:118:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:118:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:119:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:119:1: error: got }
    /tmp/net/batman-adv/debugfs.c:127:13: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:127:13: error: got ->
    /tmp/net/batman-adv/debugfs.c:128:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:128:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:128:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:129:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:129:1: error: got }
    /tmp/net/batman-adv/debugfs.c:134:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:134:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:134:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:135:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:135:1: error: got }
    /tmp/net/batman-adv/debugfs.c:140:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:140:1: error: got }
    /tmp/net/batman-adv/debugfs.c:151:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:151:13: error: got (
    /tmp/net/batman-adv/debugfs.c:151:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:154:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:154:13: error: got !
    /tmp/net/batman-adv/debugfs.c:154:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:157:19: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:157:19: error: got ==
    /tmp/net/batman-adv/debugfs.c:157:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:160:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:160:13: error: got !
    /tmp/net/batman-adv/debugfs.c:160:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:160:14: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:160:14: error: got (
    /tmp/net/batman-adv/debugfs.c:160:14: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:160:14: error: got }
    /tmp/net/batman-adv/debugfs.c:166:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:167:17: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:167:17: error: got return
    /tmp/net/batman-adv/debugfs.c:169:22: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:169:22: error: got &
    /tmp/net/batman-adv/debugfs.c:171:16: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:171:16: error: got (
    /tmp/net/batman-adv/debugfs.c:171:9: error: Trying to use reserved word 'while' as identifier
    /tmp/net/batman-adv/debugfs.c:177:26: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:177:26: error: got ->
    /tmp/net/batman-adv/debugfs.c:179:32: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:179:32: error: got &
    /tmp/net/batman-adv/debugfs.c:183:30: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:183:30: error: got &
    /tmp/net/batman-adv/debugfs.c:185:20: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:185:20: error: got ++
    /tmp/net/batman-adv/debugfs.c:186:18: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:186:18: error: got ++
    /tmp/net/batman-adv/debugfs.c:187:9: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:187:9: error: got }
    /tmp/net/batman-adv/debugfs.c:191:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:191:13: error: got !
    /tmp/net/batman-adv/debugfs.c:191:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:194:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:194:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:194:16: error: got error
    /tmp/net/batman-adv/debugfs.c:195:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:195:1: error: got }
    /tmp/net/batman-adv/debugfs.c:202:23: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:202:23: error: got ,
    /tmp/net/batman-adv/debugfs.c:204:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:204:13: error: got !
    /tmp/net/batman-adv/debugfs.c:204:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:207:9: error: too many errors
    /tmp/net/batman-adv/debugfs.c:81:9: error: expected declaration specifiers or '...' before numeric constant
     _printf(2, 3)
             ^
    /tmp/net/batman-adv/debugfs.c:81:12: error: expected declaration specifiers or '...' before numeric constant
     _printf(2, 3)
                ^
    /tmp/net/batman-adv/debugfs.c: In function 'batadv_debug_log':
    /tmp/net/batman-adv/debugfs.c:114:2: error: implicit declaration of function 'batadv_fdebug_log' [-Werror=implicit-function-declaration]
      batadv_fdebug_log(bat_priv->debug_log, "[%10u] %s",
      ^
    /tmp/net/batman-adv/debugfs.c: At top level:
    /tmp/net/batman-adv/debugfs.c:68:13: warning: 'batadv_emit_log_char' defined but not used [-Wunused-function]
     static void batadv_emit_log_char(struct batadv_priv_debug_log *debug_log,
                 ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/debugfs.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
=2D--------------------------------------------------------------------------

    batadv_iv_init
    batadv_v_init
    batadv_v_mesh_free
    batadv_v_mesh_init


unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
=2D--------------------------------------------------------------------------

    batadv_bla_backbone_table_seq_print_text
    batadv_bla_check_bcast_duplist
    batadv_bla_claim_dump
    batadv_bla_claim_table_seq_print_text
    batadv_bla_free
    batadv_bla_init
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_bla_update_orig_address
    batadv_iv_init
    batadv_v_init
    batadv_v_mesh_free
    batadv_v_mesh_init


=2D-nextPart3409601.3W4c3jLxyU--
This is a multi-part message in MIME format.

--nextPart3409601.3W4c3jLxyU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:46:10 Andrew Lunn wrote:
> On Thu, Apr 28, 2016 at 10:37:18PM +0200, Andrew Lunn wrote:
> > This patchset completes netns support, by disabling debugfs entries
> > when not in the default name space, and correctly handling interface
> > stack loops when the parent is in a different name space.
> > 
> > It additionally adds netlink support for most of the information found
> > in debugfs, and is netns awaire.
> > 
> > Note: BLA is untested, so best assume it is broken...
> 
> I forgot to add, no attempt has been made to compile this on older
> kernels. So it probably does not...

It doesn't compile in some configurations. There are also some other problems. 
See the attached mail.

Kind regards,
	Sven
--nextPart3409601.3W4c3jLxyU
Content-Disposition: attachment; filename="2016-04-29_netlink.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="2016-04-29_netlink.mbox"

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-04-29
From: postmaster@open-mesh.org
To: sven@sven-edge.home.narfation.org
Message-Id: <20160429061127.C34CA3418B7A@sven-edge.home.narfation.org>
Date: Fri, 29 Apr 2016 08:11:27 +0200 (CEST)

Name of failed tests
====================

 * headers master
 * kerneldoc master ./net/batman-adv/types.h
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y

Output of different failed tests
================================

headers master
--------------

    diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
    index 2d66621..ffb4b72 100644
    --- a/net/batman-adv/bat_iv_ogm.c
    +++ b/net/batman-adv/bat_iv_ogm.c
    @@ -16,7 +16,10 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
     #include <linux/bitmap.h>
    @@ -48,7 +51,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bitarray.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
    index d8d4920..de14754 100644
    --- a/net/batman-adv/bat_v.c
    +++ b/net/batman-adv/bat_v.c
    @@ -16,9 +16,14 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
    +#include <linux/if_ether.h>
     #include <linux/bug.h>
     #include <linux/cache.h>
     #include <linux/init.h>
    @@ -30,7 +35,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_v_elp.h"
     #include "bat_v_ogm.h"
     #include "hard-interface.h"
    @@ -39,6 +43,8 @@
     #include "originator.h"
     #include "packet.h"
     
    +struct sk_buff;
    +
     static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
     {
     	/* B.A.T.M.A.N. V does not use any queuing mechanism, therefore it can
    diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
    index 4509511..db0c96c 100644
    --- a/net/batman-adv/bridge_loop_avoidance.c
    +++ b/net/batman-adv/bridge_loop_avoidance.c
    @@ -16,7 +16,10 @@
      */
     
     #include "bridge_loop_avoidance.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
     #include <linux/byteorder/generic.h>
    @@ -47,7 +50,6 @@
     #include <net/arp.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "hard-interface.h"
     #include "hash.h"
     #include "netlink.h"
    diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
    index 3c05f3b..0014585 100644
    --- a/net/batman-adv/bridge_loop_avoidance.h
    +++ b/net/batman-adv/bridge_loop_avoidance.h
    @@ -20,6 +20,8 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +
     #include <linux/types.h>
     
     struct net_device;
    diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
    index 7a31e07..9727f0b 100644
    --- a/net/batman-adv/debugfs.c
    +++ b/net/batman-adv/debugfs.c
    @@ -19,6 +19,7 @@
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/compiler.h>
    +#include <net/net_namespace.h>
     #include <linux/debugfs.h>
     #include <linux/device.h>
     #include <linux/errno.h>
    @@ -43,7 +44,6 @@
     #include <linux/uaccess.h>
     #include <linux/wait.h>
     #include <stdarg.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "distributed-arp-table.h"
     #include "gateway_client.h"
    diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
    index 3083f0a..58301b3 100644
    --- a/net/batman-adv/gateway_client.c
    +++ b/net/batman-adv/gateway_client.c
    @@ -16,9 +16,14 @@
      */
     
     #include "gateway_client.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
    +#include "net/sock.h"
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
     #include <linux/byteorder/generic.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    @@ -40,7 +45,6 @@
     #include <linux/stddef.h>
     #include <linux/udp.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "gateway_common.h"
     #include "hard-interface.h"
     #include "netlink.h"
    diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
    index cee397d..b1883db 100644
    --- a/net/batman-adv/gateway_client.h
    +++ b/net/batman-adv/gateway_client.h
    @@ -20,6 +20,8 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +
     #include <linux/types.h>
     
     struct batadv_tvlv_gateway_data;
    diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
    index d3e46b3..2360e30 100644
    --- a/net/batman-adv/hard-interface.c
    +++ b/net/batman-adv/hard-interface.c
    @@ -19,6 +19,8 @@
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <net/net_namespace.h>
    +#include <net/rtnetlink.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
     #include <linux/errno.h>
    diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
    index ca135b3..c22aa69 100644
    --- a/net/batman-adv/main.c
    +++ b/net/batman-adv/main.c
    @@ -48,7 +48,6 @@
     #include <net/dsfield.h>
     #include <net/rtnetlink.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_algo.h" // IWYU pragma: keep
     #include "bridge_loop_avoidance.h"
     #include "debugfs.h"
    @@ -57,7 +56,10 @@
     #include "gateway_common.h"
     #include "hard-interface.h"
     #include "icmp_socket.h"
    +#include "linux/netlink.h"
     #include "multicast.h"
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     #include "netlink.h"
     #include "network-coding.h"
     #include "originator.h"
    diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
    index f4e0f8f..797ee02 100644
    --- a/net/batman-adv/main.h
    +++ b/net/batman-adv/main.h
    @@ -191,6 +191,7 @@ enum batadv_uev_type {
     #include "types.h"
     
     struct batadv_ogm_packet;
    +struct netlink_callback;
     struct seq_file;
     struct sk_buff;
     
    diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
    index 5ee4e8e..2321108 100644
    --- a/net/batman-adv/netlink.c
    +++ b/net/batman-adv/netlink.c
    @@ -15,13 +15,24 @@
      * along with this program; if not, see <http://www.gnu.org/licenses/>.
      */
     
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
     #include "netlink.h"
     
    +#include <linux/errno.h>
    +#include <linux/fs.h>
    +#include <linux/if_ether.h>
    +#include <linux/init.h>
     #include <linux/netdevice.h>
    +#include <linux/printk.h>
    +#include <linux/rculist.h>
    +#include <linux/rcupdate.h>
    +#include <linux/skbuff.h>
    +#include <linux/stddef.h>
    +#include <linux/types.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "gateway_client.h"
     #include "hard-interface.h"
    diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
    index 31022d4..2f53795 100644
    --- a/net/batman-adv/netlink.h
    +++ b/net/batman-adv/netlink.h
    @@ -18,7 +18,12 @@
     #ifndef _NET_BATMAN_ADV_NETLINK_H_
     #define _NET_BATMAN_ADV_NETLINK_H_
     
    +#include <linux/compiler.h>
     #include <net/genetlink.h>
    +#include "linux/genetlink.h"
    +#include "net/netlink.h"
    +
    +struct nlmsghdr;
     
     void batadv_netlink_register(void);
     void batadv_netlink_unregister(void);
    diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
    index a9ffa22..0a3ef3a 100644
    --- a/net/batman-adv/originator.c
    +++ b/net/batman-adv/originator.c
    @@ -16,9 +16,11 @@
      */
     
     #include "originator.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    @@ -35,7 +37,6 @@
     #include <linux/workqueue.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "distributed-arp-table.h"
     #include "fragmentation.h"
     #include "gateway_client.h"
    diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
    index cdef186..6e33c6a 100644
    --- a/net/batman-adv/originator.h
    +++ b/net/batman-adv/originator.h
    @@ -31,7 +31,9 @@
     
     #include "hash.h"
     
    +struct netlink_callback;
     struct seq_file;
    +struct sk_buff;
     
     bool batadv_compare_orig(const struct hlist_node *node, const void *data2);
     int batadv_originator_init(struct batadv_priv *bat_priv);
    diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
    index 27b9b3b..db29d6f 100644
    --- a/net/batman-adv/translation-table.c
    +++ b/net/batman-adv/translation-table.c
    @@ -16,9 +16,13 @@
      */
     
     #include "translation-table.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/bitops.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
    @@ -43,10 +47,8 @@
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/workqueue.h>
    -#include <net/net_namespace.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
    index 889a071..e1a12a9 100644
    --- a/net/batman-adv/translation-table.h
    +++ b/net/batman-adv/translation-table.h
    @@ -20,6 +20,9 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +struct sk_buff;
    +
     #include <linux/types.h>
     
     struct net_device;


kerneldoc master ./net/batman-adv/types.h
-----------------------------------------

    ./net/batman-adv/types.h:1329: warning: No description found for parameter 'bat_neigh_dump'
    ./net/batman-adv/types.h:1329: warning: No description found for parameter 'bat_orig_dump'


smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
---------------------------------------------------------------------------

    /tmp/net/batman-adv/bridge_loop_avoidance.c:2075 batadv_bla_claim_dump_bucket() warn: curly braces intended?


sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    /tmp/net/batman-adv/debugfs.c:81:9: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:81:9: error: got 2
    /tmp/net/batman-adv/debugfs.c:89:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:89:13: error: got !
    /tmp/net/batman-adv/debugfs.c:89:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:92:22: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:92:22: error: got &
    /tmp/net/batman-adv/debugfs.c:93:9: error: Expected ) in nested declarator
    /tmp/net/batman-adv/debugfs.c:93:9: error: got =
    /tmp/net/batman-adv/debugfs.c:94:41: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:94:41: error: got (
    /tmp/net/batman-adv/debugfs.c:97:16: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:97:16: error: got =
    /tmp/net/batman-adv/debugfs.c:97:9: error: Trying to use reserved word 'for' as identifier
    /tmp/net/batman-adv/debugfs.c:97:36: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:97:36: error: got !=
    /tmp/net/batman-adv/debugfs.c:97:43: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:97:43: error: got ++
    /tmp/net/batman-adv/debugfs.c:100:24: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:100:24: error: got &
    /tmp/net/batman-adv/debugfs.c:102:9: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:102:9: error: got &
    /tmp/net/batman-adv/debugfs.c:104:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:104:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:104:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:105:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:105:1: error: got }
    /tmp/net/batman-adv/debugfs.c:112:9: error: Expected ) in nested declarator
    /tmp/net/batman-adv/debugfs.c:112:9: error: got =
    /tmp/net/batman-adv/debugfs.c:113:39: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:113:39: error: got (
    /tmp/net/batman-adv/debugfs.c:114:35: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:114:35: error: got ->
    /tmp/net/batman-adv/debugfs.c:118:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:118:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:118:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:119:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:119:1: error: got }
    /tmp/net/batman-adv/debugfs.c:127:13: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:127:13: error: got ->
    /tmp/net/batman-adv/debugfs.c:128:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:128:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:128:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:129:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:129:1: error: got }
    /tmp/net/batman-adv/debugfs.c:134:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:134:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:134:16: error: got 0
    /tmp/net/batman-adv/debugfs.c:135:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:135:1: error: got }
    /tmp/net/batman-adv/debugfs.c:140:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:140:1: error: got }
    /tmp/net/batman-adv/debugfs.c:151:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:151:13: error: got (
    /tmp/net/batman-adv/debugfs.c:151:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:154:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:154:13: error: got !
    /tmp/net/batman-adv/debugfs.c:154:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:157:19: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:157:19: error: got ==
    /tmp/net/batman-adv/debugfs.c:157:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:160:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:160:13: error: got !
    /tmp/net/batman-adv/debugfs.c:160:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:160:14: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:160:14: error: got (
    /tmp/net/batman-adv/debugfs.c:160:14: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:160:14: error: got }
    /tmp/net/batman-adv/debugfs.c:166:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:167:17: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:167:17: error: got return
    /tmp/net/batman-adv/debugfs.c:169:22: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:169:22: error: got &
    /tmp/net/batman-adv/debugfs.c:171:16: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:171:16: error: got (
    /tmp/net/batman-adv/debugfs.c:171:9: error: Trying to use reserved word 'while' as identifier
    /tmp/net/batman-adv/debugfs.c:177:26: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:177:26: error: got ->
    /tmp/net/batman-adv/debugfs.c:179:32: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:179:32: error: got &
    /tmp/net/batman-adv/debugfs.c:183:30: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:183:30: error: got &
    /tmp/net/batman-adv/debugfs.c:185:20: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:185:20: error: got ++
    /tmp/net/batman-adv/debugfs.c:186:18: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:186:18: error: got ++
    /tmp/net/batman-adv/debugfs.c:187:9: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:187:9: error: got }
    /tmp/net/batman-adv/debugfs.c:191:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:191:13: error: got !
    /tmp/net/batman-adv/debugfs.c:191:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:194:9: error: Trying to use reserved word 'return' as identifier
    /tmp/net/batman-adv/debugfs.c:194:16: error: Expected ; at end of declaration
    /tmp/net/batman-adv/debugfs.c:194:16: error: got error
    /tmp/net/batman-adv/debugfs.c:195:1: error: Expected ; at the end of type declaration
    /tmp/net/batman-adv/debugfs.c:195:1: error: got }
    /tmp/net/batman-adv/debugfs.c:202:23: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:202:23: error: got ,
    /tmp/net/batman-adv/debugfs.c:204:13: error: Expected ) in function declarator
    /tmp/net/batman-adv/debugfs.c:204:13: error: got !
    /tmp/net/batman-adv/debugfs.c:204:9: error: Trying to use reserved word 'if' as identifier
    /tmp/net/batman-adv/debugfs.c:207:9: error: too many errors
    /tmp/net/batman-adv/debugfs.c:81:9: error: expected declaration specifiers or '...' before numeric constant
     _printf(2, 3)
             ^
    /tmp/net/batman-adv/debugfs.c:81:12: error: expected declaration specifiers or '...' before numeric constant
     _printf(2, 3)
                ^
    /tmp/net/batman-adv/debugfs.c: In function 'batadv_debug_log':
    /tmp/net/batman-adv/debugfs.c:114:2: error: implicit declaration of function 'batadv_fdebug_log' [-Werror=implicit-function-declaration]
      batadv_fdebug_log(bat_priv->debug_log, "[%10u] %s",
      ^
    /tmp/net/batman-adv/debugfs.c: At top level:
    /tmp/net/batman-adv/debugfs.c:68:13: warning: 'batadv_emit_log_char' defined but not used [-Wunused-function]
     static void batadv_emit_log_char(struct batadv_priv_debug_log *debug_log,
                 ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/debugfs.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=n BATMAN_V=y
---------------------------------------------------------------------------

    batadv_iv_init
    batadv_v_init
    batadv_v_mesh_free
    batadv_v_mesh_init


unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=y
---------------------------------------------------------------------------

    batadv_bla_backbone_table_seq_print_text
    batadv_bla_check_bcast_duplist
    batadv_bla_claim_dump
    batadv_bla_claim_table_seq_print_text
    batadv_bla_free
    batadv_bla_init
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_bla_update_orig_address
    batadv_iv_init
    batadv_v_init
    batadv_v_mesh_free
    batadv_v_mesh_init


--nextPart3409601.3W4c3jLxyU--

--nextPart2293280.PWE3ElQh1j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXIv0CAAoJEF2HCgfBJntGrhwP/1IDQEIQIDsgq+GoVH6fLHEe
FgjKyGONPslSGaZATjTyrDxbaLYVuV21YZ+MMDwPzMvm7F/1jn/NDk7iSBEq7I0J
JHbXW8EyTp978NXi89PjANqAkNfn3se5aSBJpJsvfRkhJk6ZaBLE7/LbvDbOoV9b
Az4KTfZBZUmA5LG0mPuC0wLXQxXE89EmLiOnGASDpiQOmHAj9qSR5gnoxk8dR/cj
s2HtvemPjVYJ47iYuPyF8HaoCpEbUGMWYVad1/76Yxbnx+14HwIy8APTOjFP+aGL
ul+9eAzaIvJPcapNBg9GaH6xBfquqXfqL8suZZtWcNH5RiRxvfWexkhcxvSggDTf
r/beJ+dP2n5KgZx+GxGLDDabJn5DvszfYG8vY8mjl7EKaentvNK9WDw6/fermHOY
4lcTmrn2Vjn8I51frtVG13vCwLklMenJT23oEKYs6z0Y+Vqi4G5J5vdxfoR0lU5m
KGq9XPs1XoQoCXRDamrEwHsYHgrBQ+6X6GuAZAZiBlBP7bC0DPbFOxCK7FptD1Ec
y9Gf7uVwp3/j2IqQSMVp+B2khUOOq4fb1MzefGpbZYByRDFnlN8htf0+PEIkr+nt
8qflZUU1NShicCT0/ZlL1ku7ArGV807jIUQqwwTYqPBwsj8KqkIH4t/zh2Zp/ji2
B7+GemPS6v3psOq2gLbZ
=UZ16
-----END PGP SIGNATURE-----

--nextPart2293280.PWE3ElQh1j--

