Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 13:35:59 +0200
Message-Id: <1433072160-3260-5-git-send-email-sven@narfation.org>
In-Reply-To: <1433072160-3260-1-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] alfred: First check only push_data
	header length
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

The length in the TLV header for push_data is without the TLV header
itself. So the length check should instead only check for this size because
the other size checks will be done later.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unix_sock.c b/unix_sock.c
index 29c934e..570c62c 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -109,5 +109,5 @@ static int unix_sock_add_data(struct globals *globals,
 	len = ntohs(push->header.length);
 
-	if (len < (int)(sizeof(*push) + sizeof(push->header)))
+	if (len < (int)(sizeof(*push) - sizeof(push->header)))
 		goto err;
 
-- 
2.1.4

