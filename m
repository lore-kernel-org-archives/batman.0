Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  1 Sep 2016 18:01:34 +0200
Message-Id: <20160901160134.15593-2-sven@narfation.org>
In-Reply-To: <20160901160134.15593-1-sven@narfation.org>
References: <20160901160134.15593-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Fix unknown macro .Pp in manpage
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

The macro .PP was accidentally modified into .Pp when the throughput meter
support was introduced. Revert this part of the change to stop complaints
by man.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 17549c0..d5a5ce0 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -40,7 +40,7 @@ behaviour or using the B.A.T.M.A.N. advanced protocol. For similar reasons, \fBt
 performances, is also included.
 
 .PP
-.Pp
+.PP
 .SH OPTIONS
 .TP
 .I \fBoptions:
-- 
2.9.3

