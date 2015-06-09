Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 09 Jun 2015 22:37:24 +0800
Message-ID: <1546064.rx4ZQj1ZtZ@voltaire>
In-Reply-To: <1433059821-8521-2-git-send-email-sven@narfation.org>
References: <1433059821-8521-1-git-send-email-sven@narfation.org>
 <1433059821-8521-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4526423.7QNRhB0Wmx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Remove multiple
	assignment per line
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


--nextPart4526423.7QNRhB0Wmx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 31, 2015 10:10:21 Sven Eckelmann wrote:
> The Linux CodingStyle disallows multiple assignments in a single line.
> (see chapter 1)
> 
> Reported-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c            |  6 ++++--
>  net/batman-adv/bridge_loop_avoidance.c |  6 ++++--
>  net/batman-adv/distributed-arp-table.c |  3 ++-
>  net/batman-adv/gateway_client.c        | 15 ++++++++++-----
>  net/batman-adv/gateway_common.c        |  5 ++++-
>  net/batman-adv/network-coding.c        |  3 ++-
>  net/batman-adv/translation-table.c     | 18 +++++++++++++-----
>  7 files changed, 39 insertions(+), 17 deletions(-)

Tried to merge this patch but it greeted me with extensive complaints:

patching file net/batman-adv/bat_iv_ogm.c
Hunk #1 succeeded at 1004 (offset -2 lines).
Hunk #2 succeeded at 1405 (offset -2 lines).
patching file net/batman-adv/bridge_loop_avoidance.c
Hunk #1 succeeded at 88 (offset -1 lines).
Hunk #2 succeeded at 106 (offset -1 lines).
patching file net/batman-adv/distributed-arp-table.c
patching file net/batman-adv/gateway_client.c
Hunk #1 FAILED at 153.
Hunk #3 FAILED at 352.
2 out of 4 hunks FAILED -- saving rejects to file net/batman-adv/gateway_client.c.rej
patching file net/batman-adv/gateway_common.c
Hunk #1 FAILED at 149.
1 out of 1 hunk FAILED -- saving rejects to file net/batman-adv/gateway_common.c.rej
patching file net/batman-adv/network-coding.c
Hunk #1 succeeded at 886 (offset -1 lines).
patching file net/batman-adv/translation-table.c
Hunk #1 FAILED at 461.
Hunk #2 FAILED at 535.
Hunk #3 FAILED at 723.
Hunk #4 FAILED at 796.
Hunk #5 FAILED at 853.
5 out of 5 hunks FAILED -- saving rejects to file net/batman-adv/translation-table.c.rej

Maybe I messed up the patch merge order ? Do you mind
resending a 'clean' version ?

Thanks,
Marek

--nextPart4526423.7QNRhB0Wmx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVdvokAAoJEFNVTo/uthzA+SMH/j050yDYWOdWBkLPt87C9ohm
V/R/DZ7hCXPaPkyZ4dXqUPYSk52qSr//BJJzy0qX09hOdnRqJOEYlWFo3QkRe3Sr
nc+O+7gznBES6G8YtOMVHAFTVE3Ok2/Ycg/R66vY0r9EDVh/fKZ1rk4pvMgg1kCl
RHjqMu8af1XCANS4Aif3BPX/KHg5bAm1/zOa4az7NAh/IB3tuecE+zIa4ii/N9Qg
IDtw6WuSSzGCsy9y1Ejau6CPGlUTo2puSmKDHGozH+i7LFdxquFBFaNekREgwKhZ
Dzs+GyMIvBNsJ1r7dwEJg2J5QSMJQZM65kR7yVxsyN1VVnsTEsDd0kq5ew4aG3I=
=/uca
-----END PGP SIGNATURE-----

--nextPart4526423.7QNRhB0Wmx--

