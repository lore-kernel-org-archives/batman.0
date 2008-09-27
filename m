Date: Sat, 27 Sep 2008 20:27:59 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080927182759.GA14446@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Mark not returning functions with
	__noreturn__
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

The gcc feature for functions that will definitely not return should help the
static analyzer and the optimizer slightly. See
http://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html#Function-Attributes
for more informations.
---
 batman/os.h          |    8 +++++++-
 batman/posix/posix.c |    4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/batman/os.h b/batman/os.h
index b1e9423..d29ebf1 100644
--- a/batman/os.h
+++ b/batman/os.h
@@ -22,6 +22,12 @@
 
 #include "batman.h"
 
+#ifdef __GNUC_MINOR__
+#define NO_RETURN  __attribute__ ((__noreturn__))
+#else
+#define NO_RETURN
+#endif
+
 uint32_t get_time_msec(void);
 uint64_t get_time_msec64(void);
 int32_t rand_num( int32_t limit );
@@ -34,7 +40,7 @@ void add_del_hna( struct orig_node *orig_node, int8_t del );
 int8_t is_aborted();
 void handler( int32_t sig );
 void segmentation_fault( int32_t sig );
-void restore_and_exit( uint8_t is_sigsegv );
+void restore_and_exit( uint8_t is_sigsegv ) NO_RETURN;
 
 /* route.c */
 void add_del_route( uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, char *dev, uint8_t rt_table, int8_t route_type, int8_t del );
diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index b94ceae..432b45f 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -499,6 +499,8 @@ void restore_and_exit( uint8_t is_sigsegv ) {
 
 	if ( !is_sigsegv )
 		exit(EXIT_FAILURE);
+	else
+		raise( SIGSEGV );
 
 }
 
@@ -515,8 +517,6 @@ void segmentation_fault( int32_t sig ) {
 
 	restore_and_exit(1);
 
-	raise( SIGSEGV );
-
 }
 
 
-- 
1.6.0.1


