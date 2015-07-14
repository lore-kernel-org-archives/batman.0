Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 14 Jul 2015 21:57:04 +0200
Message-Id: <1436903824-24250-2-git-send-email-sven@narfation.org>
In-Reply-To: <1436903824-24250-1-git-send-email-sven@narfation.org>
References: <1436903824-24250-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 2/2] build_test: Drop support for Linux < 3.2
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

The Linux Kernel 2.6.32 is reaching its end of life [1] after over 5 years.
Instead it is recommended to use at least kernel 3.2 which is also already
over 3 years old. All older kernels (v2.6.32 - v3.1) should therefore be
dropped to reduce the test time. The amount of tested kernels jumps down
from 33 kernels to 20.

[1] https://lkml.org/lkml/2015/6/3/740

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 checkstuff.sh                                      |   9 +-
 generate_linux_headers.sh                          |  47 +-
 ...dd-missing-braces-to-do-while-in-kmemchec.patch |  39 --
 ...linux-kmemcheck.h-fix-a-trillion-warnings.patch |  39 --
 .../0001-net-fix-protocol-sk_buff-field.patch      |  39 --
 ...ine-keyword-for-static-function-in-linux-.patch |  31 -
 ...ine-keyword-for-static-function-in-linux-.patch |  31 -
 .../0002-net-fix-protocol-sk_buff-field.patch      |  39 --
 .../0003-percpu-remove-per_cpu__-prefix.patch      | 655 ---------------------
 .../0004-percpu-make-access-macros-universal.patch |  75 ---
 .../0005-percpu-add-__percpu-for-sparse.patch      | 124 ----
 ...-accessors-check-for-percpu-pointer-in-sp.patch |  99 ----
 ...handle-__percpu-notations-in-UP-accessors.patch |  58 --
 ...handle-__percpu-notations-in-UP-accessors.patch |  58 --
 ...ine-keyword-for-static-function-in-linux-.patch |  31 -
 ...handle-__percpu-notations-in-UP-accessors.patch |  58 --
 ...ine-keyword-for-static-function-in-linux-.patch |  31 -
 17 files changed, 7 insertions(+), 1456 deletions(-)
 delete mode 100644 patches/v2.6.31/0001-kmemcheck-add-missing-braces-to-do-while-in-kmemchec.patch
 delete mode 100644 patches/v2.6.31/0002-include-linux-kmemcheck.h-fix-a-trillion-warnings.patch
 delete mode 100644 patches/v2.6.32/0001-net-fix-protocol-sk_buff-field.patch
 delete mode 100644 patches/v2.6.32/0002-missing-inline-keyword-for-static-function-in-linux-.patch
 delete mode 100644 patches/v2.6.33/0001-missing-inline-keyword-for-static-function-in-linux-.patch
 delete mode 100644 patches/v2.6.33/0002-net-fix-protocol-sk_buff-field.patch
 delete mode 100644 patches/v2.6.33/0003-percpu-remove-per_cpu__-prefix.patch
 delete mode 100644 patches/v2.6.33/0004-percpu-make-access-macros-universal.patch
 delete mode 100644 patches/v2.6.33/0005-percpu-add-__percpu-for-sparse.patch
 delete mode 100644 patches/v2.6.33/0006-percpu-make-accessors-check-for-percpu-pointer-in-sp.patch
 delete mode 100644 patches/v2.6.33/0007-percpu-handle-__percpu-notations-in-UP-accessors.patch
 delete mode 100644 patches/v2.6.34/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch
 delete mode 100644 patches/v2.6.34/0002-missing-inline-keyword-for-static-function-in-linux-.patch
 delete mode 100644 patches/v2.6.35/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch
 delete mode 100644 patches/v2.6.35/0002-missing-inline-keyword-for-static-function-in-linux-.patch

diff --git a/checkstuff.sh b/checkstuff.sh
index a73d1f1..3fddae2 100755
--- a/checkstuff.sh
+++ b/checkstuff.sh
@@ -6,7 +6,7 @@ TO=${TO:="linux-merge@lists.open-mesh.org"}
 FROM=${FROM:="postmaster@open-mesh.org"}
 REMOTE=${REMOTE:="git+ssh://git@git.open-mesh.org/batman-adv.git"}
 
-LINUX_VERSIONS=$(echo linux-2.6.{29..39} linux-3.{0..19} linux-4.{0..1})
+LINUX_VERSIONS=$(echo linux-3.{2..19} linux-4.{0..1})
 LINUX_DEFAULT_VERSION=linux-4.1
 
 CGCC="$(pwd)/sparse/cgcc"
@@ -350,11 +350,8 @@ testbranch()
 				test_wrong_namespace "${branch}" "${linux_name}" "${config}"
 				"${MAKE}" $config KERNELPATH="${LINUX_HEADERS}"/"${linux_name}" clean
 
-				if [[ "$linux_name" != "linux-2.6."* ]]; then
-				echo "-"${linux_name}
-					test_smatch "${branch}" "${linux_name}" "${config}"
-					"${MAKE}" $config KERNELPATH="${LINUX_HEADERS}"/"${linux_name}" clean
-				fi
+				test_smatch "${branch}" "${linux_name}" "${config}"
+				"${MAKE}" $config KERNELPATH="${LINUX_HEADERS}"/"${linux_name}" clean
 			done
 		done
 
diff --git a/generate_linux_headers.sh b/generate_linux_headers.sh
index 9a935ba..fdd804d 100755
--- a/generate_linux_headers.sh
+++ b/generate_linux_headers.sh
@@ -29,12 +29,6 @@ prepare_source()
 	grep -v 'CONFIG_ENABLE_WARN_DEPRECATED is not set' .config > .config.tmp; mv .config.tmp .config
 	grep -v 'CONFIG_CRC16 is not set' .config > .config.tmp; mv .config.tmp .config
 	grep -v 'CONFIG_DEBUG_FS is not set' .config > .config.tmp; mv .config.tmp .config
-	if [ "$3" != "smp" ]; then
-		grep -v 'CONFIG_SMP is not set' .config > .config.tmp; mv .config.tmp .config
-		grep -v 'CONFIG_MODULE_UNLOAD is not set' .config > .config.tmp; mv .config.tmp .config
-		echo 'CONFIG_SMP=y' >> .config
-		echo 'CONFIG_MODULE_UNLOAD=y' >> .config
-	fi
 	echo 'CONFIG_MODULES=y' >> .config
 	if [ "${MAKE_AMD64}" != "0" ]; then
 		echo 'CONFIG_64BIT=y' >> .config
@@ -47,11 +41,7 @@ prepare_source()
 	echo 'CONFIG_ENABLE_WARN_DEPRECATED=y' >> .config
 	echo 'CONFIG_CRC16=y' >> .config
 	echo 'CONFIG_DEBUG_FS=y' >> .config
-	if [ "$1" = "2.6" -a \( "$2" = "29" -o "$2" = "30" -o "$2" = "31" -o "$2" = "32" -o "$2" = "33" -o "$2" = "34" -o "$2" = "35" \) ]; then
-		echo 'xy'|make menuconfig
-	else
-		make oldnoconfig
-	fi
+	make oldnoconfig
 	make prepare
 	make modules
 }
@@ -78,7 +68,6 @@ generate_squashfs()
 	rm -f linux-build.img
 	rm -rf linux-build
 	mkdir -p linux-build
-	mv linux-2.6.* linux-build
 	mv linux-3* linux-build
 	mv linux-4* linux-build
 	mksquashfs linux-build linux-build.img
@@ -86,38 +75,11 @@ generate_squashfs()
 	echo ok
 }
 
-for i in `seq 29 39`; do
-	#wget "http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.${i}.tar.gz"
-	#tar xfz "linux-2.6.${i}.tar.gz"
-	#rm "linux-2.6.${i}.tar.gz"
-	git archive --remote="${LINUX_REPOSITORY}" --format tar --prefix=linux-2.6.${i}/ v2.6.${i}|tar x
-	(
-		cd "linux-2.6.${i}" || exit
-		if [ "$i" = 29 -o "$i" = 30 -o "$i" = 31 -o "$i" = 32 -o "$i" = 33 -o "$i" = 34 -o "$i" = 35 -o "$i" = 36 ]; then
-			sed -i 's/^\(KBUILD_CFLAGS[[:space:]]*:=\)[[:space:]]*\(-Wall\)/\1 -Wno-unused-but-set-variable \2/' Makefile
-		fi
-		if [ "$i" != 32 -a "$i" != 33 ]; then
-			SMP=smp
-		else
-			SMP=nosmp
-		fi
-		prepare_source "2.6" "${i}" "$SMP"
-		if [ -d "../patches/v2.6.${i}" ]; then
-			for p in "../patches/v2.6.${i}/"*.patch; do
-				patch -p1 -i "${p}"
-			done
-		fi
-
-		clean_source
-	)
-done
-
-for i in `seq 0 19`; do
+for i in `seq 2 19`; do
 	git archive --remote="${LINUX_REPOSITORY}" --format tar --prefix=linux-3.${i}/ v3.${i}|tar x
 	(
 		cd "linux-3.${i}" || exit
-		SMP=smp
-		prepare_source "3" "${i}" "$SMP"
+		prepare_source "3" "${i}"
 		if [ -d "../patches/v3.${i}" ]; then
 			for p in "../patches/v3.${i}/"*.patch; do
 				patch -p1 -i "${p}"
@@ -132,8 +94,7 @@ for i in `seq 0 1`; do
 	git archive --remote="${LINUX_REPOSITORY}" --format tar --prefix=linux-4.${i}/ v4.${i}|tar x
 	(
 		cd "linux-4.${i}" || exit
-		SMP=smp
-		prepare_source "4" "${i}" "$SMP"
+		prepare_source "4" "${i}"
 		if [ -d "../patches/v4.${i}" ]; then
 			for p in "../patches/v4.${i}/"*.patch; do
 				patch -p1 -i "${p}"
diff --git a/patches/v2.6.31/0001-kmemcheck-add-missing-braces-to-do-while-in-kmemchec.patch b/patches/v2.6.31/0001-kmemcheck-add-missing-braces-to-do-while-in-kmemchec.patch
deleted file mode 100644
index 5076829..0000000
--- a/patches/v2.6.31/0001-kmemcheck-add-missing-braces-to-do-while-in-kmemchec.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From 181f7c5dd3832763bdf2756b6d2d8a49bdf12791 Mon Sep 17 00:00:00 2001
-From: Johannes Berg <johannes@sipsolutions.net>
-Date: Mon, 6 Jul 2009 11:53:03 +0200
-Subject: [PATCH] kmemcheck: add missing braces to do-while in
- kmemcheck_annotate_bitfield
-
-Whether or not the sparse warning
-
-	warning: do-while statement is not a compound statement
-
-is justified or not in this case, it is annoying and trivial to fix.
-
-[vegard.nossum@gmail.com: title and cleanup]
-Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
-Signed-off-by: Vegard Nossum <vegard.nossum@gmail.com>
-Signed-off-by: Sven Eckelmann <sven@narfation.org>
----
- include/linux/kmemcheck.h |    5 ++++-
- 1 file changed, 4 insertions(+), 1 deletion(-)
-
-diff --git a/include/linux/kmemcheck.h b/include/linux/kmemcheck.h
-index 47b39b7..06c6c55 100644
---- a/include/linux/kmemcheck.h
-+++ b/include/linux/kmemcheck.h
-@@ -137,7 +137,10 @@ static inline void kmemcheck_mark_initialized_pages(struct page *p,
- 	int name##_end[0];
- 
- #define kmemcheck_annotate_bitfield(ptr, name)				\
--	do if (ptr) {							\
-+	do {								\
-+		if (!ptr)						\
-+			break;						\
-+									\
- 		int _n = (long) &((ptr)->name##_end)			\
- 			- (long) &((ptr)->name##_begin);		\
- 		BUILD_BUG_ON(_n < 0);					\
--- 
-1.7.10
-
diff --git a/patches/v2.6.31/0002-include-linux-kmemcheck.h-fix-a-trillion-warnings.patch b/patches/v2.6.31/0002-include-linux-kmemcheck.h-fix-a-trillion-warnings.patch
deleted file mode 100644
index e382407..0000000
--- a/patches/v2.6.31/0002-include-linux-kmemcheck.h-fix-a-trillion-warnings.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From fa081b00a80ef3f4575c99af6e97d29e1628cf51 Mon Sep 17 00:00:00 2001
-From: Andrew Morton <akpm@linux-foundation.org>
-Date: Tue, 22 Sep 2009 16:43:27 -0700
-Subject: [PATCH] include/linux/kmemcheck.h: fix a trillion warnings
-
-of the form
-
-include/net/inet_sock.h:208: warning: ISO C90 forbids mixed declarations and code
-
-Cc: Johannes Berg <johannes@sipsolutions.net>
-Acked-by: Vegard Nossum <vegard.nossum@gmail.com>
-Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
-Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
-Signed-off-by: Sven Eckelmann <sven@narfation.org>
----
- include/linux/kmemcheck.h |    4 +++-
- 1 file changed, 3 insertions(+), 1 deletion(-)
-
-diff --git a/include/linux/kmemcheck.h b/include/linux/kmemcheck.h
-index c800660..136cdcd 100644
---- a/include/linux/kmemcheck.h
-+++ b/include/linux/kmemcheck.h
-@@ -145,10 +145,12 @@ static inline bool kmemcheck_is_obj_initialized(unsigned long addr, size_t size)
- 
- #define kmemcheck_annotate_bitfield(ptr, name)				\
- 	do {								\
-+		int _n;							\
-+									\
- 		if (!ptr)						\
- 			break;						\
- 									\
--		int _n = (long) &((ptr)->name##_end)			\
-+		_n = (long) &((ptr)->name##_end)			\
- 			- (long) &((ptr)->name##_begin);		\
- 		BUILD_BUG_ON(_n < 0);					\
- 									\
--- 
-1.7.10
-
diff --git a/patches/v2.6.32/0001-net-fix-protocol-sk_buff-field.patch b/patches/v2.6.32/0001-net-fix-protocol-sk_buff-field.patch
deleted file mode 100644
index c3d963c..0000000
--- a/patches/v2.6.32/0001-net-fix-protocol-sk_buff-field.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From 0eb2d8c95627fbc1906ebc1a61b7ea34a80e9b52 Mon Sep 17 00:00:00 2001
-From: Eric Dumazet <eric.dumazet@gmail.com>
-Date: Mon, 1 Mar 2010 03:09:26 +0000
-Subject: [PATCH] net: fix protocol sk_buff field
-
-Commit e992cd9b72a18 (kmemcheck: make bitfield annotations truly no-ops
-when disabled) allows us to revert a workaround we did in the past to
-not add holes in sk_buff structure.
-
-This patch partially reverts commit 14d18a81b5171
-(net: fix kmemcheck annotations) so that sparse doesnt complain:
-
-include/linux/skbuff.h:357:41: error: invalid bitfield specifier for
-type restricted __be16.
-
-Reported-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
-Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
-Signed-off-by: David S. Miller <davem@davemloft.net>
----
- include/linux/skbuff.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
-index bcdd660..ec21ec3 100644
---- a/include/linux/skbuff.h
-+++ b/include/linux/skbuff.h
-@@ -354,8 +354,8 @@ struct sk_buff {
- 				ipvs_property:1,
- 				peeked:1,
- 				nf_trace:1;
--	__be16			protocol:16;
- 	kmemcheck_bitfield_end(flags1);
-+	__be16			protocol;
- 
- 	void			(*destructor)(struct sk_buff *skb);
- #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
--- 
-2.1.4
-
diff --git a/patches/v2.6.32/0002-missing-inline-keyword-for-static-function-in-linux-.patch b/patches/v2.6.32/0002-missing-inline-keyword-for-static-function-in-linux-.patch
deleted file mode 100644
index 306c49a..0000000
--- a/patches/v2.6.32/0002-missing-inline-keyword-for-static-function-in-linux-.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From b7af370026f5accdaaaad5b6dd1605227060c9c4 Mon Sep 17 00:00:00 2001
-From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Date: Sat, 14 Aug 2010 15:02:44 +0200
-Subject: [PATCH] missing inline keyword for static function in
- linux/dmaengine.h
-
-Add a missing inline keyword for static function in linux/dmaengine.h to
-avoid duplicate symbol definitions.
-
-Signed-off-by: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Signed-off-by: Dan Williams <dan.j.williams@intel.com>
----
- include/linux/dmaengine.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
-index 5204f01..57d2b76 100644
---- a/include/linux/dmaengine.h
-+++ b/include/linux/dmaengine.h
-@@ -477,7 +477,7 @@ static inline bool dma_dev_has_pq_continue(struct dma_device *dma)
- 	return (dma->max_pq & DMA_HAS_PQ_CONTINUE) == DMA_HAS_PQ_CONTINUE;
- }
- 
--static unsigned short dma_dev_to_maxpq(struct dma_device *dma)
-+static inline unsigned short dma_dev_to_maxpq(struct dma_device *dma)
- {
- 	return dma->max_pq & ~DMA_HAS_PQ_CONTINUE;
- }
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0001-missing-inline-keyword-for-static-function-in-linux-.patch b/patches/v2.6.33/0001-missing-inline-keyword-for-static-function-in-linux-.patch
deleted file mode 100644
index 88a0dfd..0000000
--- a/patches/v2.6.33/0001-missing-inline-keyword-for-static-function-in-linux-.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From a1f09ed3ad6444409a4aeacee8a2f1c99e6b5241 Mon Sep 17 00:00:00 2001
-From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Date: Sat, 14 Aug 2010 15:02:44 +0200
-Subject: [PATCH 1/7] missing inline keyword for static function in
- linux/dmaengine.h
-
-Add a missing inline keyword for static function in linux/dmaengine.h to
-avoid duplicate symbol definitions.
-
-Signed-off-by: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Signed-off-by: Dan Williams <dan.j.williams@intel.com>
----
- include/linux/dmaengine.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
-index 7878498..ee0b0dc 100644
---- a/include/linux/dmaengine.h
-+++ b/include/linux/dmaengine.h
-@@ -380,7 +380,7 @@ static inline bool dma_dev_has_pq_continue(struct dma_device *dma)
- 	return (dma->max_pq & DMA_HAS_PQ_CONTINUE) == DMA_HAS_PQ_CONTINUE;
- }
- 
--static unsigned short dma_dev_to_maxpq(struct dma_device *dma)
-+static inline unsigned short dma_dev_to_maxpq(struct dma_device *dma)
- {
- 	return dma->max_pq & ~DMA_HAS_PQ_CONTINUE;
- }
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0002-net-fix-protocol-sk_buff-field.patch b/patches/v2.6.33/0002-net-fix-protocol-sk_buff-field.patch
deleted file mode 100644
index c41f6ce..0000000
--- a/patches/v2.6.33/0002-net-fix-protocol-sk_buff-field.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From 7022d866f871a5118321aade57b2b6e09728eaad Mon Sep 17 00:00:00 2001
-From: Eric Dumazet <eric.dumazet@gmail.com>
-Date: Mon, 1 Mar 2010 03:09:26 +0000
-Subject: [PATCH 2/7] net: fix protocol sk_buff field
-
-Commit e992cd9b72a18 (kmemcheck: make bitfield annotations truly no-ops
-when disabled) allows us to revert a workaround we did in the past to
-not add holes in sk_buff structure.
-
-This patch partially reverts commit 14d18a81b5171
-(net: fix kmemcheck annotations) so that sparse doesnt complain:
-
-include/linux/skbuff.h:357:41: error: invalid bitfield specifier for
-type restricted __be16.
-
-Reported-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
-Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
-Signed-off-by: David S. Miller <davem@davemloft.net>
----
- include/linux/skbuff.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
-index ae836fd..b40f56b 100644
---- a/include/linux/skbuff.h
-+++ b/include/linux/skbuff.h
-@@ -354,8 +354,8 @@ struct sk_buff {
- 				ipvs_property:1,
- 				peeked:1,
- 				nf_trace:1;
--	__be16			protocol:16;
- 	kmemcheck_bitfield_end(flags1);
-+	__be16			protocol;
- 
- 	void			(*destructor)(struct sk_buff *skb);
- #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0003-percpu-remove-per_cpu__-prefix.patch b/patches/v2.6.33/0003-percpu-remove-per_cpu__-prefix.patch
deleted file mode 100644
index dc74140..0000000
--- a/patches/v2.6.33/0003-percpu-remove-per_cpu__-prefix.patch
+++ /dev/null
@@ -1,655 +0,0 @@
-From 025bda5735eb7746121414498056a548a58679f0 Mon Sep 17 00:00:00 2001
-From: Rusty Russell <rusty@rustcorp.com.au>
-Date: Thu, 29 Oct 2009 22:34:15 +0900
-Subject: [PATCH 3/7] percpu: remove per_cpu__ prefix.
-
-Now that the return from alloc_percpu is compatible with the address
-of per-cpu vars, it makes sense to hand around the address of per-cpu
-variables.  To make this sane, we remove the per_cpu__ prefix we used
-created to stop people accidentally using these vars directly.
-
-Now we have sparse, we can use that (next patch).
-
-tj: * Updated to convert stuff which were missed by or added after the
-      original patch.
-
-    * Kill per_cpu_var() macro.
-
-Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
-Signed-off-by: Tejun Heo <tj@kernel.org>
-Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
----
- arch/blackfin/mach-common/entry.S    |  4 ++--
- arch/cris/arch-v10/kernel/entry.S    |  2 +-
- arch/cris/arch-v32/mm/mmu.S          |  2 +-
- arch/ia64/include/asm/percpu.h       |  4 ++--
- arch/ia64/kernel/ia64_ksyms.c        |  4 ++--
- arch/ia64/mm/discontig.c             |  2 +-
- arch/microblaze/include/asm/entry.h  |  2 +-
- arch/parisc/lib/fixup.S              |  8 ++++----
- arch/sparc/kernel/nmi.c              |  6 +++---
- arch/sparc/kernel/rtrap_64.S         |  8 ++++----
- arch/x86/include/asm/percpu.h        | 37 +++++++++++++++++-------------------
- arch/x86/include/asm/system.h        |  8 ++++----
- arch/x86/kernel/apic/nmi.c           |  6 +++---
- arch/x86/kernel/head_32.S            |  6 +++---
- arch/x86/kernel/vmlinux.lds.S        |  4 ++--
- arch/x86/xen/xen-asm_32.S            |  4 ++--
- include/asm-generic/percpu.h         | 12 ++++++------
- include/linux/percpu-defs.h          | 18 ++++++------------
- include/linux/percpu.h               |  5 ++---
- include/linux/vmstat.h               |  8 ++++----
- kernel/rcutorture.c                  |  8 ++++----
- kernel/trace/trace.c                 |  6 +++---
- kernel/trace/trace_functions_graph.c |  4 ++--
- 23 files changed, 79 insertions(+), 89 deletions(-)
-
-diff --git a/arch/blackfin/mach-common/entry.S b/arch/blackfin/mach-common/entry.S
-index b0ed0b4..01b2f58 100644
---- a/arch/blackfin/mach-common/entry.S
-+++ b/arch/blackfin/mach-common/entry.S
-@@ -816,8 +816,8 @@ ENDPROC(_resume)
- 
- ENTRY(_ret_from_exception)
- #ifdef CONFIG_IPIPE
--	p2.l = _per_cpu__ipipe_percpu_domain;
--	p2.h = _per_cpu__ipipe_percpu_domain;
-+	p2.l = _ipipe_percpu_domain;
-+	p2.h = _ipipe_percpu_domain;
- 	r0.l = _ipipe_root;
- 	r0.h = _ipipe_root;
- 	r2 = [p2];
-diff --git a/arch/cris/arch-v10/kernel/entry.S b/arch/cris/arch-v10/kernel/entry.S
-index 2c18d08..c52bef3 100644
---- a/arch/cris/arch-v10/kernel/entry.S
-+++ b/arch/cris/arch-v10/kernel/entry.S
-@@ -358,7 +358,7 @@ mmu_bus_fault:
- 1:	btstq	12, $r1		   ; Refill?
- 	bpl	2f
- 	lsrq	24, $r1     ; Get PGD index (bit 24-31)
--	move.d  [per_cpu__current_pgd], $r0 ; PGD for the current process
-+	move.d  [current_pgd], $r0 ; PGD for the current process
- 	move.d	[$r0+$r1.d], $r0   ; Get PMD
- 	beq	2f
- 	nop
-diff --git a/arch/cris/arch-v32/mm/mmu.S b/arch/cris/arch-v32/mm/mmu.S
-index 2238d15..f125d91 100644
---- a/arch/cris/arch-v32/mm/mmu.S
-+++ b/arch/cris/arch-v32/mm/mmu.S
-@@ -115,7 +115,7 @@
- #ifdef CONFIG_SMP
- 	move    $s7, $acr	; PGD
- #else
--	move.d  per_cpu__current_pgd, $acr ; PGD
-+	move.d  current_pgd, $acr ; PGD
- #endif
- 	; Look up PMD in PGD
- 	lsrq	24, $r0	; Get PMD index into PGD (bit 24-31)
-diff --git a/arch/ia64/include/asm/percpu.h b/arch/ia64/include/asm/percpu.h
-index 30cf465..f7c00a5 100644
---- a/arch/ia64/include/asm/percpu.h
-+++ b/arch/ia64/include/asm/percpu.h
-@@ -9,7 +9,7 @@
- #define PERCPU_ENOUGH_ROOM PERCPU_PAGE_SIZE
- 
- #ifdef __ASSEMBLY__
--# define THIS_CPU(var)	(per_cpu__##var)  /* use this to mark accesses to per-CPU variables... */
-+# define THIS_CPU(var)	(var)  /* use this to mark accesses to per-CPU variables... */
- #else /* !__ASSEMBLY__ */
- 
- 
-@@ -39,7 +39,7 @@ extern void *per_cpu_init(void);
-  * On the positive side, using __ia64_per_cpu_var() instead of __get_cpu_var() is slightly
-  * more efficient.
-  */
--#define __ia64_per_cpu_var(var)	per_cpu__##var
-+#define __ia64_per_cpu_var(var)	var
- 
- #include <asm-generic/percpu.h>
- 
-diff --git a/arch/ia64/kernel/ia64_ksyms.c b/arch/ia64/kernel/ia64_ksyms.c
-index 461b999..7f4a0ed 100644
---- a/arch/ia64/kernel/ia64_ksyms.c
-+++ b/arch/ia64/kernel/ia64_ksyms.c
-@@ -30,9 +30,9 @@ EXPORT_SYMBOL(max_low_pfn);	/* defined by bootmem.c, but not exported by generic
- #endif
- 
- #include <asm/processor.h>
--EXPORT_SYMBOL(per_cpu__ia64_cpu_info);
-+EXPORT_SYMBOL(ia64_cpu_info);
- #ifdef CONFIG_SMP
--EXPORT_SYMBOL(per_cpu__local_per_cpu_offset);
-+EXPORT_SYMBOL(local_per_cpu_offset);
- #endif
- 
- #include <asm/uaccess.h>
-diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
-index 19c4b21..8d586d1 100644
---- a/arch/ia64/mm/discontig.c
-+++ b/arch/ia64/mm/discontig.c
-@@ -459,7 +459,7 @@ static void __init initialize_pernode_data(void)
- 		cpu = 0;
- 		node = node_cpuid[cpu].nid;
- 		cpu0_cpu_info = (struct cpuinfo_ia64 *)(__phys_per_cpu_start +
--			((char *)&per_cpu__ia64_cpu_info - __per_cpu_start));
-+			((char *)&ia64_cpu_info - __per_cpu_start));
- 		cpu0_cpu_info->node_data = mem_data[node].node_data;
- 	}
- #endif /* CONFIG_SMP */
-diff --git a/arch/microblaze/include/asm/entry.h b/arch/microblaze/include/asm/entry.h
-index 61abbd2..ec89f2a 100644
---- a/arch/microblaze/include/asm/entry.h
-+++ b/arch/microblaze/include/asm/entry.h
-@@ -21,7 +21,7 @@
-  * places
-  */
- 
--#define PER_CPU(var) per_cpu__##var
-+#define PER_CPU(var) var
- 
- # ifndef __ASSEMBLY__
- DECLARE_PER_CPU(unsigned int, KSP); /* Saved kernel stack pointer */
-diff --git a/arch/parisc/lib/fixup.S b/arch/parisc/lib/fixup.S
-index d172d42..f8c45cc 100644
---- a/arch/parisc/lib/fixup.S
-+++ b/arch/parisc/lib/fixup.S
-@@ -36,8 +36,8 @@
- #endif
- 	/* t2 = &__per_cpu_offset[smp_processor_id()]; */
- 	LDREGX \t2(\t1),\t2 
--	addil LT%per_cpu__exception_data,%r27
--	LDREG RT%per_cpu__exception_data(%r1),\t1
-+	addil LT%exception_data,%r27
-+	LDREG RT%exception_data(%r1),\t1
- 	/* t1 = &__get_cpu_var(exception_data) */
- 	add,l \t1,\t2,\t1
- 	/* t1 = t1->fault_ip */
-@@ -46,8 +46,8 @@
- #else
- 	.macro  get_fault_ip t1 t2
- 	/* t1 = &__get_cpu_var(exception_data) */
--	addil LT%per_cpu__exception_data,%r27
--	LDREG RT%per_cpu__exception_data(%r1),\t2
-+	addil LT%exception_data,%r27
-+	LDREG RT%exception_data(%r1),\t2
- 	/* t1 = t2->fault_ip */
- 	LDREG EXCDATA_IP(\t2), \t1
- 	.endm
-diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
-index d242a73..3c8af79 100644
---- a/arch/sparc/kernel/nmi.c
-+++ b/arch/sparc/kernel/nmi.c
-@@ -113,13 +113,13 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
- 		touched = 1;
- 	}
- 	if (!touched && __get_cpu_var(last_irq_sum) == sum) {
--		__this_cpu_inc(per_cpu_var(alert_counter));
--		if (__this_cpu_read(per_cpu_var(alert_counter)) == 30 * nmi_hz)
-+		__this_cpu_inc(alert_counter);
-+		if (__this_cpu_read(alert_counter) == 30 * nmi_hz)
- 			die_nmi("BUG: NMI Watchdog detected LOCKUP",
- 				regs, panic_on_timeout);
- 	} else {
- 		__get_cpu_var(last_irq_sum) = sum;
--		__this_cpu_write(per_cpu_var(alert_counter), 0);
-+		__this_cpu_write(alert_counter, 0);
- 	}
- 	if (__get_cpu_var(wd_enabled)) {
- 		write_pic(picl_value(nmi_hz));
-diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
-index fd3cee4..1ddec40 100644
---- a/arch/sparc/kernel/rtrap_64.S
-+++ b/arch/sparc/kernel/rtrap_64.S
-@@ -149,11 +149,11 @@ rtrap_nmi:	ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
- rtrap_irq:
- rtrap:
- #ifndef CONFIG_SMP
--		sethi			%hi(per_cpu____cpu_data), %l0
--		lduw			[%l0 + %lo(per_cpu____cpu_data)], %l1
-+		sethi			%hi(__cpu_data), %l0
-+		lduw			[%l0 + %lo(__cpu_data)], %l1
- #else
--		sethi			%hi(per_cpu____cpu_data), %l0
--		or			%l0, %lo(per_cpu____cpu_data), %l0
-+		sethi			%hi(__cpu_data), %l0
-+		or			%l0, %lo(__cpu_data), %l0
- 		lduw			[%l0 + %g5], %l1
- #endif
- 		cmp			%l1, 0
-diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
-index 0c44196..4c170cc 100644
---- a/arch/x86/include/asm/percpu.h
-+++ b/arch/x86/include/asm/percpu.h
-@@ -25,19 +25,18 @@
-  */
- #ifdef CONFIG_SMP
- #define PER_CPU(var, reg)						\
--	__percpu_mov_op %__percpu_seg:per_cpu__this_cpu_off, reg;	\
--	lea per_cpu__##var(reg), reg
--#define PER_CPU_VAR(var)	%__percpu_seg:per_cpu__##var
-+	__percpu_mov_op %__percpu_seg:this_cpu_off, reg;		\
-+	lea var(reg), reg
-+#define PER_CPU_VAR(var)	%__percpu_seg:var
- #else /* ! SMP */
--#define PER_CPU(var, reg)						\
--	__percpu_mov_op $per_cpu__##var, reg
--#define PER_CPU_VAR(var)	per_cpu__##var
-+#define PER_CPU(var, reg)	__percpu_mov_op $var, reg
-+#define PER_CPU_VAR(var)	var
- #endif	/* SMP */
- 
- #ifdef CONFIG_X86_64_SMP
- #define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
- #else
--#define INIT_PER_CPU_VAR(var)  per_cpu__##var
-+#define INIT_PER_CPU_VAR(var)  var
- #endif
- 
- #else /* ...!ASSEMBLY */
-@@ -60,12 +59,12 @@
-  * There also must be an entry in vmlinux_64.lds.S
-  */
- #define DECLARE_INIT_PER_CPU(var) \
--       extern typeof(per_cpu_var(var)) init_per_cpu_var(var)
-+       extern typeof(var) init_per_cpu_var(var)
- 
- #ifdef CONFIG_X86_64_SMP
- #define init_per_cpu_var(var)  init_per_cpu__##var
- #else
--#define init_per_cpu_var(var)  per_cpu_var(var)
-+#define init_per_cpu_var(var)  var
- #endif
- 
- /* For arch-specific code, we can use direct single-insn ops (they
-@@ -142,16 +141,14 @@ do {							\
-  * per-thread variables implemented as per-cpu variables and thus
-  * stable for the duration of the respective task.
-  */
--#define percpu_read(var)	percpu_from_op("mov", per_cpu__##var,	\
--					       "m" (per_cpu__##var))
--#define percpu_read_stable(var)	percpu_from_op("mov", per_cpu__##var,	\
--					       "p" (&per_cpu__##var))
--#define percpu_write(var, val)	percpu_to_op("mov", per_cpu__##var, val)
--#define percpu_add(var, val)	percpu_to_op("add", per_cpu__##var, val)
--#define percpu_sub(var, val)	percpu_to_op("sub", per_cpu__##var, val)
--#define percpu_and(var, val)	percpu_to_op("and", per_cpu__##var, val)
--#define percpu_or(var, val)	percpu_to_op("or", per_cpu__##var, val)
--#define percpu_xor(var, val)	percpu_to_op("xor", per_cpu__##var, val)
-+#define percpu_read(var)		percpu_from_op("mov", var, "m" (var))
-+#define percpu_read_stable(var)		percpu_from_op("mov", var, "p" (&(var)))
-+#define percpu_write(var, val)		percpu_to_op("mov", var, val)
-+#define percpu_add(var, val)		percpu_to_op("add", var, val)
-+#define percpu_sub(var, val)		percpu_to_op("sub", var, val)
-+#define percpu_and(var, val)		percpu_to_op("and", var, val)
-+#define percpu_or(var, val)		percpu_to_op("or", var, val)
-+#define percpu_xor(var, val)		percpu_to_op("xor", var, val)
- 
- #define __this_cpu_read_1(pcp)		percpu_from_op("mov", (pcp), "m"(pcp))
- #define __this_cpu_read_2(pcp)		percpu_from_op("mov", (pcp), "m"(pcp))
-@@ -236,7 +233,7 @@ do {							\
- ({									\
- 	int old__;							\
- 	asm volatile("btr %2,"__percpu_arg(1)"\n\tsbbl %0,%0"		\
--		     : "=r" (old__), "+m" (per_cpu__##var)		\
-+		     : "=r" (old__), "+m" (var)				\
- 		     : "dIr" (bit));					\
- 	old__;								\
- })
-diff --git a/arch/x86/include/asm/system.h b/arch/x86/include/asm/system.h
-index e04740f..b8fe48e 100644
---- a/arch/x86/include/asm/system.h
-+++ b/arch/x86/include/asm/system.h
-@@ -32,7 +32,7 @@ extern void show_regs_common(void);
- 	"movl %P[task_canary](%[next]), %%ebx\n\t"			\
- 	"movl %%ebx, "__percpu_arg([stack_canary])"\n\t"
- #define __switch_canary_oparam						\
--	, [stack_canary] "=m" (per_cpu_var(stack_canary.canary))
-+	, [stack_canary] "=m" (stack_canary.canary)
- #define __switch_canary_iparam						\
- 	, [task_canary] "i" (offsetof(struct task_struct, stack_canary))
- #else	/* CC_STACKPROTECTOR */
-@@ -114,7 +114,7 @@ do {									\
- 	"movq %P[task_canary](%%rsi),%%r8\n\t"				  \
- 	"movq %%r8,"__percpu_arg([gs_canary])"\n\t"
- #define __switch_canary_oparam						  \
--	, [gs_canary] "=m" (per_cpu_var(irq_stack_union.stack_canary))
-+	, [gs_canary] "=m" (irq_stack_union.stack_canary)
- #define __switch_canary_iparam						  \
- 	, [task_canary] "i" (offsetof(struct task_struct, stack_canary))
- #else	/* CC_STACKPROTECTOR */
-@@ -133,7 +133,7 @@ do {									\
- 	     __switch_canary						  \
- 	     "movq %P[thread_info](%%rsi),%%r8\n\t"			  \
- 	     "movq %%rax,%%rdi\n\t" 					  \
--	     "testl  %[_tif_fork],%P[ti_flags](%%r8)\n\t"	  \
-+	     "testl  %[_tif_fork],%P[ti_flags](%%r8)\n\t"		  \
- 	     "jnz   ret_from_fork\n\t"					  \
- 	     RESTORE_CONTEXT						  \
- 	     : "=a" (last)					  	  \
-@@ -143,7 +143,7 @@ do {									\
- 	       [ti_flags] "i" (offsetof(struct thread_info, flags)),	  \
- 	       [_tif_fork] "i" (_TIF_FORK),			  	  \
- 	       [thread_info] "i" (offsetof(struct task_struct, stack)),   \
--	       [current_task] "m" (per_cpu_var(current_task))		  \
-+	       [current_task] "m" (current_task)			  \
- 	       __switch_canary_iparam					  \
- 	     : "memory", "cc" __EXTRA_CLOBBER)
- #endif
-diff --git a/arch/x86/kernel/apic/nmi.c b/arch/x86/kernel/apic/nmi.c
-index 0159a69..4ada42c 100644
---- a/arch/x86/kernel/apic/nmi.c
-+++ b/arch/x86/kernel/apic/nmi.c
-@@ -438,8 +438,8 @@ nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
- 		 * Ayiee, looks like this CPU is stuck ...
- 		 * wait a few IRQs (5 seconds) before doing the oops ...
- 		 */
--		__this_cpu_inc(per_cpu_var(alert_counter));
--		if (__this_cpu_read(per_cpu_var(alert_counter)) == 5 * nmi_hz)
-+		__this_cpu_inc(alert_counter);
-+		if (__this_cpu_read(alert_counter) == 5 * nmi_hz)
- 			/*
- 			 * die_nmi will return ONLY if NOTIFY_STOP happens..
- 			 */
-@@ -447,7 +447,7 @@ nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
- 				regs, panic_on_timeout);
- 	} else {
- 		__get_cpu_var(last_irq_sum) = sum;
--		__this_cpu_write(per_cpu_var(alert_counter), 0);
-+		__this_cpu_write(alert_counter, 0);
- 	}
- 
- 	/* see if the nmi watchdog went off */
-diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
-index 7fd318b..37c3d4b 100644
---- a/arch/x86/kernel/head_32.S
-+++ b/arch/x86/kernel/head_32.S
-@@ -442,8 +442,8 @@ is386:	movl $2,%ecx		# set MP
- 	 */
- 	cmpb $0,ready
- 	jne 1f
--	movl $per_cpu__gdt_page,%eax
--	movl $per_cpu__stack_canary,%ecx
-+	movl $gdt_page,%eax
-+	movl $stack_canary,%ecx
- 	movw %cx, 8 * GDT_ENTRY_STACK_CANARY + 2(%eax)
- 	shrl $16, %ecx
- 	movb %cl, 8 * GDT_ENTRY_STACK_CANARY + 4(%eax)
-@@ -706,7 +706,7 @@ idt_descr:
- 	.word 0				# 32 bit align gdt_desc.address
- ENTRY(early_gdt_descr)
- 	.word GDT_ENTRIES*8-1
--	.long per_cpu__gdt_page		/* Overwritten for secondary CPUs */
-+	.long gdt_page			/* Overwritten for secondary CPUs */
- 
- /*
-  * The boot_gdt must mirror the equivalent in setup.S and is
-diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index f92a0da..44879df 100644
---- a/arch/x86/kernel/vmlinux.lds.S
-+++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -341,7 +341,7 @@ SECTIONS
-  * Per-cpu symbols which need to be offset from __per_cpu_load
-  * for the boot processor.
-  */
--#define INIT_PER_CPU(x) init_per_cpu__##x = per_cpu__##x + __per_cpu_load
-+#define INIT_PER_CPU(x) init_per_cpu__##x = x + __per_cpu_load
- INIT_PER_CPU(gdt_page);
- INIT_PER_CPU(irq_stack_union);
- 
-@@ -352,7 +352,7 @@ INIT_PER_CPU(irq_stack_union);
- 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
- 
- #ifdef CONFIG_SMP
--. = ASSERT((per_cpu__irq_stack_union == 0),
-+. = ASSERT((irq_stack_union == 0),
-            "irq_stack_union is not at start of per-cpu area");
- #endif
- 
-diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
-index 88e15de..22a2093 100644
---- a/arch/x86/xen/xen-asm_32.S
-+++ b/arch/x86/xen/xen-asm_32.S
-@@ -90,9 +90,9 @@ ENTRY(xen_iret)
- 	GET_THREAD_INFO(%eax)
- 	movl TI_cpu(%eax), %eax
- 	movl __per_cpu_offset(,%eax,4), %eax
--	mov per_cpu__xen_vcpu(%eax), %eax
-+	mov xen_vcpu(%eax), %eax
- #else
--	movl per_cpu__xen_vcpu, %eax
-+	movl xen_vcpu, %eax
- #endif
- 
- 	/* check IF state we're restoring */
-diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
-index 8087b90..ca6f049 100644
---- a/include/asm-generic/percpu.h
-+++ b/include/asm-generic/percpu.h
-@@ -50,11 +50,11 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
-  * offset.
-  */
- #define per_cpu(var, cpu) \
--	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), per_cpu_offset(cpu)))
-+	(*SHIFT_PERCPU_PTR(&(var), per_cpu_offset(cpu)))
- #define __get_cpu_var(var) \
--	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), my_cpu_offset))
-+	(*SHIFT_PERCPU_PTR(&(var), my_cpu_offset))
- #define __raw_get_cpu_var(var) \
--	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), __my_cpu_offset))
-+	(*SHIFT_PERCPU_PTR(&(var), __my_cpu_offset))
- 
- #define this_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, my_cpu_offset)
- #define __this_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
-@@ -66,9 +66,9 @@ extern void setup_per_cpu_areas(void);
- 
- #else /* ! SMP */
- 
--#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu_var(var)))
--#define __get_cpu_var(var)			per_cpu_var(var)
--#define __raw_get_cpu_var(var)			per_cpu_var(var)
-+#define per_cpu(var, cpu)			(*((void)(cpu), &(var)))
-+#define __get_cpu_var(var)			(var)
-+#define __raw_get_cpu_var(var)			(var)
- #define this_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
- #define __this_cpu_ptr(ptr) this_cpu_ptr(ptr)
- 
-diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
-index 5a5d6ce..ee99f6c 100644
---- a/include/linux/percpu-defs.h
-+++ b/include/linux/percpu-defs.h
-@@ -2,12 +2,6 @@
- #define _LINUX_PERCPU_DEFS_H
- 
- /*
-- * Determine the real variable name from the name visible in the
-- * kernel sources.
-- */
--#define per_cpu_var(var) per_cpu__##var
--
--/*
-  * Base implementations of per-CPU variable declarations and definitions, where
-  * the section in which the variable is to be placed is provided by the
-  * 'sec' argument.  This may be used to affect the parameters governing the
-@@ -56,24 +50,24 @@
-  */
- #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
- 	extern __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;		\
--	extern __PCPU_ATTRS(sec) __typeof__(type) per_cpu__##name
-+	extern __PCPU_ATTRS(sec) __typeof__(type) name
- 
- #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
- 	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
- 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
- 	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
- 	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
--	__typeof__(type) per_cpu__##name
-+	__typeof__(type) name
- #else
- /*
-  * Normal declaration and definition macros.
-  */
- #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
--	extern __PCPU_ATTRS(sec) __typeof__(type) per_cpu__##name
-+	extern __PCPU_ATTRS(sec) __typeof__(type) name
- 
- #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
- 	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES			\
--	__typeof__(type) per_cpu__##name
-+	__typeof__(type) name
- #endif
- 
- /*
-@@ -137,8 +131,8 @@
- /*
-  * Intermodule exports for per-CPU variables.
-  */
--#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
--#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
-+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var)
-+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var)
- 
- 
- #endif /* _LINUX_PERCPU_DEFS_H */
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index cf5efbc..483de0f 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -188,7 +188,7 @@ static inline void *pcpu_lpage_remapped(void *kaddr)
- #ifndef percpu_read
- # define percpu_read(var)						\
-   ({									\
--	typeof(per_cpu_var(var)) __tmp_var__;				\
-+	typeof(var) __tmp_var__;					\
- 	__tmp_var__ = get_cpu_var(var);					\
- 	put_cpu_var(var);						\
- 	__tmp_var__;							\
-@@ -259,8 +259,7 @@ do {									\
- 
- /*
-  * Optimized manipulation for memory allocated through the per cpu
-- * allocator or for addresses of per cpu variables (can be determined
-- * using per_cpu_var(xx).
-+ * allocator or for addresses of per cpu variables.
-  *
-  * These operation guarantee exclusivity of access for other operations
-  * on the *same* processor. The assumption is that per cpu data is only
-diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
-index ee03bba..117f0dd 100644
---- a/include/linux/vmstat.h
-+++ b/include/linux/vmstat.h
-@@ -78,22 +78,22 @@ DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
- 
- static inline void __count_vm_event(enum vm_event_item item)
- {
--	__this_cpu_inc(per_cpu_var(vm_event_states).event[item]);
-+	__this_cpu_inc(vm_event_states.event[item]);
- }
- 
- static inline void count_vm_event(enum vm_event_item item)
- {
--	this_cpu_inc(per_cpu_var(vm_event_states).event[item]);
-+	this_cpu_inc(vm_event_states.event[item]);
- }
- 
- static inline void __count_vm_events(enum vm_event_item item, long delta)
- {
--	__this_cpu_add(per_cpu_var(vm_event_states).event[item], delta);
-+	__this_cpu_add(vm_event_states.event[item], delta);
- }
- 
- static inline void count_vm_events(enum vm_event_item item, long delta)
- {
--	this_cpu_add(per_cpu_var(vm_event_states).event[item], delta);
-+	this_cpu_add(vm_event_states.event[item], delta);
- }
- 
- extern void all_vm_events(unsigned long *);
-diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
-index 9bb5217..0b52175 100644
---- a/kernel/rcutorture.c
-+++ b/kernel/rcutorture.c
-@@ -763,13 +763,13 @@ static void rcu_torture_timer(unsigned long unused)
- 		/* Should not happen, but... */
- 		pipe_count = RCU_TORTURE_PIPE_LEN;
- 	}
--	__this_cpu_inc(per_cpu_var(rcu_torture_count)[pipe_count]);
-+	__this_cpu_inc(rcu_torture_count[pipe_count]);
- 	completed = cur_ops->completed() - completed;
- 	if (completed > RCU_TORTURE_PIPE_LEN) {
- 		/* Should not happen, but... */
- 		completed = RCU_TORTURE_PIPE_LEN;
- 	}
--	__this_cpu_inc(per_cpu_var(rcu_torture_batch)[completed]);
-+	__this_cpu_inc(rcu_torture_batch[completed]);
- 	preempt_enable();
- 	cur_ops->readunlock(idx);
- }
-@@ -818,13 +818,13 @@ rcu_torture_reader(void *arg)
- 			/* Should not happen, but... */
- 			pipe_count = RCU_TORTURE_PIPE_LEN;
- 		}
--		__this_cpu_inc(per_cpu_var(rcu_torture_count)[pipe_count]);
-+		__this_cpu_inc(rcu_torture_count[pipe_count]);
- 		completed = cur_ops->completed() - completed;
- 		if (completed > RCU_TORTURE_PIPE_LEN) {
- 			/* Should not happen, but... */
- 			completed = RCU_TORTURE_PIPE_LEN;
- 		}
--		__this_cpu_inc(per_cpu_var(rcu_torture_batch)[completed]);
-+		__this_cpu_inc(rcu_torture_batch[completed]);
- 		preempt_enable();
- 		cur_ops->readunlock(idx);
- 		schedule();
-diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
-index eac6875..667ba80 100644
---- a/kernel/trace/trace.c
-+++ b/kernel/trace/trace.c
-@@ -91,12 +91,12 @@ DEFINE_PER_CPU(int, ftrace_cpu_disabled);
- static inline void ftrace_disable_cpu(void)
- {
- 	preempt_disable();
--	__this_cpu_inc(per_cpu_var(ftrace_cpu_disabled));
-+	__this_cpu_inc(ftrace_cpu_disabled);
- }
- 
- static inline void ftrace_enable_cpu(void)
- {
--	__this_cpu_dec(per_cpu_var(ftrace_cpu_disabled));
-+	__this_cpu_dec(ftrace_cpu_disabled);
- 	preempt_enable();
- }
- 
-@@ -1089,7 +1089,7 @@ trace_function(struct trace_array *tr,
- 	struct ftrace_entry *entry;
- 
- 	/* If we are reading the ring buffer, don't trace */
--	if (unlikely(__this_cpu_read(per_cpu_var(ftrace_cpu_disabled))))
-+	if (unlikely(__this_cpu_read(ftrace_cpu_disabled)))
- 		return;
- 
- 	event = trace_buffer_lock_reserve(buffer, TRACE_FN, sizeof(*entry),
-diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
-index b1342c5..9d976f3 100644
---- a/kernel/trace/trace_functions_graph.c
-+++ b/kernel/trace/trace_functions_graph.c
-@@ -187,7 +187,7 @@ static int __trace_graph_entry(struct trace_array *tr,
- 	struct ring_buffer *buffer = tr->buffer;
- 	struct ftrace_graph_ent_entry *entry;
- 
--	if (unlikely(__this_cpu_read(per_cpu_var(ftrace_cpu_disabled))))
-+	if (unlikely(__this_cpu_read(ftrace_cpu_disabled)))
- 		return 0;
- 
- 	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT,
-@@ -251,7 +251,7 @@ static void __trace_graph_return(struct trace_array *tr,
- 	struct ring_buffer *buffer = tr->buffer;
- 	struct ftrace_graph_ret_entry *entry;
- 
--	if (unlikely(__this_cpu_read(per_cpu_var(ftrace_cpu_disabled))))
-+	if (unlikely(__this_cpu_read(ftrace_cpu_disabled)))
- 		return;
- 
- 	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RET,
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0004-percpu-make-access-macros-universal.patch b/patches/v2.6.33/0004-percpu-make-access-macros-universal.patch
deleted file mode 100644
index dad059b..0000000
--- a/patches/v2.6.33/0004-percpu-make-access-macros-universal.patch
+++ /dev/null
@@ -1,75 +0,0 @@
-From 0f1950c0564935b58885a528ac81c6e743d1eaf6 Mon Sep 17 00:00:00 2001
-From: Tejun Heo <tj@kernel.org>
-Date: Thu, 29 Oct 2009 22:34:15 +0900
-Subject: [PATCH 4/7] percpu: make access macros universal
-
-Now that per_cpu__ prefix is gone, there's no distinction between
-static and dynamic percpu variables.  Make get_cpu_var() take dynamic
-percpu variables and ensure that all macros have parentheses around
-the parameter evaluation and evaluate the variable parameter only once
-such that any expression which evaluates to percpu address can be used
-safely.
-
-Signed-off-by: Tejun Heo <tj@kernel.org>
----
- include/linux/percpu.h | 23 ++++++++++++++---------
- 1 file changed, 14 insertions(+), 9 deletions(-)
-
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index 483de0f..ded03d0 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -27,10 +27,13 @@
-  * we force a syntax error here if it isn't.
-  */
- #define get_cpu_var(var) (*({				\
--	extern int simple_identifier_##var(void);	\
- 	preempt_disable();				\
- 	&__get_cpu_var(var); }))
--#define put_cpu_var(var) preempt_enable()
-+
-+#define put_cpu_var(var) do {				\
-+	(void)(var);					\
-+	preempt_enable();				\
-+} while (0)
- 
- #ifdef CONFIG_SMP
- 
-@@ -188,17 +191,19 @@ static inline void *pcpu_lpage_remapped(void *kaddr)
- #ifndef percpu_read
- # define percpu_read(var)						\
-   ({									\
--	typeof(var) __tmp_var__;					\
--	__tmp_var__ = get_cpu_var(var);					\
--	put_cpu_var(var);						\
--	__tmp_var__;							\
-+	typeof(var) *pr_ptr__ = &(var);					\
-+	typeof(var) pr_ret__;						\
-+	pr_ret__ = get_cpu_var(*pr_ptr__);				\
-+	put_cpu_var(*pr_ptr__);						\
-+	pr_ret__;							\
-   })
- #endif
- 
- #define __percpu_generic_to_op(var, val, op)				\
- do {									\
--	get_cpu_var(var) op val;					\
--	put_cpu_var(var);						\
-+	typeof(var) *pgto_ptr__ = &(var);				\
-+	get_cpu_var(*pgto_ptr__) op val;				\
-+	put_cpu_var(*pgto_ptr__);					\
- } while (0)
- 
- #ifndef percpu_write
-@@ -310,7 +315,7 @@ do {									\
- #define _this_cpu_generic_to_op(pcp, val, op)				\
- do {									\
- 	preempt_disable();						\
--	*__this_cpu_ptr(&pcp) op val;					\
-+	*__this_cpu_ptr(&(pcp)) op val;					\
- 	preempt_enable();						\
- } while (0)
- 
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0005-percpu-add-__percpu-for-sparse.patch b/patches/v2.6.33/0005-percpu-add-__percpu-for-sparse.patch
deleted file mode 100644
index ebb31eb..0000000
--- a/patches/v2.6.33/0005-percpu-add-__percpu-for-sparse.patch
+++ /dev/null
@@ -1,124 +0,0 @@
-From 9769cf89b2c71d303744da1ebb7f426f9ed7ea07 Mon Sep 17 00:00:00 2001
-From: Rusty Russell <rusty@rustcorp.com.au>
-Date: Thu, 29 Oct 2009 22:34:15 +0900
-Subject: [PATCH 5/7] percpu: add __percpu for sparse.
-
-We have to make __kernel "__attribute__((address_space(0)))" so we can
-cast to it.
-
-tj: * put_cpu_var() update.
-
-    * Annotations added to dynamic allocator interface.
-
-Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
-Cc: Al Viro <viro@zeniv.linux.org.uk>
-Signed-off-by: Tejun Heo <tj@kernel.org>
----
- include/asm-generic/percpu.h |  4 +++-
- include/linux/compiler.h     |  2 +-
- include/linux/percpu-defs.h  |  2 +-
- include/linux/percpu.h       | 18 +++++++++++-------
- 4 files changed, 16 insertions(+), 10 deletions(-)
-
-diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
-index ca6f049..fded453 100644
---- a/include/asm-generic/percpu.h
-+++ b/include/asm-generic/percpu.h
-@@ -41,7 +41,9 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
-  * Only S390 provides its own means of moving the pointer.
-  */
- #ifndef SHIFT_PERCPU_PTR
--#define SHIFT_PERCPU_PTR(__p, __offset)	RELOC_HIDE((__p), (__offset))
-+/* Weird cast keeps both GCC and sparse happy. */
-+#define SHIFT_PERCPU_PTR(__p, __offset)				\
-+	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
- #endif
- 
- /*
-diff --git a/include/linux/compiler.h b/include/linux/compiler.h
-index 188fcae..a5a472b 100644
---- a/include/linux/compiler.h
-+++ b/include/linux/compiler.h
-@@ -5,7 +5,7 @@
- 
- #ifdef __CHECKER__
- # define __user		__attribute__((noderef, address_space(1)))
--# define __kernel	/* default address space */
-+# define __kernel	__attribute__((address_space(0)))
- # define __safe		__attribute__((safe))
- # define __force	__attribute__((force))
- # define __nocast	__attribute__((nocast))
-diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
-index ee99f6c..0fa0cb5 100644
---- a/include/linux/percpu-defs.h
-+++ b/include/linux/percpu-defs.h
-@@ -12,7 +12,7 @@
-  * that section.
-  */
- #define __PCPU_ATTRS(sec)						\
--	__attribute__((section(PER_CPU_BASE_SECTION sec)))		\
-+	__percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))	\
- 	PER_CPU_ATTRIBUTES
- 
- #define __PCPU_DUMMY_ATTRS						\
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index ded03d0..a20a5b9 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -30,8 +30,12 @@
- 	preempt_disable();				\
- 	&__get_cpu_var(var); }))
- 
-+/*
-+ * The weird & is necessary because sparse considers (void)(var) to be
-+ * a direct dereference of percpu variable (var).
-+ */
- #define put_cpu_var(var) do {				\
--	(void)(var);					\
-+	(void)&(var);					\
- 	preempt_enable();				\
- } while (0)
- 
-@@ -130,9 +134,9 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
-  */
- #define per_cpu_ptr(ptr, cpu)	SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)))
- 
--extern void *__alloc_reserved_percpu(size_t size, size_t align);
--extern void *__alloc_percpu(size_t size, size_t align);
--extern void free_percpu(void *__pdata);
-+extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
-+extern void __percpu *__alloc_percpu(size_t size, size_t align);
-+extern void free_percpu(void __percpu *__pdata);
- extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
- 
- #ifndef CONFIG_HAVE_SETUP_PER_CPU_AREA
-@@ -143,7 +147,7 @@ extern void __init setup_per_cpu_areas(void);
- 
- #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
- 
--static inline void *__alloc_percpu(size_t size, size_t align)
-+static inline void __percpu *__alloc_percpu(size_t size, size_t align)
- {
- 	/*
- 	 * Can't easily make larger alignment work with kmalloc.  WARN
-@@ -154,7 +158,7 @@ static inline void *__alloc_percpu(size_t size, size_t align)
- 	return kzalloc(size, GFP_KERNEL);
- }
- 
--static inline void free_percpu(void *p)
-+static inline void free_percpu(void __percpu *p)
- {
- 	kfree(p);
- }
-@@ -174,7 +178,7 @@ static inline void *pcpu_lpage_remapped(void *kaddr)
- #endif /* CONFIG_SMP */
- 
- #define alloc_percpu(type)	\
--	(typeof(type) *)__alloc_percpu(sizeof(type), __alignof__(type))
-+	(typeof(type) __percpu *)__alloc_percpu(sizeof(type), __alignof__(type))
- 
- /*
-  * Optional methods for optimized non-lvalue per-cpu variable access.
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0006-percpu-make-accessors-check-for-percpu-pointer-in-sp.patch b/patches/v2.6.33/0006-percpu-make-accessors-check-for-percpu-pointer-in-sp.patch
deleted file mode 100644
index 5aaae3c..0000000
--- a/patches/v2.6.33/0006-percpu-make-accessors-check-for-percpu-pointer-in-sp.patch
+++ /dev/null
@@ -1,99 +0,0 @@
-From 4e386449e2f80f488b73ccd5fcc24646e519e1cf Mon Sep 17 00:00:00 2001
-From: Tejun Heo <tj@kernel.org>
-Date: Thu, 29 Oct 2009 22:34:15 +0900
-Subject: [PATCH 6/7] percpu: make accessors check for percpu pointer in sparse
-
-The previous patch made sparse warn about percpu variables being used
-directly without going through percpu accessors.  This patch
-implements the other half - checking whether non percpu variable is
-passed into percpu accessors.
-
-Signed-off-by: Tejun Heo <tj@kernel.org>
-Cc: Rusty Russell <rusty@rustcorp.com.au>
-Cc: Al Viro <viro@zeniv.linux.org.uk>
----
- include/asm-generic/percpu.h |  6 ++++--
- include/linux/percpu-defs.h  | 20 ++++++++++++++++++--
- include/linux/percpu.h       |  2 ++
- 3 files changed, 24 insertions(+), 4 deletions(-)
-
-diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
-index fded453..04f91c2 100644
---- a/include/asm-generic/percpu.h
-+++ b/include/asm-generic/percpu.h
-@@ -42,8 +42,10 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
-  */
- #ifndef SHIFT_PERCPU_PTR
- /* Weird cast keeps both GCC and sparse happy. */
--#define SHIFT_PERCPU_PTR(__p, __offset)				\
--	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
-+#define SHIFT_PERCPU_PTR(__p, __offset)	({				\
-+	__verify_pcpu_ptr((__p));					\
-+	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset)); \
-+})
- #endif
- 
- /*
-diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
-index 0fa0cb5..1fa36eb 100644
---- a/include/linux/percpu-defs.h
-+++ b/include/linux/percpu-defs.h
-@@ -19,6 +19,16 @@
- 	__attribute__((section(".discard"), unused))
- 
- /*
-+ * Macro which verifies @ptr is a percpu pointer without evaluating
-+ * @ptr.  This is to be used in percpu accessors to verify that the
-+ * input parameter is a percpu pointer.
-+ */
-+#define __verify_pcpu_ptr(ptr)	do {					\
-+	void __percpu *__vpp_verify = (typeof(ptr))NULL;		\
-+	(void)__vpp_verify;						\
-+} while (0)
-+
-+/*
-  * s390 and alpha modules require percpu variables to be defined as
-  * weak to force the compiler to generate GOT based external
-  * references for them.  This is necessary because percpu sections
-@@ -129,10 +139,16 @@
- 	__aligned(PAGE_SIZE)
- 
- /*
-- * Intermodule exports for per-CPU variables.
-+ * Intermodule exports for per-CPU variables.  sparse forgets about
-+ * address space across EXPORT_SYMBOL(), change EXPORT_SYMBOL() to
-+ * noop if __CHECKER__.
-  */
-+#ifndef __CHECKER__
- #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var)
- #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var)
--
-+#else
-+#define EXPORT_PER_CPU_SYMBOL(var)
-+#define EXPORT_PER_CPU_SYMBOL_GPL(var)
-+#endif
- 
- #endif /* _LINUX_PERCPU_DEFS_H */
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index a20a5b9..a93e5bf 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -243,6 +243,7 @@ extern void __bad_size_call_parameter(void);
- 
- #define __pcpu_size_call_return(stem, variable)				\
- ({	typeof(variable) pscr_ret__;					\
-+	__verify_pcpu_ptr(&(variable));					\
- 	switch(sizeof(variable)) {					\
- 	case 1: pscr_ret__ = stem##1(variable);break;			\
- 	case 2: pscr_ret__ = stem##2(variable);break;			\
-@@ -256,6 +257,7 @@ extern void __bad_size_call_parameter(void);
- 
- #define __pcpu_size_call(stem, variable, ...)				\
- do {									\
-+	__verify_pcpu_ptr(&(variable));					\
- 	switch(sizeof(variable)) {					\
- 		case 1: stem##1(variable, __VA_ARGS__);break;		\
- 		case 2: stem##2(variable, __VA_ARGS__);break;		\
--- 
-2.1.4
-
diff --git a/patches/v2.6.33/0007-percpu-handle-__percpu-notations-in-UP-accessors.patch b/patches/v2.6.33/0007-percpu-handle-__percpu-notations-in-UP-accessors.patch
deleted file mode 100644
index 0753474..0000000
--- a/patches/v2.6.33/0007-percpu-handle-__percpu-notations-in-UP-accessors.patch
+++ /dev/null
@@ -1,58 +0,0 @@
-From 0cb1408852589280d204904c2b3145ea64784128 Mon Sep 17 00:00:00 2001
-From: Namhyung Kim <namhyung@gmail.com>
-Date: Sat, 7 Aug 2010 03:26:23 +0900
-Subject: [PATCH 7/7] percpu: handle __percpu notations in UP accessors
-
-UP accessors didn't take care of __percpu notations leading to a lot
-of spurious sparse warnings on UP configurations.  Fix it.
-
-Signed-off-by: Namhyung Kim <namhyung@gmail.com>
-Signed-off-by: Tejun Heo <tj@kernel.org>
-Signed-off-by: Sven Eckelmann <sven@narfation.org>
----
- include/asm-generic/percpu.h | 15 ++++++++++-----
- include/linux/percpu.h       |  2 +-
- 2 files changed, 11 insertions(+), 6 deletions(-)
-
-diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
-index 04f91c2..b83d4e5 100644
---- a/include/asm-generic/percpu.h
-+++ b/include/asm-generic/percpu.h
-@@ -70,11 +70,16 @@ extern void setup_per_cpu_areas(void);
- 
- #else /* ! SMP */
- 
--#define per_cpu(var, cpu)			(*((void)(cpu), &(var)))
--#define __get_cpu_var(var)			(var)
--#define __raw_get_cpu_var(var)			(var)
--#define this_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
--#define __this_cpu_ptr(ptr) this_cpu_ptr(ptr)
-+#define VERIFY_PERCPU_PTR(__p) ({			\
-+	__verify_pcpu_ptr((__p));			\
-+	(typeof(*(__p)) __kernel __force *)(__p);	\
-+})
-+
-+#define per_cpu(var, cpu)	(*((void)(cpu), VERIFY_PERCPU_PTR(&(var))))
-+#define __get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-+#define __raw_get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-+#define this_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
-+#define __this_cpu_ptr(ptr)	this_cpu_ptr(ptr)
- 
- #endif	/* SMP */
- 
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index a93e5bf..94bbc04d1 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -145,7 +145,7 @@ extern void __init setup_per_cpu_areas(void);
- 
- #else /* CONFIG_SMP */
- 
--#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
-+#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR((ptr)); })
- 
- static inline void __percpu *__alloc_percpu(size_t size, size_t align)
- {
--- 
-2.1.4
-
diff --git a/patches/v2.6.34/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch b/patches/v2.6.34/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch
deleted file mode 100644
index 0d40dc6..0000000
--- a/patches/v2.6.34/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch
+++ /dev/null
@@ -1,58 +0,0 @@
-From a9bfdb4fd3c05767922a3a3bcb64d12c834a7fba Mon Sep 17 00:00:00 2001
-From: Namhyung Kim <namhyung@gmail.com>
-Date: Sat, 7 Aug 2010 03:26:23 +0900
-Subject: [PATCH] percpu: handle __percpu notations in UP accessors
-
-UP accessors didn't take care of __percpu notations leading to a lot
-of spurious sparse warnings on UP configurations.  Fix it.
-
-Signed-off-by: Namhyung Kim <namhyung@gmail.com>
-Signed-off-by: Tejun Heo <tj@kernel.org>
-Signed-off-by: Sven Eckelmann <sven@narfation.org>
----
- include/asm-generic/percpu.h |   15 ++++++++++-----
- include/linux/percpu.h       |    2 +-
- 2 files changed, 11 insertions(+), 6 deletions(-)
-
-diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
-index 04f91c2..b83d4e5 100644
---- a/include/asm-generic/percpu.h
-+++ b/include/asm-generic/percpu.h
-@@ -70,11 +70,16 @@ extern void setup_per_cpu_areas(void);
- 
- #else /* ! SMP */
- 
--#define per_cpu(var, cpu)			(*((void)(cpu), &(var)))
--#define __get_cpu_var(var)			(var)
--#define __raw_get_cpu_var(var)			(var)
--#define this_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
--#define __this_cpu_ptr(ptr) this_cpu_ptr(ptr)
-+#define VERIFY_PERCPU_PTR(__p) ({			\
-+	__verify_pcpu_ptr((__p));			\
-+	(typeof(*(__p)) __kernel __force *)(__p);	\
-+})
-+
-+#define per_cpu(var, cpu)	(*((void)(cpu), VERIFY_PERCPU_PTR(&(var))))
-+#define __get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-+#define __raw_get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-+#define this_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
-+#define __this_cpu_ptr(ptr)	this_cpu_ptr(ptr)
- 
- #endif	/* SMP */
- 
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index d3a38d6..bc36301 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -143,7 +143,7 @@ extern void __init setup_per_cpu_areas(void);
- 
- #else /* CONFIG_SMP */
- 
--#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
-+#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR((ptr)); })
- 
- /* can't distinguish from other static vars, always false */
- static inline bool is_kernel_percpu_address(unsigned long addr)
--- 
-1.7.10
-
diff --git a/patches/v2.6.34/0002-missing-inline-keyword-for-static-function-in-linux-.patch b/patches/v2.6.34/0002-missing-inline-keyword-for-static-function-in-linux-.patch
deleted file mode 100644
index 306c49a..0000000
--- a/patches/v2.6.34/0002-missing-inline-keyword-for-static-function-in-linux-.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From b7af370026f5accdaaaad5b6dd1605227060c9c4 Mon Sep 17 00:00:00 2001
-From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Date: Sat, 14 Aug 2010 15:02:44 +0200
-Subject: [PATCH] missing inline keyword for static function in
- linux/dmaengine.h
-
-Add a missing inline keyword for static function in linux/dmaengine.h to
-avoid duplicate symbol definitions.
-
-Signed-off-by: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Signed-off-by: Dan Williams <dan.j.williams@intel.com>
----
- include/linux/dmaengine.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
-index 5204f01..57d2b76 100644
---- a/include/linux/dmaengine.h
-+++ b/include/linux/dmaengine.h
-@@ -477,7 +477,7 @@ static inline bool dma_dev_has_pq_continue(struct dma_device *dma)
- 	return (dma->max_pq & DMA_HAS_PQ_CONTINUE) == DMA_HAS_PQ_CONTINUE;
- }
- 
--static unsigned short dma_dev_to_maxpq(struct dma_device *dma)
-+static inline unsigned short dma_dev_to_maxpq(struct dma_device *dma)
- {
- 	return dma->max_pq & ~DMA_HAS_PQ_CONTINUE;
- }
--- 
-2.1.4
-
diff --git a/patches/v2.6.35/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch b/patches/v2.6.35/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch
deleted file mode 100644
index b89bcbc..0000000
--- a/patches/v2.6.35/0001-percpu-handle-__percpu-notations-in-UP-accessors.patch
+++ /dev/null
@@ -1,58 +0,0 @@
-From 52570a9ff2201945f529e910f68c7f30554b8ec1 Mon Sep 17 00:00:00 2001
-From: Namhyung Kim <namhyung@gmail.com>
-Date: Sat, 7 Aug 2010 03:26:23 +0900
-Subject: [PATCH] percpu: handle __percpu notations in UP accessors
-
-UP accessors didn't take care of __percpu notations leading to a lot
-of spurious sparse warnings on UP configurations.  Fix it.
-
-Signed-off-by: Namhyung Kim <namhyung@gmail.com>
-Signed-off-by: Tejun Heo <tj@kernel.org>
-Signed-off-by: Sven Eckelmann <sven@narfation.org>
----
- include/asm-generic/percpu.h |   15 ++++++++++-----
- include/linux/percpu.h       |    2 +-
- 2 files changed, 11 insertions(+), 6 deletions(-)
-
-diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
-index b5043a9..08923b6 100644
---- a/include/asm-generic/percpu.h
-+++ b/include/asm-generic/percpu.h
-@@ -70,11 +70,16 @@ extern void setup_per_cpu_areas(void);
- 
- #else /* ! SMP */
- 
--#define per_cpu(var, cpu)			(*((void)(cpu), &(var)))
--#define __get_cpu_var(var)			(var)
--#define __raw_get_cpu_var(var)			(var)
--#define this_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
--#define __this_cpu_ptr(ptr) this_cpu_ptr(ptr)
-+#define VERIFY_PERCPU_PTR(__p) ({			\
-+	__verify_pcpu_ptr((__p));			\
-+	(typeof(*(__p)) __kernel __force *)(__p);	\
-+})
-+
-+#define per_cpu(var, cpu)	(*((void)(cpu), VERIFY_PERCPU_PTR(&(var))))
-+#define __get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-+#define __raw_get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-+#define this_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
-+#define __this_cpu_ptr(ptr)	this_cpu_ptr(ptr)
- 
- #endif	/* SMP */
- 
-diff --git a/include/linux/percpu.h b/include/linux/percpu.h
-index d3a38d6..bc36301 100644
---- a/include/linux/percpu.h
-+++ b/include/linux/percpu.h
-@@ -143,7 +143,7 @@ extern void __init setup_per_cpu_areas(void);
- 
- #else /* CONFIG_SMP */
- 
--#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
-+#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR((ptr)); })
- 
- /* can't distinguish from other static vars, always false */
- static inline bool is_kernel_percpu_address(unsigned long addr)
--- 
-1.7.10
-
diff --git a/patches/v2.6.35/0002-missing-inline-keyword-for-static-function-in-linux-.patch b/patches/v2.6.35/0002-missing-inline-keyword-for-static-function-in-linux-.patch
deleted file mode 100644
index 306c49a..0000000
--- a/patches/v2.6.35/0002-missing-inline-keyword-for-static-function-in-linux-.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From b7af370026f5accdaaaad5b6dd1605227060c9c4 Mon Sep 17 00:00:00 2001
-From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Date: Sat, 14 Aug 2010 15:02:44 +0200
-Subject: [PATCH] missing inline keyword for static function in
- linux/dmaengine.h
-
-Add a missing inline keyword for static function in linux/dmaengine.h to
-avoid duplicate symbol definitions.
-
-Signed-off-by: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
-Signed-off-by: Dan Williams <dan.j.williams@intel.com>
----
- include/linux/dmaengine.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
-index 5204f01..57d2b76 100644
---- a/include/linux/dmaengine.h
-+++ b/include/linux/dmaengine.h
-@@ -477,7 +477,7 @@ static inline bool dma_dev_has_pq_continue(struct dma_device *dma)
- 	return (dma->max_pq & DMA_HAS_PQ_CONTINUE) == DMA_HAS_PQ_CONTINUE;
- }
- 
--static unsigned short dma_dev_to_maxpq(struct dma_device *dma)
-+static inline unsigned short dma_dev_to_maxpq(struct dma_device *dma)
- {
- 	return dma->max_pq & ~DMA_HAS_PQ_CONTINUE;
- }
--- 
-2.1.4
-
-- 
2.1.4

