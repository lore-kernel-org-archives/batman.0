Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 14:16:42 +0200
Message-Id: <1400933804-9661-4-git-send-email-sven@narfation.org>
In-Reply-To: <1400933804-9661-1-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batctl: Return success only with valid
	line_ptr in read_file
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
Cc: Sven Eckelmann <sven@narfation.org>

The read_file function is rather complex and cluttered with different
functionality. One of it is to provide a line_ptr of a single line to the
caller. The caller trusts the return code for a SUCCESS of this function
and tries to access the line_ptr. But a failed getline may lead to an
NULL-line_ptr. The caller tries to dereference this NULL pointer and
causes an segfault.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index 84f0d14..251e616 100644
--- a/functions.c
+++ b/functions.c
@@ -320,7 +320,8 @@ written:
 		goto open;
 	}
 
-	res = EXIT_SUCCESS;
+	if (line_ptr)
+		res = EXIT_SUCCESS;
 
 out:
 	if (fp)
-- 
2.0.0.rc2

