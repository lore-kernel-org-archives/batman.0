Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 11 May 2016 15:11:53 +0200
Message-ID: <2682043.NtWpdVDLGQ@bentobox>
In-Reply-To: <1462962557-23950-2-git-send-email-a@unstable.cc>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
 <1462962557-23950-2-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7582774.vffiLBlF25";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: B.A.T.M.A.N. V -
	implement hard-iface init function
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart7582774.vffiLBlF25
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 11 May 2016 18:29:17 Antonio Quartulli wrote:
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index a8cda76..a757229 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -15,6 +15,7 @@
>   * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include "bat_algo.h"
>  #include "hard-interface.h"
>  #include "main.h"

Can you please use the same order as described in

 https://git.open-mesh.org/batman-adv.git/commit/7df6200927271862dea5b66e24b2b08fa6ea7739

 #include "hard-interface.h"
 #include "main.h"
 
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/if.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "originator.h"
 #include "packet.h"
 #include "send.h"
 #include "soft-interface.h"
 #include "sysfs.h"
 #include "translation-table.h"

Thanks,
	Sven
--nextPart7582774.vffiLBlF25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMy+ZAAoJEF2HCgfBJntGu1MP/2j43sZe1RgYPNKD7omFGzIG
zbWJm2NVyDI0niz5fIc/v0Gkq41FWr9YyYf/iUxvB9L9efEK2gnkTDF6QPqQUD0E
EofllYaBgFmJ3OkzIo98IJZny5cDfa/2ceA0AZMTKuKd2zZFJFmFQtgJkYhGRD9h
0+SnG/iMS6G8UEykkcFQqDefVubD0hNI/u6IhgHRjk7h5zfMO+EjHOSg7aglS+cG
zdUGVR+34rQxHBUChCMU2Il53K/5ddMs+xBcGyF9rnCUC/lycqrLo+msY9zRHp05
7lzt8M4jOEuxtVILjcGzp8YQYb0yHAdjwa58h6zrnwnXveRfgZA/FhV+oUvSaKh6
ViXoMpv24gXc4LuwETPca/suLbtFDjWxCvVWFSWTO1PctgSDPh9pi7S8yRl2o0pM
NUfkqdhz5vvuzJB3JOrSnSu+uNz9GUEYzZsNiKn3XxALgaUhbbFZoBAV56cewa2y
Urwoi7LUzNfvAcQS3uAP7OVSgnwdhlaMZX6gRckK1+2VdOkYMvEMkHcqCSNJjEnm
YZRcUQ/pBAJDFsG/7JBNBJpYYTRTlDOvF+McklIYmf9Cs0LFuaYZzq/NHlrfUX3d
dOftwnugtdtIPGN1dKqaEqXRLYWQdCQqGgZgcqKhCSMMsc152gpqYo0sOWQVv9Pm
z5aj2cAX1Rc4elLVwKuZ
=wF5R
-----END PGP SIGNATURE-----

--nextPart7582774.vffiLBlF25--

