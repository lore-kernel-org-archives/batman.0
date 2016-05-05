Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 May 2016 23:15:28 +0200
Message-ID: <1811882.4NqUN7GsV2@sven-edge>
In-Reply-To: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17007494.WX43UZCuNH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 0/4] Multicast optimizations for
	bridges
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

--nextPart17007494.WX43UZCuNH
Content-Type: multipart/mixed; boundary="nextPart1794137.dcoYBjhgZF"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1794137.dcoYBjhgZF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 05 May 2016 17:07:01 Linus L=FCssing wrote:
> This patchset can be found in the current linus/multicast-bridge
> branch.

Please check the attached results of the daily build test scripts.

Kind regards,
=09Sven
=2D-nextPart1794137.dcoYBjhgZF
Content-Disposition: inline; filename="multicast-build-test.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="multicast-build-test.mbox"

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-05-05
From: postmaster@open-mesh.org
Date: Thu,  5 May 2016 23:04:29 +0200 (CEST)

Name of failed tests
====================

 * cppcheck master
 * headers master
 * kerneldoc master ./net/batman-adv/debugfs.c
 * kerneldoc master ./net/batman-adv/multicast.c
 * sparse master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n

Output of different failed tests
================================

cppcheck master
=2D--------------

    [net/batman-adv/multicast.c:441]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:442]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:443]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:450]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1161]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1162]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1163]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1216]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1218]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1220]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1181]: (style) The function 'batadv_mcast_flags_seq_print_text' is never used.


headers master
=2D-------------

    diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
    index 801c6cf..a3de37b 100644
    --- a/compat-sources/net/core/skbuff.c
    +++ b/compat-sources/net/core/skbuff.c
    @@ -32,9 +32,6 @@
      *	2 of the License, or (at your option) any later version.
      */
     
    -#include <linux/ipv6.h>
    -#include <linux/skbuff.h>
    -
     #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
     
     /* Compare with:
    diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
    index 457a05e..ff856f0 100644
    --- a/compat-sources/net/ipv4/igmp.c
    +++ b/compat-sources/net/ipv4/igmp.c
    @@ -71,9 +71,6 @@
      */
     
     #include <linux/igmp.h>
    -#include <linux/ip.h>
    -#include <linux/skbuff.h>
    -#include <net/ip.h>
     
     #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
     
    diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
    index 3f46ed3..df92841 100644
    --- a/compat-sources/net/ipv6/mcast_snoop.c
    +++ b/compat-sources/net/ipv6/mcast_snoop.c
    @@ -17,12 +17,6 @@
      * Based on the MLD support added to br_multicast.c by YOSHIFUJI Hideaki.
      */
     
    -#include <linux/skbuff.h>
    -#include <net/ipv6.h>
    -#include <net/mld.h>
    -#include <net/addrconf.h>
    -#include <net/ip6_checksum.h>
    -
     #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
     
     static int ipv6_mc_check_ip6hdr(struct sk_buff *skb)
    diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
    index d446a50..222941d 100644
    --- a/net/batman-adv/multicast.c
    +++ b/net/batman-adv/multicast.c
    @@ -16,23 +16,23 @@
      */
     
     #include "multicast.h"
    +#include "linux/if_bridge.h"
    +#include "linux/igmp.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/kernel.h>
    +#include <linux/printk.h>
    +#include <linux/seq_file.h>
     #include <linux/bitops.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    -#include <linux/icmpv6.h>
    -#include <linux/if_bridge.h>
     #include <linux/if_ether.h>
    -#include <linux/igmp.h>
    -#include <linux/in6.h>
     #include <linux/in.h>
     #include <linux/ip.h>
    -#include <linux/ipv6.h>
     #include <linux/kref.h>
     #include <linux/list.h>
     #include <linux/lockdep.h>
    @@ -45,11 +45,6 @@
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/types.h>
    -#include <net/addrconf.h>
    -#include <net/ip.h>
    -#include <net/ipv6.h>
    -#include <net/mld.h>
    -
     #include "hard-interface.h"
     #include "hash.h"
     #include "packet.h"
    diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
    index beffa7e..e123b52 100644
    --- a/net/batman-adv/multicast.h
    +++ b/net/batman-adv/multicast.h
    @@ -20,6 +20,7 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct seq_file;
     struct sk_buff;
     
     /**


kerneldoc master ./net/batman-adv/debugfs.c
=2D------------------------------------------

    ./net/batman-adv/debugfs.c:374: warning: No description found for return value of 'batadv_mcast_flags_open'


kerneldoc master ./net/batman-adv/multicast.c
=2D--------------------------------------------

    ./net/batman-adv/multicast.c:436: warning: No description found for parameter 'flags'
    ./net/batman-adv/multicast.c:436: warning: Excess function parameter 'mcast_flags' description in 'batadv_mcast_flags_log'
    ./net/batman-adv/multicast.c:1182: warning: No description found for return value of 'batadv_mcast_flags_seq_print_text'


sparse master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D------------------------------------------------------------------------

    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    got int
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    got int


sparse master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D------------------------------------------------------------------------

    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    got int
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D------------------------------------------------------------------------

    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int
    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int


sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D------------------------------------------------------------------------

    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int
    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D------------------------------------------------------------------------

    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int
    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int


sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D------------------------------------------------------------------------

    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int
    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D-----------------------------------------------------------------------

    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int
    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int


sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D-----------------------------------------------------------------------

    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int
    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D-----------------------------------------------------------------------

    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int
    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int


sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D-----------------------------------------------------------------------

    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int
    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D-----------------------------------------------------------------------

    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D--------------------------------------------------------------------------

    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_status_update
    batadv_debugfs_add_meshif
    batadv_debugfs_del_meshif
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_bandwidth_set
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_gw_tvlv_container_update
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_get_by_netdev
    batadv_hardif_min_mtu
    batadv_is_my_mac
    batadv_mesh_free
    batadv_mesh_init
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_socket_receive_packet
    batadv_tvlv_containers_process
    batadv_tvlv_unicast_send
    batadv_update_min_mtu
    batadv_vlan_ap_isola_get
    init_module


wrong namespace symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D--------------------------------------------------------------------------

    ip_mc_check_igmp
    ipv6_mc_check_mld
    skb_checksum_simple_validate
    skb_checksum_trimmed
    skb_checksum_validate


wrong namespace symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
=2D--------------------------------------------------------------------------

    ip_mc_check_igmp
    ipv6_mc_check_mld
    skb_checksum_trimmed


=2D-nextPart1794137.dcoYBjhgZF--
This is a multi-part message in MIME format.

--nextPart1794137.dcoYBjhgZF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 05 May 2016 17:07:01 Linus L=FCssing wrote:
> This patchset can be found in the current linus/multicast-bridge
> branch.

Please check the attached results of the daily build test scripts.

Kind regards,
=09Sven
--nextPart1794137.dcoYBjhgZF
Content-Disposition: inline; filename="multicast-build-test.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="multicast-build-test.mbox"

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-05-05
From: postmaster@open-mesh.org
Date: Thu,  5 May 2016 23:04:29 +0200 (CEST)

Name of failed tests
====================

 * cppcheck master
 * headers master
 * kerneldoc master ./net/batman-adv/debugfs.c
 * kerneldoc master ./net/batman-adv/multicast.c
 * sparse master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * unused_symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.10 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.11 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.12 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.13 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.14 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.16 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.17 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.18 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.19 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.2 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.3 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.4 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.5 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.6 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.7 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.8 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-3.9 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-4.0 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
 * wrong namespace symbols master linux-4.1 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * wrong namespace symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n

Output of different failed tests
================================

cppcheck master
---------------

    [net/batman-adv/multicast.c:441]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:442]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:443]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:450]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1161]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1162]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1163]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1216]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1218]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1220]: (style) Clarify calculation precedence for '&' and '?'.
    [net/batman-adv/multicast.c:1181]: (style) The function 'batadv_mcast_flags_seq_print_text' is never used.


headers master
--------------

    diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
    index 801c6cf..a3de37b 100644
    --- a/compat-sources/net/core/skbuff.c
    +++ b/compat-sources/net/core/skbuff.c
    @@ -32,9 +32,6 @@
      *	2 of the License, or (at your option) any later version.
      */
     
    -#include <linux/ipv6.h>
    -#include <linux/skbuff.h>
    -
     #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
     
     /* Compare with:
    diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
    index 457a05e..ff856f0 100644
    --- a/compat-sources/net/ipv4/igmp.c
    +++ b/compat-sources/net/ipv4/igmp.c
    @@ -71,9 +71,6 @@
      */
     
     #include <linux/igmp.h>
    -#include <linux/ip.h>
    -#include <linux/skbuff.h>
    -#include <net/ip.h>
     
     #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
     
    diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
    index 3f46ed3..df92841 100644
    --- a/compat-sources/net/ipv6/mcast_snoop.c
    +++ b/compat-sources/net/ipv6/mcast_snoop.c
    @@ -17,12 +17,6 @@
      * Based on the MLD support added to br_multicast.c by YOSHIFUJI Hideaki.
      */
     
    -#include <linux/skbuff.h>
    -#include <net/ipv6.h>
    -#include <net/mld.h>
    -#include <net/addrconf.h>
    -#include <net/ip6_checksum.h>
    -
     #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
     
     static int ipv6_mc_check_ip6hdr(struct sk_buff *skb)
    diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
    index d446a50..222941d 100644
    --- a/net/batman-adv/multicast.c
    +++ b/net/batman-adv/multicast.c
    @@ -16,23 +16,23 @@
      */
     
     #include "multicast.h"
    +#include "linux/if_bridge.h"
    +#include "linux/igmp.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/kernel.h>
    +#include <linux/printk.h>
    +#include <linux/seq_file.h>
     #include <linux/bitops.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    -#include <linux/icmpv6.h>
    -#include <linux/if_bridge.h>
     #include <linux/if_ether.h>
    -#include <linux/igmp.h>
    -#include <linux/in6.h>
     #include <linux/in.h>
     #include <linux/ip.h>
    -#include <linux/ipv6.h>
     #include <linux/kref.h>
     #include <linux/list.h>
     #include <linux/lockdep.h>
    @@ -45,11 +45,6 @@
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/types.h>
    -#include <net/addrconf.h>
    -#include <net/ip.h>
    -#include <net/ipv6.h>
    -#include <net/mld.h>
    -
     #include "hard-interface.h"
     #include "hash.h"
     #include "packet.h"
    diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
    index beffa7e..e123b52 100644
    --- a/net/batman-adv/multicast.h
    +++ b/net/batman-adv/multicast.h
    @@ -20,6 +20,7 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct seq_file;
     struct sk_buff;
     
     /**


kerneldoc master ./net/batman-adv/debugfs.c
-------------------------------------------

    ./net/batman-adv/debugfs.c:374: warning: No description found for return value of 'batadv_mcast_flags_open'


kerneldoc master ./net/batman-adv/multicast.c
---------------------------------------------

    ./net/batman-adv/multicast.c:436: warning: No description found for parameter 'flags'
    ./net/batman-adv/multicast.c:436: warning: Excess function parameter 'mcast_flags' description in 'batadv_mcast_flags_log'
    ./net/batman-adv/multicast.c:1182: warning: No description found for return value of 'batadv_mcast_flags_seq_print_text'


sparse master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
-------------------------------------------------------------------------

    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    got int
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    got int


sparse master linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
-------------------------------------------------------------------------

    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:53:32:    got int
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32: warning: incorrect type in return expression (different base types)
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    expected restricted __sum16
    /tmp/net/batman-adv/../../compat-sources/net/core/skbuff.c:83:32:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
-------------------------------------------------------------------------

    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int
    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int


sparse master linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
-------------------------------------------------------------------------

    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int
    include/linux/skbuff.h:2981:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:2981:24:    expected restricted __sum16
    include/linux/skbuff.h:2981:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
-------------------------------------------------------------------------

    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int
    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int


sparse master linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
-------------------------------------------------------------------------

    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int
    include/linux/skbuff.h:3021:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3021:24:    expected restricted __sum16
    include/linux/skbuff.h:3021:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
------------------------------------------------------------------------

    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int
    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int


sparse master linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
------------------------------------------------------------------------

    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int
    include/linux/skbuff.h:3036:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3036:24:    expected restricted __sum16
    include/linux/skbuff.h:3036:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
------------------------------------------------------------------------

    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int
    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int


sparse master linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
------------------------------------------------------------------------

    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int
    include/linux/skbuff.h:3053:24: warning: incorrect type in return expression (different base types)
    include/linux/skbuff.h:3053:24:    expected restricted __sum16
    include/linux/skbuff.h:3053:24:    got int
    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
------------------------------------------------------------------------

    /tmp/net/batman-adv/multicast.c:165:17: error: undefined identifier 'ip_eth_mc_map'
    /tmp/net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
    /tmp/net/batman-adv/multicast.c:165:3: error: implicit declaration of function 'ip_eth_mc_map' [-Werror=implicit-function-declaration]
       ip_eth_mc_map(src->u.ip4, dst);
       ^
    cc1: some warnings being treated as errors
    make[2]: *** [/tmp/net/batman-adv/multicast.o] Error 1
    make[1]: *** [_module_/tmp/net/batman-adv] Error 2
    make: *** [all] Error 2


unused_symbols master linux-4.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
---------------------------------------------------------------------------

    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_status_update
    batadv_debugfs_add_meshif
    batadv_debugfs_del_meshif
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_bandwidth_set
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_gw_tvlv_container_update
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_get_by_netdev
    batadv_hardif_min_mtu
    batadv_is_my_mac
    batadv_mesh_free
    batadv_mesh_init
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_socket_receive_packet
    batadv_tvlv_containers_process
    batadv_tvlv_unicast_send
    batadv_update_min_mtu
    batadv_vlan_ap_isola_get
    init_module


wrong namespace symbols master linux-3.15 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
---------------------------------------------------------------------------

    ip_mc_check_igmp
    ipv6_mc_check_mld
    skb_checksum_simple_validate
    skb_checksum_trimmed
    skb_checksum_validate


wrong namespace symbols master linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=n MCAST=n BATMAN_V=n
---------------------------------------------------------------------------

    ip_mc_check_igmp
    ipv6_mc_check_mld
    skb_checksum_trimmed


--nextPart1794137.dcoYBjhgZF--

--nextPart17007494.WX43UZCuNH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXK7fwAAoJEF2HCgfBJntGNmYP/i4bofIVL5LMJYSYLdF5p/Yk
L0TeiB03SnUt833QozLu+ZjPFfj0vVx/9nfFP7JxzmygLlWwhBkDiE9/iq7NCpSQ
OPGuN6gXmyPHhsLGfmF+ieesyFR7QdWT3EcnIolQZ4BmoEqMHpH6lIyYltZggov2
sbjO43GjRtNYRx5NMt9XH55BZKeWJY034IXnl9tqRy8ANhT+H5bRLTb64osNmrh2
SKI5mCEV0J/36MBC1onQKuSVLqXTeoOZ5VA75y0oON8A7M0RSAEESUpqUV1Mz0Ua
mxV/qKvmDg9LJyfJ9G6C4FK/t6qbyY4rajlU+ZcjIFbAnQvRW28nLKEdaPUMYD6Z
uTmwY8wscL9oB+KKGeWyceU1Chx2ZeDWGHnMDHsB0BXHvgaK0iNJSd9DY9SsrTme
h3PWgbqeKS6EY8ae6pcTRu7AW+l90XUJwlyRmOaJjiGI456iKAt3feaOzuty8LmT
jfDJqjqidAsinuZtHQ1gAX1yNpvTBCnnEoOv4NW2T31ACBh327yHXuTHFqDzOwNV
JB4WR83GsH/Hyv0udboGMx3Jgv3+sl/cZ8SCEb2DtGNe6617+m9RkqsHEUfogTNQ
LC3aji2TBVsfK5f4Nthxjhe2rxe1rS02G30bQe5XcrM1HD7qg89FaArgvOAgvtoS
hzsNXrshoz3mk4FcIYrH
=hmxO
-----END PGP SIGNATURE-----

--nextPart17007494.WX43UZCuNH--

