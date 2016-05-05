Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 May 2016 22:17:18 +0200
Message-ID: <2675515.pbCZCtK98O@sven-edge>
In-Reply-To: <1462474003-25279-1-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4433634.IzqCG18mzy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
	attribute for sysfs helper function
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
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

--nextPart4433634.IzqCG18mzy
Content-Type: multipart/mixed; boundary="nextPart14925138.mhnyUsvyfy"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart14925138.mhnyUsvyfy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 02:46:37 Antonio Quartulli wrote:
> the compiler can optimize functions within the same C file and therefore
> there is no need to make it explicit.
> 
> Remove the useless inline attribute for __batadv_store_uint_attr()
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

This is not about this particular patch but for the patch series.

Please check the attached test results of the daily build tests.

Kind regards,
	Sve
=2D-nextPart14925138.mhnyUsvyfy
Content-Disposition: attachment; filename="gw_per_algo_test.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="gw_per_algo_test.mbox"

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-05-05
From: postmaster@open-mesh.org
Date: Thu,  5 May 2016 21:59:37 +0200 (CEST)

Name of failed tests
====================

 * headers master
 * kerneldoc master ./net/batman-adv/types.h
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n

Output of different failed tests
================================

headers master
=2D-------------

    diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
    index 02359d0..cb09ae5 100644
    --- a/net/batman-adv/bat_v.c
    +++ b/net/batman-adv/bat_v.c
    @@ -19,6 +19,10 @@
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
    +#include <linux/kernel.h>
    +#include <linux/kref.h>
    +#include <linux/stddef.h>
     #include <linux/bug.h>
     #include <linux/cache.h>
     #include <linux/init.h>


kerneldoc master ./net/batman-adv/types.h
=2D----------------------------------------

    ./net/batman-adv/types.h:1338: warning: No description found for parameter 'gw'


unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D--------------------------------------------------------------------------

    batadv_gw_node_get


=2D-nextPart14925138.mhnyUsvyfy--
This is a multi-part message in MIME format.

--nextPart14925138.mhnyUsvyfy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 02:46:37 Antonio Quartulli wrote:
> the compiler can optimize functions within the same C file and therefore
> there is no need to make it explicit.
> 
> Remove the useless inline attribute for __batadv_store_uint_attr()
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

This is not about this particular patch but for the patch series.

Please check the attached test results of the daily build tests.

Kind regards,
	Sve
--nextPart14925138.mhnyUsvyfy
Content-Disposition: attachment; filename="gw_per_algo_test.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="gw_per_algo_test.mbox"

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-05-05
From: postmaster@open-mesh.org
Date: Thu,  5 May 2016 21:59:37 +0200 (CEST)

Name of failed tests
====================

 * headers master
 * kerneldoc master ./net/batman-adv/types.h
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=n NC=n MCAST=n BATMAN_V=n

Output of different failed tests
================================

headers master
--------------

    diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
    index 02359d0..cb09ae5 100644
    --- a/net/batman-adv/bat_v.c
    +++ b/net/batman-adv/bat_v.c
    @@ -19,6 +19,10 @@
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
    +#include <linux/kernel.h>
    +#include <linux/kref.h>
    +#include <linux/stddef.h>
     #include <linux/bug.h>
     #include <linux/cache.h>
     #include <linux/init.h>


kerneldoc master ./net/batman-adv/types.h
-----------------------------------------

    ./net/batman-adv/types.h:1338: warning: No description found for parameter 'gw'


unused_symbols master linux-4.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
---------------------------------------------------------------------------

    batadv_gw_node_get


--nextPart14925138.mhnyUsvyfy--

--nextPart4433634.IzqCG18mzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXK6pOAAoJEF2HCgfBJntG3FYP/RvxaORER3ebnhQ4hiS6MCa7
95S2UQsCfuYPAWE5ZUBcdhCTFWDjXNUN74/zhYGQpklscYfvpFoOVrj8LXzRyOJn
8uNwxLKUNB9V7bFL+nu1aP+yhRXaiOnCjwBJexsh05DwymjGrPaZmLgDWCxiOJAQ
5ReoXNQozcHRKG6AhKIIWeckUKpG98wyFqLzw9O6ZsnZN5qK6f64D0vne3aoREu6
AJZYG7BFxC2AYZKD0IX+mzk9hvAvJnMTOqaeyI0xQsDQRHxS4Xffnodx/odMYIgz
3ArGNqr5X9RKjegon9udJ1Xy4IPs/wLZCEirB2eBvzU+brKxWqkDoqQAW59rcoN6
vmN/T002OYziXfCQ1LczxM2aUyE3akgIBRswCOubVCXhlMwr583b/NSkdWicTVk5
iFkeo1cTF4xSgmvgXMKIWVZSufieiWAHgG20RX6woaoMvNbOaYWTo2rqBiHQsQqs
Dmwbf1TWeJGv5ngP1wAGyFzRzMqzz5CvRYIRnMS4xth0ScxhpX37qq1oI5eAVlgA
HloCLfhneM1hNKFH8r0aCBRiNCOtIWRqpvKnS6SSxBKRyGSvsxd5CUTXXKxFmwzl
K5Rpvjkzue1at96s+uX9HfYWJCQgyQ7WRV8a7nA5fC6mcgoCU6i2DMv2kKnml4TK
WtHBSnRCjpKhb5ns4e6X
=ql43
-----END PGP SIGNATURE-----

--nextPart4433634.IzqCG18mzy--

