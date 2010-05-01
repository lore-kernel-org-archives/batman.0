Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  1 May 2010 15:10:10 +0200
Message-Id: <1272719410-406-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-1-git-send-email-andrew@lunn.ch>
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: include cleanup: Update
	gfp.h and slab.h includes to prepare for breaking implicit...
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
To: lindner_marek@yahoo.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

include cleanup: Update gfp.h and slab.h includes to prepare for breaking implicit slab.h inclusion from percpu.h

percpu.h is included by sched.h and module.h and thus ends up being
included when building most .c files.  percpu.h includes slab.h which
in turn includes gfp.h making everything defined by the two files
universally available and complicating inclusion dependencies.

percpu.h -> slab.h dependency is about to be removed.  Prepare for
this change by updating users of gfp and slab facilities include those
headers directly instead of assuming availability.  As this conversion
needs to touch large number of source files, the following script is
used as the basis of conversion.

  http://userweb.kernel.org/~tj/misc/slabh-sweep.py

The script does the followings.

* Scan files for gfp and slab usages and update includes such that
  only the necessary includes are there.  ie. if only gfp is used,
  gfp.h, if slab is used, slab.h.

* When the script inserts a new include, it looks at the include
  blocks and try to put the new include such that its order conforms
  to its surrounding.  It's put in the include block which contains
  core kernel includes, in the same order that the rest are ordered -
  alphabetical, Christmas tree, rev-Xmas-tree or at the end if there
  doesn't seem to be any matching order.

* If the script can't find a place to put a new include (mostly
  because the file doesn't have fitting include block), it prints out
  an error message indicating which .h file needs to be added to the
  file.

The conversion was done in the following steps.

1. The initial automatic conversion of all .c files updated slightly
   over 4000 files, deleting around 700 includes and adding ~480 gfp.h
   and ~3000 slab.h inclusions.  The script emitted errors for ~400
   files.

2. Each error was manually checked.  Some didn't need the inclusion,
   some needed manual addition while adding it to implementation .h or
   embedding .c file was more appropriate for others.  This step added
   inclusions to around 150 files.

3. The script was run again and the output was compared to the edits
   from #2 to make sure no file was left behind.

4. Several build tests were done and a couple of problems were fixed.
   e.g. lib/decompress_*.c used malloc/free() wrappers around slab
   APIs requiring slab.h to be added manually.

5. The script was run on all .h files but without automatically
   editing them as sprinkling gfp.h and slab.h inclusions around .h
   files could easily lead to inclusion dependency hell.  Most gfp.h
   inclusion directives were ignored as stuff from gfp.h was usually
   wildly available and often used in preprocessor macros.  Each
   slab.h inclusion directive was examined and added manually as
   necessary.

6. percpu.h was updated not to include slab.h.

7. Build test were done on the following configurations and failures
   were fixed.  CONFIG_GCOV_KERNEL was turned off for all tests (as my
   distributed build env didn't work with gcov compiles) and a few
   more options had to be turned off depending on archs to make things
   build (like ipr on powerpc/64 which failed due to missing writeq).

   * x86 and x86_64 UP and SMP allmodconfig and a custom test config.
   * powerpc and powerpc64 SMP allmodconfig
   * sparc and sparc64 SMP allmodconfig
   * ia64 SMP allmodconfig
   * s390 SMP allmodconfig
   * alpha SMP allmodconfig
   * um on x86_64 SMP allmodconfig

8. percpu.h modifications were reverted so that it could be applied as
   a separate patch and serve as bisection point.

Given the fact that I had only a couple of failures from tests on step
6, I'm fairly confident about the coverage of this conversion patch.
If there is a breakage, it's likely to be something in one of the arch
headers which should be easily discoverable easily on most builds of
the specific arch.

Signed-off-by: Tejun Heo <tj@kernel.org>
Guess-its-ok-by: Christoph Lameter <cl@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 device.c         |    3 +--
 main.h           |    1 +
 soft-interface.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/device.c b/device.c
index 5f7655b..b2ecba2 100644
--- a/device.c
+++ b/device.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/slab.h>
 #include "main.h"
 #include "device.h"
 #include "send.h"
@@ -27,8 +28,6 @@
 #include "hash.h"
 #include "hard-interface.h"
 
-#include "compat.h"
-
 static struct class *batman_class;
 
 static int Major;	/* Major number assigned to our device driver */
diff --git a/main.h b/main.h
index 55e2214..6749ce0 100644
--- a/main.h
+++ b/main.h
@@ -113,6 +113,7 @@ extern int bat_debug_type(int type);
 #include <linux/kthread.h>	/* kernel threads */
 #include <linux/pkt_sched.h>	/* schedule types */
 #include <linux/workqueue.h>	/* workqueue */
+#include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
 #include "types.h"
diff --git a/soft-interface.c b/soft-interface.c
index 37a1f44..c3b5288 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -26,9 +26,9 @@
 #include "translation-table.h"
 #include "types.h"
 #include "hash.h"
+#include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
-#include "compat.h"
 
 static uint16_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 				  * broadcast storms */
-- 
1.7.1

