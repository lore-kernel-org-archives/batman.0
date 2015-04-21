Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 12:45:08 +0200
Message-Id: <1429613108-19928-3-git-send-email-sven@narfation.org>
In-Reply-To: <1429613108-19928-1-git-send-email-sven@narfation.org>
References: <1429613108-19928-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: Add link to kernel README
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

The batman-adv out-of-tree module provided a README in the root folder. But
the kernel stores the same readme as
Documentation/networking/batman-adv.txt. Just link to the kernel README to
avoid having the same readme twice.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3: No change
v2: Moved from main patch to extra patch

 README | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 README

diff --git a/README b/README
new file mode 120000
index 0000000..209342f
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+Documentation/networking/batman-adv.txt
\ No newline at end of file
-- 
2.1.4

