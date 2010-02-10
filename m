Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 10 Feb 2010 16:08:26 +0100
Message-Id: <1265814507-29885-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <20100210131150.GE2900@lunn.ch>
References: <20100210131150.GE2900@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: use original printk in
	bat_printk
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

bat_printk is calling a printk which got previously
substituted because of the define in compat.h.
This patch removes the define for the scope of
bat_printk.c.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 bat_printk.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/bat_printk.c b/bat_printk.c
index a55eff3..845391d 100644
--- a/bat_printk.c
+++ b/bat_printk.c
@@ -35,6 +35,12 @@
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
 
+/* We don't want to recursively call bat_printk here
+   because of the previous define in compat.h */
+#ifdef printk
+#undef printk
+#endif
+
 static int skip_atoi(const char **s)
 {
 	int i = 0;
-- 
1.6.6.1

