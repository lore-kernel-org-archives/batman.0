Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Mar 2019 10:13:13 +0100
Message-Id: <20190317091313.18751-3-sven@narfation.org>
In-Reply-To: <20190317091313.18751-1-sven@narfation.org>
References: <20190317091313.18751-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] MAINTAINERS: Add T(ree) field for
 batman-adv
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

The linux-merge.git repository on git.open-mesh.org is used since 8 years
to send PRs for net.git and net-next.git. It is time to officially specify
list it as SCM tree.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4625c4aecfd..9fe913b42b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2794,6 +2794,7 @@ W:	https://www.open-mesh.org/
 B:	https://www.open-mesh.org/projects/batman-adv/issues
 C:	irc://chat.freenode.net/batman
 Q:	https://patchwork.open-mesh.org/project/batman/list/
+T:	git https://git.open-mesh.org/linux-merge.git
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
-- 
2.20.1

