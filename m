Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  3 Jan 2013 23:32:04 +0800
Message-Id: <1357227125-14190-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1357227125-14190-1-git-send-email-lindner_marek@yahoo.de>
References: <1357227125-14190-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: man page - align selection class
	examples
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 man/batctl.8 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 7e4f391..a1bfbc0 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -132,11 +132,11 @@ consider the gateway's advertised throughput as well as the link quality towards
 .RE
 .RE
 .RS 25
- 2  \-> stable connection
+  2 \-> stable connection
 .RS 7
 chooses the gateway with the best link quality and stick with it (ignore the advertised throughput)
 .RE
- 3  \-> fast switch connection
+  3 \-> fast switch connection
 .RS 7
 chooses the gateway with the best link quality but switches to another gateway as soon as a better one is found
 .RE
-- 
1.7.10.4

