Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Aug 2012 14:20:57 +0200
Message-ID: <3089530.tcqQjiXxMe@sven-desktop.home.narfation.org>
In-Reply-To: <1344514526-30256-2-git-send-email-montik@autistici.org>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
 <1344514526-30256-2-git-send-email-montik@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart149424525.fPBe0qJqdx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC 1/3] batman-adv: bandwidth meter
	implementation
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


--nextPart149424525.fPBe0qJqdx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 09 August 2012 14:15:24 Edo Monticelli wrote:
> The bandwith meter module is a simple, kernel-space replacement for bandwith
> measurements tool like iperf and netper. It is intended to approximate TCP
> behaviour.
> 
> It is invoked through ``batctl bw": the protocol is connection oriented,
> with cumulative acknowledgment and sliding window. Sender keeps a timeout,
> which is checked by a worker function regoularly invoked through the
> workqueue mechanism. If the timeout is expired at the time worker is
> executed, the whole window is re-transmitted.
> 
> Struct bw_vars, one for each connection, are collected into a linked list.
> Thus access to them is protected with a spinlock.
> 
> Another spinlock prevents more than one instance of multiple_send to run
> concurrently. Ack code is mutually exclusive (two ack handler cannot run at
> the same time for differnent acks), but they are not mutually exclusive
> with send_remaining_window, that is to say the ack handler shifts the
> window ``while" send_remaining_window is running. Maybe some atomic
> variable (window_first) is needed to avoid problems.
> 
> When the test is over, the results are returned to batctl through a call to
> the function batadv_socket_receive_packet(), before freeing struct
> batadv_bw_vars.
> 
> The function only accepts struct batadv_icmp_packet_rr, so that structure is
> used and a cast is done to struct batadv_bw_result.
> 
> The test interruptable with CTRL-C. A receiver side timeout avoids
> unlimited waitings for sender packets: after one second of inactivity, the
> receiver abort the ongoing test.
> 
> Signed-off-by: Edo Monticelli <montik@autistici.org>
> ---
>  Makefile         |    2 +-
>  Makefile.kbuild  |    1 +
>  bw_meter.c       |  513
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++ bw_meter.h       |  
>  7 +
>  icmp_socket.c    |   18 ++
>  main.c           |    2 +
>  packet.h         |   22 ++-
>  routing.c        |   15 ++-
>  soft-interface.c |    5 +
>  types.h          |   36 ++++
>  10 files changed, 614 insertions(+), 7 deletions(-)
>  create mode 100644 bw_meter.c
>  create mode 100644 bw_meter.h
> 
> diff --git a/Makefile b/Makefile
> index bd8d30c..12aebe5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -20,7 +20,7 @@
> 
>  # changing the CONFIG_* line to 'y' enables the related feature
>  # B.A.T.M.A.N. debugging:
> -export CONFIG_BATMAN_ADV_DEBUG=n
> +export CONFIG_BATMAN_ADV_DEBUG=y
>  # B.A.T.M.A.N. bridge loop avoidance:
>  export CONFIG_BATMAN_ADV_BLA=y


Sry, disapproved.

Kind regards,
	Sven
--nextPart149424525.fPBe0qJqdx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQJ5+pAAoJEF2HCgfBJntGqwwQALOHj1Ck3Fb1BSXlXE7c2p35
BB3pnQijVTyr+FfytBn5ONiKq1V5AXuW0K90i0VinSzP0aX4VTpIvQPvHk1rirb8
3hxk2NsAMN83wgtTlfobkuw0zZeZ/jxGolwtwpEEH2GfkxAtcfJ0qcUpcmmeb1fu
N+52T2fPqLVln15gct58f5kqKkl5lAzexbChmgD5gY5PWWOpbCf3YhnNkdwR3wn3
Wzjd1TRCI9E4ZdssyvmjRqTdyCF+8UKRkkM/l/mkDvrYOInMNJChAZ6djICUUeq3
zda7Uxod2RadyxDQ//6TMvhFE5teZqsdKsoGCo+DQnOh1q2ItrDoERnFguns+GTx
WVJaCsfdy9O5N1eJng5iaBKMeZn8rsZTyEhlVwMIoMksrl/745yH+/KOxBUkq1Yv
YLnT+ZDR1E00f4M5tx6VQm3B6JcVfDLHiaQETIvqKbiqPusvfXIdq+y+pR5I+Jd6
szQ/LzP+NvBvElx+y7v6hWQS5yD+p5295Y558s+izBdRA/s18VuPMzN5oxZYBjBt
2UneiebNFu3tR/a8NlcYmlsQX76IO+LL7wqxhwa1+bse5yjuSO2Ph0pndz1MnKoQ
S1lApTrrh4LiqbSS1mzInEImBbLI0Lx1j8T7LtNstvUhbMymQKNGtY2ZRGYpCSLS
adJ1XxEIPEhaxeC0is+e
=G4sN
-----END PGP SIGNATURE-----

--nextPart149424525.fPBe0qJqdx--

