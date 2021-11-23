Return-Path: <gregkh@linuxfoundation.org>
Subject: Patch "batman-adv: Consider fragmentation for needed_headroom" has
 been added to the 4.19-stable tree
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Nov 2021 13:35:01 +0100
In-Reply-To: <20211120124044.261086-3-sven@narfation.org>
Message-ID: <163767090116765@kroah.com>
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
To: b.a.t.m.a.n@lists.open-mesh.org, gregkh@linuxfoundation.org, linus.luessing@c0d3.blue, sven@narfation.org, sw@simonwunderlich.de
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    batman-adv: Consider fragmentation for needed_headroom

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git=
;a=3Dsummary

The filename of the patch is:
     batman-adv-consider-fragmentation-for-needed_headroom.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Nov 23 01:33:57 PM CET 2021
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 20 Nov 2021 13:40:42 +0100
Subject: batman-adv: Consider fragmentation for needed_headroom
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, "Sven Eckelmann" <sven@narfation.org>,=
 "Linus L=FCssing" <linus.luessing@c0d3.blue>, "Simon Wunderlich" <sw@simon=
wunderlich.de>
Message-ID: <20211120124044.261086-3-sven@narfation.org>

From: Sven Eckelmann <sven@narfation.org>

commit 4ca23e2c2074465bff55ea14221175fecdf63c5f upstream.

If a batman-adv packets has to be fragmented, then the original batman-adv
packet header is not stripped away. Instead, only a new header is added in
front of the packet after it was split.

This size must be considered to avoid cost intensive reallocations during
the transmission through the various device layers.

Fixes: 7bca68c7844b ("batman-adv: Add lower layer needed_(head|tail)room to=
 own ones")
Reported-by: Linus L=FCssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/hard-interface.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -565,6 +565,9 @@ static void batadv_hardif_recalc_extra_s
 	needed_headroom =3D lower_headroom + (lower_header_len - ETH_HLEN);
 	needed_headroom +=3D batadv_max_header_len();
=20
+	/* fragmentation headers don't strip the unicast/... header */
+	needed_headroom +=3D sizeof(struct batadv_frag_packet);
+
 	soft_iface->needed_headroom =3D needed_headroom;
 	soft_iface->needed_tailroom =3D lower_tailroom;
 }


Patches currently in stable-queue which might be from sven@narfation.org are

queue-4.19/batman-adv-consider-fragmentation-for-needed_headroom.patch
queue-4.19/ath9k-fix-potential-interrupt-storm-on-queue-reset.patch
queue-4.19/ath10k-fix-max-antenna-gain-unit.patch
queue-4.19/batman-adv-mcast-fix-duplicate-mcast-packets-in-bla-backbone-fro=
m-lan.patch
queue-4.19/batman-adv-reserve-needed_-room-for-fragments.patch
queue-4.19/batman-adv-don-t-always-reallocate-the-fragmentation-skb-head.pa=
tch
