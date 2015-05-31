Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 13:36:00 +0200
Message-Id: <1433072160-3260-6-git-send-email-sven@narfation.org>
In-Reply-To: <1433072160-3260-1-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] alfred: Drop small push_data packets
	early
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

The push_data packets which are too small can be dropped earlier in the
transaction process. These cannot be parsed later when finishing the
transaction and thus it is unnecessary to first enqueue them to the
transaction list and allocate extra memory for the management structure.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recv.c b/recv.c
index 16242bc..f459190 100644
--- a/recv.c
+++ b/recv.c
@@ -189,4 +189,6 @@ static int process_alfred_push_data(struct globals *globals,
 
 	len = ntohs(push->header.length);
+	if (len < (int)(sizeof(*push) - sizeof(push->header)))
+		goto err;
 
 	search.server_addr = mac;
-- 
2.1.4

