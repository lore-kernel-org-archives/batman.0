Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:47 +0200
Message-Id: <20181021225524.8155-2-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 01/38] batctl: Drop unused define
 SOCKET_PATH_FMT
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

The commit 4bd751eed4dc ("batctl: Implement non-routing batadv_icmp in
userspace") removed the last code section which referenced SOCKET_PATH_FMT.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/main.h b/main.h
index 5cd2f46..e8c6db7 100644
--- a/main.h
+++ b/main.h
@@ -29,8 +29,6 @@
 #define SOURCE_VERSION "2018.4"
 #endif
 
-#define SOCKET_PATH_FMT "%s/batman_adv/%s/socket"
-
 #define EXIT_NOSUCCESS 2
 
 #define OPT_LONG_MAX_LEN 25
-- 
2.19.1

