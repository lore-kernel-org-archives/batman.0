Return-Path: <alex.suykov@gmail.com>
Date: Mon, 6 Apr 2015 17:28:48 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <4eb0df3fb11b2bc02ffb913cc4014dee9747beb6.1428329893.git.alex.suykov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1428329893.git.alex.suykov@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/2] batctl: update packet.h to match
	batman-adv
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

Changes from
https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012961.html
ported to batctl.

Signed-off-by: Alex Suykov <alex.suykov at gmail.com>
---
 packet.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/packet.h b/packet.h
index b81fbbf..7a9cb7a 100644
--- a/packet.h
+++ b/packet.h
@@ -18,6 +18,9 @@
 #ifndef _NET_BATMAN_ADV_PACKET_H_
 #define _NET_BATMAN_ADV_PACKET_H_
 
+#include <asm/byteorder.h>
+#include <linux/types.h>
+
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
  * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
-- 
2.0.3

