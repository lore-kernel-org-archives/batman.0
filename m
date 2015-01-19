Return-Path: <janphilipp@litza.de>
From: Jan-Philipp Litza <janphilipp@litza.de>
Date: Mon, 19 Jan 2015 21:59:32 +0100
Message-Id: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Tighten size check on received packet
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

When first checking if a received packet is truncated, the size of the
alfred_tlv structure is ignored, thus allowing packets that are
truncated by 4 bytes or less to pass the check unnoticed.

Even the check itself might access memory after the packet if its size
was only 2 bytes or less.

Signed-off-by: Jan-Philipp Litza <janphilipp@litza.de>
---
 recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recv.c b/recv.c
index 90db0b3..870485f 100644
--- a/recv.c
+++ b/recv.c
@@ -402,7 +402,8 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface)
 		return -1;
 
 	/* drop truncated packets */
-	if (length < ((int)ntohs(packet->length)))
+	if (length < (int)sizeof(*packet) ||
+	    length < (int)(ntohs(packet->length) + sizeof(*packet)))
 		return -1;
 
 	/* drop incompatible packet */
-- 
2.1.0

