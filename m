Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 Dec 2013 13:44:19 +0800
Message-ID: <7685347.MVhl80WSVP@diderot>
In-Reply-To: <1386013113-25471-2-git-send-email-sw@simonwunderlich.de>
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
 <1386013113-25471-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2986625.lLLRIrSDl1";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 2/4] batman-adv: fix header
	alignment by unrolling batadv_header
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


--nextPart2986625.lLLRIrSDl1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 02 December 2013 20:38:31 Simon Wunderlich wrote:
> The size of the batadv_header of 3 is problematic on some architectures
> which automatically pad all structures to a 32 bit boundary. To not lose
> performance by packing this struct, better embed it into the various
> host structures.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  bat_iv_ogm.c            |   36 +++++++++++------------
>  distributed-arp-table.c |    6 ++--
>  fragmentation.c         |    8 ++---
>  icmp_socket.c           |    6 ++--
>  main.c                  |   12 ++++----
>  network-coding.c        |   22 +++++++-------
>  packet.h                |   74
> +++++++++++++++++++++++++++++++++--------------
> routing.c               |   18 ++++++------
>  send.c                  |   10 +++----
>  soft-interface.c        |   11 +++----
>  10 files changed, 118 insertions(+), 85 deletions(-)

Applied in revision 31f0d40.

Thanks,
Marek

--nextPart2986625.lLLRIrSDl1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqU0zAAoJEFNVTo/uthzArPoH/2Rwe9fc6P2w9HthF+F1ovAG
/m2WBT0HhTJSPHfTIRJtu91Jw1sWmXSAynqPEZkVgcaUHh6zg3PnuHEQsxqbqbKz
7uDnd9Obvn7Gma4TPazA3eXhgrOPNHv7utoa5hvrnkiReebpN0IL3IBAxo2FCXA2
xoB/LeJMFUbAAnbyL4gZ6ME4MjZ8KcYQjvIWS3bPhgnB6MhBMFTLeo2QNWTH8J2g
+FKGvFknWYO4JAqo6+y83/A4N33iT+RPhOMZeDUUouHYyGDzzluwGR+st9qI9AJy
0oEkkQxFMHWyxXv4Dd06gakW9nrr0C01YpdHFTVQ+0zYD2YdiyWREJQAvHFmLzo=
=vSlw
-----END PGP SIGNATURE-----

--nextPart2986625.lLLRIrSDl1--

