Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Thu,  3 May 2012 10:15:07 +0200
Message-Id: <1336032907-5215-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
References: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [[PATCHv2]] batman-adv: Change "make install" path
	and run depmod
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Currently, when installing the out-of-tree module on distributions that
use gzipped modules, batman-adv.ko will be installed next to
batman-adv.ko.gz, which is selected by kmod.

By changing the install path to
/lib/modules/`uname -r`/updates/net/batman-adv/
and running "depmod -ae", we make the newly installed module used by
kmod.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---

I removed the -e option from depmod, as it caused a warning on my system.

 Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ac84fba..57530db 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,8 @@ clean:
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
 
 install: config
-	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install
+	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=updates/net/batman-adv/ modules_install
+	depmod -a
 
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
-- 
1.7.10.1

