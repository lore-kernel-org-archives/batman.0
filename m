Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Nov 2013 15:46:59 +0800
Message-ID: <2348902.d5Ij6xag6y@diderot>
In-Reply-To: <1383507648-1973-1-git-send-email-antonio@meshcoding.com>
References: <1383507648-1973-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7776999.Biv53dY4MC";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove FSF address from GPL
	disclaimer
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart7776999.Biv53dY4MC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 03 November 2013 20:40:48 Antonio Quartulli wrote:
> As suggested by checkpatch, remove all the references to the
> FSF address since the kernel already has one reference in
> its documentation.
> 
> In this way it is easier to update it in case of future
> changes.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  Makefile                | 5 -----
>  Makefile.kbuild         | 5 -----
>  bat_algo.h              | 5 -----
>  bat_iv_ogm.c            | 5 -----
>  bitarray.c              | 5 -----
>  bitarray.h              | 5 -----
>  bridge_loop_avoidance.c | 5 -----
>  bridge_loop_avoidance.h | 5 -----
>  compat.c                | 5 -----
>  compat.h                | 5 -----
>  debugfs.c               | 5 -----
>  debugfs.h               | 5 -----
>  distributed-arp-table.c | 5 -----
>  distributed-arp-table.h | 5 -----
>  fragmentation.c         | 5 -----
>  fragmentation.h         | 5 -----
>  gateway_client.c        | 5 -----
>  gateway_client.h        | 5 -----
>  gateway_common.c        | 5 -----
>  gateway_common.h        | 5 -----
>  hard-interface.c        | 5 -----
>  hard-interface.h        | 5 -----
>  hash.c                  | 5 -----
>  hash.h                  | 5 -----
>  icmp_socket.c           | 5 -----
>  icmp_socket.h           | 5 -----
>  main.c                  | 5 -----
>  main.h                  | 5 -----
>  network-coding.c        | 5 -----
>  network-coding.h        | 5 -----
>  originator.c            | 5 -----
>  originator.h            | 5 -----
>  packet.h                | 5 -----
>  routing.c               | 5 -----
>  routing.h               | 5 -----
>  send.c                  | 5 -----
>  send.h                  | 5 -----
>  soft-interface.c        | 5 -----
>  soft-interface.h        | 5 -----
>  sysfs.c                 | 5 -----
>  sysfs.h                 | 5 -----
>  translation-table.c     | 5 -----
>  translation-table.h     | 5 -----
>  types.h                 | 5 -----
>  44 files changed, 220 deletions(-)

Applied in revision c2a8e16.

Thanks,
Marek

--nextPart7776999.Biv53dY4MC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSeKJ9AAoJEFNVTo/uthzAnFYH/R3MSY+iL+sYzThAu/U8FBxg
xkLXz7arJOvcv09Jt5LVAGCdfFI3o/H+xEyZvYyuy4ygvhTcwL40mEilI1Ied8pw
Ans/pAXetzZ1cLsn87bo98rml7M3XaWWW9md/GMxPb/28lJ/XGJON6ETsorAPqGv
VSKZfBwTI8oQLCvAibx+F1KoINanyQZKZkUJXkl8srrxq4VB9Jo7tMcIcD4I7GXM
Iidb7EGrVN4jI3r4JFzbRWdY2A0wY+z2OWozg/aFlr6r0Ihkt2J1h7xQqnnbYiFa
r7xIA/giIvFxMJ4gGYwTJrx7jDkkuzurXq1ML8xZNw9Ig7j9z8KI9s972/2nQ10=
=P4rN
-----END PGP SIGNATURE-----

--nextPart7776999.Biv53dY4MC--

