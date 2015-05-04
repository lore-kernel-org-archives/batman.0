Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon,  4 May 2015 22:47:23 +0200
Message-Id: <1430772443-3545-1-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1430691231-9120-1-git-send-email-linus.luessing@c0d3.blue>
References: <1430691231-9120-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH RFCv4 3/3] compat: disable multicast
 optimizations for old kernels
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

With this patch, the Makefile searches for the symbols needed
for the multicast optimizations in the kernel's .config and
Module.symvers. If they are not there, a warning is issued during "make"
and the multicast.c is excluded from the build process.

The advantage of this is that there's no need for hackish substitutions
in the original code base. Also, this approach is independant of the
actual kernel version, so it's easily possible to backport the upstream
functions to your own, older kernel if you desire.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile              |    6 ++++++
 check-dependencies.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100755 check-dependencies.sh

diff --git a/Makefile b/Makefile
index ee3be1d..a66ec66 100644
--- a/Makefile
+++ b/Makefile
@@ -50,6 +50,12 @@ ifneq ($(REVISION),)
 NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
 
+ifeq ($(CONFIG_BATMAN_ADV_MCAST),y)
+ifneq ($(shell $(PWD)/check-dependencies.sh $(KERNELPATH); echo $$?),0)
+	override CONFIG_BATMAN_ADV_MCAST=n
+endif
+endif
+
 BUILD_FLAGS := \
 	M=$(PWD)/net/batman-adv \
 	CONFIG_BATMAN_ADV=m \
diff --git a/check-dependencies.sh b/check-dependencies.sh
new file mode 100755
index 0000000..86e0654
--- /dev/null
+++ b/check-dependencies.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+DEPS_CONFIG_BATMAN_ADV_MCAST="CONFIG_IPV6:ipv6_mc_check_mld ip_mc_check_igmp"
+
+KERNELPATH="$1"
+RET=0
+
+for s in $DEPS_CONFIG_BATMAN_ADV_MCAST; do
+	if [ -n "${s##*:*}" ]; then
+		conf=""
+		dep="$s"
+	else
+		conf="${s%%:*}"
+		dep="${s#*:}"
+	fi
+
+	[ -n "$conf" ] && ! egrep -q "$conf=(m|y)" ${KERNELPATH}/.config && \
+		continue
+
+	grep -q "$dep" ${KERNELPATH}/Module.symvers && continue
+
+	echo	"WARNING: Missing built-in symbol \"$dep\" -" \
+		"disabling CONFIG_BATMAN_ADV_MCAST (Kernel too old?)" \
+		>&2
+
+	RET=1
+done
+
+exit $RET
-- 
1.7.10.4

