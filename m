Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Feb 2017 10:06:40 +0100
Message-Id: <20170221090640.14686-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: set git diff driver for C source
	code files
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

From: Jean Delvare <jdelvare@suse.de>

Git can be told to apply language-specific rules when generating diffs.
Enable this for C source code files (*.c and *.h) so that function names
are printed right.  Specifically, doing so prevents "git diff" from
mistakenly considering unindented goto labels as function names.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
[sven@narfation.org: Ported patch from linux.git]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 .gitattributes | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index eeef3e0..1d2a7e9 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,2 +1,4 @@
 /.gitignore export-ignore
 /.gitattributes export-ignore
+*.c   diff=cpp
+*.h   diff=cpp
-- 
2.11.0

