Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/6] batctl: Consume genl ACKs after setting reads
Date: Mon, 10 May 2021 21:49:40 +0200
Message-Id: <20210510194945.103735-2-sven@narfation.org>
In-Reply-To: <20210510194945.103735-1-sven@narfation.org>
References: <20210510194945.103735-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The kernel is sending an ACK after an successful read request via the
batadv genl socket. This ack must be consumed manually after the actual
message was processed. Otherwise, the next user of the socket can get
confused by the unexpected ACK in the socket queue.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sys.c b/sys.c
index 6dd8c10..f1dc275 100644
--- a/sys.c
+++ b/sys.c
@@ -107,7 +107,13 @@ int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
 	nl_send_auto_complete(state->sock, msg);
 	nlmsg_free(msg);
 
-	nl_recvmsgs(state->sock, state->cb);
+	if (callback) {
+		ret = nl_recvmsgs(state->sock, state->cb);
+		if (ret < 0)
+			return ret;
+	}
+
+	nl_wait_for_ack(state->sock);
 
 	return result;
 }
-- 
2.30.2

