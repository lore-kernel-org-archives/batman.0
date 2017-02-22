Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Feb 2017 17:16:01 +0100
Message-ID: <82659786.7iirk8N2EY@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5318833.N59XkUhVpo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v2 0/4] batman-adv: cleanups patches for
	Linux 4.12
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

--nextPart5318833.N59XkUhVpo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

here is the second version of cleanup patches. It addresses a couple of new
checks from checkpatch.pl:

 * CHECK: Macro argument reuse '%s' - possible side-effects?
 * CHECK: Unbalanced braces around else statement

The last check currently creates a lot of false positives but a fix for it was
already submitted to Andrew Morton (+ accepted).
 
It also contains a patch which converts the preprocessor blocks in
multicast.c to simple inline checks. The compiler can directly take care of
removing the unused code when some CONFIG_* option disabled.


changes in v2:

 * rebased on top of master
 * split "Fix possible side-effects in macros" in two patches
 * converted BATADV_PRINT_VID to an inline function

Kind regards,
	Sven

Sven Eckelmann (4):
  batman-adv: Remove preprocessor checks in multicast.c
  batman-adv: Fix unbalanced braces around else statement
  batman-adv: Fix possible side-effects in _batadv_dbg
  batman-adv: Convert BATADV_PRINT_VID macro to function

 net/batman-adv/bridge_loop_avoidance.c | 38 +++++++++++++++---------------
 net/batman-adv/distributed-arp-table.c |  6 ++---
 net/batman-adv/log.h                   |  5 ++--
 net/batman-adv/main.h                  | 16 +++++++++++--
 net/batman-adv/multicast.c             | 16 +++++--------
 net/batman-adv/translation-table.c     | 42 ++++++++++++++++++----------------
 6 files changed, 67 insertions(+), 56 deletions(-)
--nextPart5318833.N59XkUhVpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlituUEACgkQXYcKB8Em
e0bCohAAlYYtaH4JfgNmtnnezfNxjOZQsJ6KgHcyMVzFLslWwjYk88ZGIOKUcyoS
lrvbWW9TlvAfMg2Tk+0MXfBQEf4qgkg/1xxIOgRhn+sxYc6rvsNg4Rmxfic2k838
n/wmZSS08GqJlwYl5b/lHdRVwUMNmysJxVt9Ap0BNzfzGHMDY/v0pxuQbi9abFwV
9q06AHNvVnVSeaJH43q1VmoWzyL4eiILfrZpWNZxXSW0h6Mh3vYsvqwFfYJOPgqY
SuEg/L8trL6v7JZ1Q6XoPfM/SkIObLfa1Rbr69WOXcnL33IyVNfDNyZN2KtaXShj
9pEJX64xmqFXSXBBkd38+loIrJ6x1Ub1AX8B1rFkHkYk5mf2DllvFoNwANGL7apG
btPd7Pp+k05cplrnzP+y7SujmKyjVgy/nYKihAxE9bixa65FdpBQuwel7imlyO8y
64GAk0/IDIRK2QZlrugmsnXxyYVllEd8BVPjOyzQg3H+05B6JwLMK/ot77tOMD8M
fbwLFvteZbFe4Dc+8mo4INvUkoD96AlxYs+kNlIKdItyy34C/m3pSzWIt0tNgqP4
hXvxcMzvJ2e9bjmfnzCsEWEpnN46aE7jVBcSFgWtTMZHr99qfo8YB1F3+i3QCW/F
yatr6qd8nIiKcIJzPhvcgrsceAG47qZ5QNY31JtOti8Hxx+ViWc=
=V1GW
-----END PGP SIGNATURE-----

--nextPart5318833.N59XkUhVpo--

