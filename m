Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:12 +0200
Message-Id: <1273261651-21378-8-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 07/26] Staging: batman-adv: Remove dead max
	addr and obsolete VIS_FORMAT strings
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Linus Lüssing <linus.luessing@web.de>

Max address is not being used anywhere and just misleading, therefore
removing it. VIS_FORMAT string is now obsolete, so also remove it.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/main.h |    2 --
 drivers/staging/batman-adv/vis.h  |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 5fdf5af..2494f5a 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -34,8 +34,6 @@
 #define TQ_MAX_VALUE 255
 #define JITTER 20
 #define TTL 50			  /* Time To Live of broadcast messages */
-#define MAX_ADDR 16		  /* number of interfaces which can be added to
-				   * batman. */
 
 #define PURGE_TIMEOUT 200000	  /* purge originators after time in ms if no
 				   * valid packet comes in -> TODO: check
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index 98d8972..4e417fb 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -20,8 +20,6 @@
  */
 
 #define VIS_TIMEOUT		200000
-#define VIS_FORMAT_DD_NAME	"dot_draw"
-#define VIS_FORMAT_JSON_NAME	"json"
 
 struct vis_info {
 	unsigned long       first_seen;
-- 
1.7.1

