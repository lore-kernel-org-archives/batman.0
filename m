Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 10 Feb 2010 16:08:27 +0100
Message-Id: <1265814507-29885-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1265814507-29885-1-git-send-email-linus.luessing@web.de>
References: <20100210131150.GE2900@lunn.ch>
	<1265814507-29885-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: remove "foo" from bat_printk
	strings
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

Some missed debug output, removing it.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 bat_printk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bat_printk.c b/bat_printk.c
index 845391d..55c351a 100644
--- a/bat_printk.c
+++ b/bat_printk.c
@@ -857,5 +857,5 @@ asmlinkage int bat_printk(const char *fmt, ...)
 	r = bat_vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
-	return printk("foo:%s", buf);
+	return printk("%s", buf);
 }
-- 
1.6.6.1

