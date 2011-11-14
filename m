Return-Path: <bug-track@fisher-privat.net>
From: Alexey Fisher <bug-track@fisher-privat.net>
Date: Mon, 14 Nov 2011 10:11:32 +0100
Message-Id: <1321261892-6401-1-git-send-email-bug-track@fisher-privat.net>
Subject: [B.A.T.M.A.N.] [PATCH] add make install
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
To: lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5762721..44bad88 100644
--- a/Makefile
+++ b/Makefile
@@ -42,3 +42,6 @@ all:
 
 clean:
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
+
+install:
+	@cp batman-adv.ko $(shell dirname $(KERNELPATH))/kernel/net/batman-adv/batman-adv.ko
-- 
1.7.5.4

