Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 Jan 2016 14:26:42 +0100
Message-ID: <2354902.ArQn63Zp4m@sven-edge>
In-Reply-To: <1453312110-32683-5-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-5-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6465071.DzeCJ1Qgr3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: debugfs: Add netns
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart6465071.DzeCJ1Qgr3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 January 2016 18:48:30 Andrew Lunn wrote:
> Unlike sysfs, debugfs is not netns aware. So batman has to take care
> to avoid namespace clashes.
> 
> Each namespace is given a directory within debugfs/batman-adv/netns,
> using the namespaces inum as the directory name.
> 
> Files for namespaces other than the global namespace are placed within
> the namespace specific directory. Additionally, a symbolic link is
> used to link the global namespaces inum back to debugfs/batman-adv/ so
> tools do not need to differentiate between the global namespace and
> other namespaces.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/debugfs.c | 118
> +++++++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 115
> insertions(+), 3 deletions(-)
> 
> diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
> index c4c1e80..b87ffad 100644
> --- a/net/batman-adv/debugfs.c
> +++ b/net/batman-adv/debugfs.c

Missing includes:

#include <linux/kref.h>
#include <linux/list.h>
#include <linux/mutex.h>
#include <linux/ns_common.h>
#include <net/net_namespace.h>

Kind regards,
	Sven
--nextPart6465071.DzeCJ1Qgr3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWrguSAAoJEF2HCgfBJntGiV4QANlamHNooEycd0v8uXjWsZQ8
YQ+ZjNnN3I0PPoOo6U+3L9YEB405HPX0HteUm4qziaqP0MThIo4T63sqBnSJ2jhe
COyFl75282Psqpfj84S3TPr3iEXTM0CYT/bJDPjGj5folQEEd0F3vmsgKsokCfDK
uckb5HYK9kPL11c71WRkUtJprvHnxA43mJlLcR+PTPiIXH3DCmIkcV+k1vgFmME5
FtL2To6GhNVPSkTABaVWeHoTATg3Cxl3TdvS2OlmAR3hTpnF+AcarQpQa74zQxHO
ob4kRIq+dW7WwIGscP+YDz2uElZpzE0YEA7EOOMCTZoX7UGn7UipBIPGAWEIHXUh
8dgohcJ/FOXK/YW4q4g7h9l4dU+NV/kT9ptt70lN5onAFPoZij33n1NtpDhiAO0j
/O2s5nPaNMR8ZVf9w0PXmB+s7wJSfwldgA8zrbC7EwaTznRUqo/LlTvHDdpmEN9u
EJG/4OOb6DpRjBtLBg4Q/s7iRm+Sg5bb7pbWoTQtj+ehSg5QpaHieN393BGx4Wb5
t8N4vU5sv8+ZD+/hLx5Ldj8Z4+MlQx20tdVpagH2BMbGYFYYEMrdFRa8QPjdLiPL
vPfvEFD4g89DPywt8kOfkTJk6QKNMdARJpXTzXDNLtodprdlAb4REdyrSFTmB/rX
BozwUqKv/4ihobV9Zzxj
=VrYB
-----END PGP SIGNATURE-----

--nextPart6465071.DzeCJ1Qgr3--

