Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 17:15:15 +0800
Message-ID: <2499232.sg4ZHAj8xg@voltaire>
In-Reply-To: <1463348911-27014-1-git-send-email-sven@narfation.org>
References: <1463303266-25979-5-git-send-email-sven@narfation.org>
 <1463348911-27014-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2478243.7DzfGv25Lk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Consolidate logging related
	functions
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

--nextPart2478243.7DzfGv25Lk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 15, 2016 23:48:31 Sven Eckelmann wrote:
> There are several places in batman-adv which provide logging related
> functions. These should be grouped together in the log.* files to make them
> easier to find.
> 
> Reported-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  - remove linux/kernel.h
> v3:
>  - introduce this patch
> ---
>  net/batman-adv/Makefile                |   1 +
>  net/batman-adv/bat_iv_ogm.c            |   1 +
>  net/batman-adv/bat_v_elp.c             |   1 +
>  net/batman-adv/bat_v_ogm.c             |   1 +
>  net/batman-adv/bitarray.c              |   2 +
>  net/batman-adv/bridge_loop_avoidance.c |   1 +
>  net/batman-adv/debugfs.c               | 216
> +------------------------------ net/batman-adv/distributed-arp-table.c
> |   1 +
>  net/batman-adv/gateway_client.c        |   1 +
>  net/batman-adv/gateway_common.c        |   1 +
>  net/batman-adv/hard-interface.c        |   1 +
>  net/batman-adv/icmp_socket.c           |   1 +
>  net/batman-adv/log.c                   | 230
> +++++++++++++++++++++++++++++++++ net/batman-adv/log.h                   |
> 109 ++++++++++++++++
>  net/batman-adv/main.c                  |   2 +
>  net/batman-adv/main.h                  |  69 +---------
>  net/batman-adv/multicast.c             |   1 +
>  net/batman-adv/network-coding.c        |   1 +
>  net/batman-adv/originator.c            |   1 +
>  net/batman-adv/routing.c               |   1 +
>  net/batman-adv/send.c                  |   1 +
>  net/batman-adv/sysfs.c                 |   1 +
>  net/batman-adv/translation-table.c     |   1 +
>  23 files changed, 363 insertions(+), 282 deletions(-)
>  create mode 100644 net/batman-adv/log.c
>  create mode 100644 net/batman-adv/log.h

Applied in revision 421d988.

Thanks,
Marek

--nextPart2478243.7DzfGv25Lk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtWjAAoJEFNVTo/uthzAL00H/jm92uI2m9toQaWBPApRD253
RQOiCT/4pxY5kr7PFxVAkDFgax8caNRJP/HGi+swXYDm6aCWXupsuVK3/Exn67CN
vqUiOyEggO3WhaaPGu2aH2Bs1SpDuuooV9wI/8Emrfh7qiNU6/gD37vOdOtooEmh
Acmeqz1nbkdHtPESI5lMtzd8H3gUgXT6dLPXD55UbFpDV1LbIQ5IJdZwIGFCyukD
w75QCHy5KeaH3pZab5hSXC8e1A+YF8FQHHyyD8R2XGI6NJuEZEO50ok5JKBu98Fh
POQiWt++PbN3dpXDQaBTQqmpPFA5XCSMQJ6CsILi/EIaPWVaza+Qn5hH0bq0Qxo=
=CDG/
-----END PGP SIGNATURE-----

--nextPart2478243.7DzfGv25Lk--

