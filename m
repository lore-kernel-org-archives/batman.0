Return-Path: <ordex@autistici.org>
From: Antonio Quartull <ordex@autistici.org>
Date: Tue, 26 Jul 2011 00:39:08 +0200
Message-Id: <1311633548-302-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: detect clients connected through a
	802.11 device
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>

Clients connected through a 802.11 device are now marked with the
TT_CLIENT_WIFI flag. This flag is also advertised with the tt
announcement.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/packet.h b/packet.h
index b76b4be..8802eab 100644
--- a/packet.h
+++ b/packet.h
@@ -84,6 +84,7 @@ enum tt_query_flags {
 enum tt_client_flags {
 	TT_CLIENT_DEL     = 1 << 0,
 	TT_CLIENT_ROAM    = 1 << 1,
+	TT_CLIENT_WIFI    = 1 << 2,
 	TT_CLIENT_NOPURGE = 1 << 8,
 	TT_CLIENT_NEW     = 1 << 9,
 	TT_CLIENT_PENDING = 1 << 10
-- 
1.7.3.4

