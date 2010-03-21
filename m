Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 21 Mar 2010 20:02:15 +0100
Message-Id: <1269198135-5077-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove dead max addr #define
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

It's not being used anywhere and just misleading, therefore removing it.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/main.h b/main.h
index 307a6e6..17d26be 100644
--- a/main.h
+++ b/main.h
@@ -34,8 +34,6 @@
 #define TQ_MAX_VALUE 255
 #define JITTER 20
 #define TTL 50			  /* Time To Live of broadcast messages */
-#define MAX_ADDR 16		  /* number of interfaces which can be added to
-				   * batman. */
 
 #define PURGE_TIMEOUT 200000	  /* purge originators after time in ms if no
 				   * valid packet comes in -> TODO: check
-- 
1.7.0

