Return-Path: <gregkh@linuxfoundation.org>
Subject: Patch "batman-adv: Fix multicast TT issues with bogus ROAM flags" has
 been added to the 4.4-stable tree
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Nov 2021 13:42:43 +0100
In-Reply-To: <20211120123939.260723-3-sven@narfation.org>
Message-ID: <163767136325592@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, gregkh@linuxfoundation.org, linus.luessing@c0d3.blue, me@irrelefant.net, sven@narfation.org, sw@simonwunderlich.de
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    batman-adv: Fix multicast TT issues with bogus ROAM flags

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git=
;a=3Dsummary

The filename of the patch is:
     batman-adv-fix-multicast-tt-issues-with-bogus-roam-flags.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Nov 23 01:39:02 PM CET 2021
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 20 Nov 2021 13:39:30 +0100
Subject: batman-adv: Fix multicast TT issues with bogus ROAM flags
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, "Linus L=FCssing" <linus.luessing@c0d3=
.blue>, "Leonardo M=F6rlein" <me@irrelefant.net>, "Simon Wunderlich" <sw@si=
monwunderlich.de>, "Sven Eckelmann" <sven@narfation.org>
Message-ID: <20211120123939.260723-3-sven@narfation.org>

From: Linus L=FCssing <linus.luessing@c0d3.blue>

commit a44ebeff6bbd6ef50db41b4195fca87b21aefd20 upstream.

When a (broken) node wrongly sends multicast TT entries with a ROAM
flag then this causes any receiving node to drop all entries for the
same multicast MAC address announced by other nodes, leading to
packet loss.

Fix this DoS vector by only storing TT sync flags. For multicast TT
non-sync'ing flag bits like ROAM are unused so far anyway.

Fixes: 1d8ab8d3c176 ("batman-adv: Modified forwarding behaviour for multica=
st packets")
Reported-by: Leonardo M=F6rlein <me@irrelefant.net>
Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[ bp: 4.4 backported: adjust context, use old style to access flags ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/translation-table.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1426,7 +1426,8 @@ static bool batadv_tt_global_add(struct
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid =3D vid;
=20
-		common->flags =3D flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags =3D flags & (~BATADV_TT_SYNC_MASK);
=20
 		tt_global_entry->roam_at =3D 0;
 		/* node must store current time in case of roaming. This is
@@ -1489,7 +1490,8 @@ static bool batadv_tt_global_add(struct
 		 * TT_CLIENT_WIFI, therefore they have to be copied in the
 		 * client entry
 		 */
-		tt_global_entry->common.flags |=3D flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			tt_global_entry->common.flags |=3D flags & (~BATADV_TT_SYNC_MASK);
=20
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a


Patches currently in stable-queue which might be from sven@narfation.org are

queue-4.4/batman-adv-consider-fragmentation-for-needed_headroom.patch
queue-4.4/ath9k-fix-potential-interrupt-storm-on-queue-reset.patch
queue-4.4/batman-adv-set-.owner-to-this_module.patch
queue-4.4/batman-adv-mcast-fix-duplicate-mcast-packets-from-bla-backbone-to=
-mesh.patch
queue-4.4/batman-adv-fix-multicast-tt-issues-with-bogus-roam-flags.patch
queue-4.4/batman-adv-mcast-fix-duplicate-mcast-packets-in-bla-backbone-from=
-lan.patch
queue-4.4/batman-adv-reserve-needed_-room-for-fragments.patch
queue-4.4/net-batman-adv-fix-error-handling.patch
queue-4.4/batman-adv-keep-fragments-equally-sized.patch
queue-4.4/batman-adv-avoid-warn_on-timing-related-checks.patch
queue-4.4/batman-adv-prevent-duplicated-softif_vlan-entry.patch
queue-4.4/batman-adv-don-t-always-reallocate-the-fragmentation-skb-head.pat=
ch
queue-4.4/batman-adv-mcast-fix-duplicate-mcast-packets-in-bla-backbone-from=
-mesh.patch
