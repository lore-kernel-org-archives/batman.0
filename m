Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Aug 2016 15:38:00 +0200
Message-ID: <2410594.BZ40g7jear@bentobox>
In-Reply-To: <20160802121513.22526-1-baolex.ni@intel.com>
References: <20160802121513.22526-1-baolex.ni@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3017057.9hDxvFLKKV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1086/1285] Replace numeric parameter like
	0444 with macro
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
Cc: aarcange@redhat.com, k.kozlowski@samsung.com, mhocko@suse.com, mareklindner@neomailbox.ch, a@unstable.cc, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, Baole Ni <baolex.ni@intel.com>, kyungmin.park@samsung.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, aryabinin@virtuozzo.com, gang.chen.5i5j@gmail.com, m.szyprowski@samsung.com, davem@davemloft.net, koct9i@gmail.com, m.chehab@samsung.com

--nextPart3017057.9hDxvFLKKV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 2. August 2016 20:15:13 CEST Baole Ni wrote:
[...]
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 5f2974b..25759b9 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -1313,7 +1313,7 @@ static struct kparam_string batadv_param_string_ra = {
>  };
>  
>  module_param_cb(routing_algo, &batadv_param_ops_ra, &batadv_param_string_ra,
> -		0644);
> +		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  module_init(batadv_init);
>  module_exit(batadv_exit);

Doesn't seem to apply on current net-next:

    $ git am -3 16577.patch
    Applying: Replace numeric parameter like 0444 with macro
    Using index info to reconstruct a base tree...
    M       net/batman-adv/main.c
    Falling back to patching base and 3-way merge...
    Auto-merging net/batman-adv/main.c
    CONFLICT (content): Merge conflict in net/batman-adv/main.c
    error: Failed to merge in the changes.
    Patch failed at 0001 Replace numeric parameter like 0444 with macro
    The copy of the patch that failed is found in: .git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".

The code for it can now be found at net/batman-adv/bat_algo.c

Also the prefix "batman-adv: " is missing in the subject and you should
include <linux/stat.h> in net/batman-adv/bat_algo.c to make sure that these
macros are actually defined before you use them.

So you would end up with something more like:

--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -22,6 +22,7 @@
 #include <linux/moduleparam.h>
 #include <linux/printk.h>
 #include <linux/seq_file.h>
+#include <linux/stat.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 
@@ -137,4 +138,4 @@ static struct kparam_string batadv_param_string_ra = {
 };
 
 module_param_cb(routing_algo, &batadv_param_ops_ra, &batadv_param_string_ra,
-		0644);
+		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

Kind regards,
	Sven
--nextPart3017057.9hDxvFLKKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXoKI4AAoJEF2HCgfBJntGpJAQAJ81kA4Lzqsn/xWGR0D4+17/
pVqP/EOkedAfVjBjV7QShJd8e/CJKoApxiQsKwtKiezWYSFrDE8bEV0mdNS5XVuQ
Jj0IP++MXGmLJkpQIuAK08CLNp5+Ev8Z+UswEFfcP8/yPc6fcQ9bl9FGJaSTza6W
938jrVT001iuN1/F9+gFXbb5ZmeSs03AVrbHKOYUYTBBZEZua8hSyiGImkzGBIuy
yHislKXRayPyd5Xogkx+5WRwKJgHBJsWm0u2MBQVubVPJ8iX/vupCSpudKLUSbVM
HFGrCZTffRvBwXNozuTURyVMi7f+5SHPYYIrHeiIuW0Rzv2evf1aJpJ7xLHuDv/A
hP9AKM1UtGabkELhvqcCAjFcUp3WP/J9kFQ3GvlZfTt5pz0FwnGBMkwE62ZOeR6F
vYgl3Vn1x5nb4PmaaeJpQaHJn/KFj43ijaexZikYUO7BUdpDhbR3BZ4MQ5fM7Tm2
4LYvla+QYCSFiAE3M8YhJSHWLbJVdqZ6ZEAmTt8QIGwotNQWBihNiIHvdm63vKcj
RqTCP71ZzPckn81oq6dKCMQi5HqMmqvqzonvNYZbJy1bTiKSczVtwRhE89dyXxWk
31D1d8n0h/CW8zh2/0B0RYKWtnadoQXHIWO5rzzkahHxQ3I+TGmBj8jv8djzH9i1
NYizHKWGycjLXLzhoHEU
=4CGD
-----END PGP SIGNATURE-----

--nextPart3017057.9hDxvFLKKV--

