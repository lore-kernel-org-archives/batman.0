From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri,  6 Feb 2009 17:56:11 +0100
Message-Id: <1233939371-23629-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Introduce set/get functions for /proc files
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

get_integer_file can be used to get an integer from the beginning of a
file. It does the same as every other get_* function in linux/kernel.c
has done before, but introduced extra error checking for fscanf to
deal with the undefined behaviour of it in error cases in c89.

It fixes also the problems that in future architectures with
sizeof(int) > 4 an invalid write would happen when fscanf tries to write
it's results into the target or that on big endian architectures with
sizof(int) != 4 the result is complete different than the expected one
when the content of the file is not 0.

set_integer_file does the same for writing a specific integer to the
file and thus resolve the problem of invalid read on architectures with
sizof(int) > 4 and wrong file content on big endian systems with
sizof(int) != 4.

As side effect the probability to get attacked by a goto-raptor was
reduced by the factor 1.08.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/kernel.c |   89 ++++++++++++++++++++++---------------------------
 1 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/batman/linux/kernel.c b/batman/linux/kernel.c
index 0595899..203fb33 100644
--- a/batman/linux/kernel.c
+++ b/batman/linux/kernel.c
@@ -27,6 +27,7 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <inttypes.h>
 
 #include "../os.h"
 #include "../batman.h"
@@ -36,9 +37,41 @@
 
 
 
+static int get_integer_file(const char* filename)
+{
+	FILE *f;
+	int32_t integer = 0;
+	int n;
+
+	if((f = fopen(filename, "r")) == NULL)
+		return 0;
+
+	n = fscanf(f, "%"SCNd32, &integer);
+	fclose(f);
+
+	if (n == 0 || n == EOF)
+		integer = 0;
+
+	return integer;
+}
+
+
+
+static void set_integer_file(const char* filename, int32_t integer)
+{
+	FILE *f;
+
+	if ((f = fopen(filename, "w")) == NULL)
+		return;
+
+	fprintf(f, "%"PRId32, integer);
+	fclose(f);
+}
+
+
+
 void set_rp_filter(int32_t state, char* dev)
 {
-	FILE *f;
 	char filename[100], *colon_ptr;
 
 	/* if given interface is an alias use parent interface */
@@ -46,14 +79,8 @@ void set_rp_filter(int32_t state, char* dev)
 		*colon_ptr = '\0';
 
 	sprintf( filename, "/proc/sys/net/ipv4/conf/%s/rp_filter", dev);
+	set_integer_file(filename, state);
 
-	if((f = fopen(filename, "w")) == NULL)
-		goto end;
-
-	fprintf(f, "%d", state);
-	fclose(f);
-
-end:
 	if ( colon_ptr != NULL )
 		*colon_ptr = ':';
 }
@@ -62,7 +89,6 @@ end:
 
 int32_t get_rp_filter(char *dev)
 {
-	FILE *f;
 	int32_t state = 0;
 	char filename[100], *colon_ptr;
 
@@ -71,14 +97,8 @@ int32_t get_rp_filter(char *dev)
 		*colon_ptr = '\0';
 
 	sprintf( filename, "/proc/sys/net/ipv4/conf/%s/rp_filter", dev);
+	state = get_integer_file(filename);
 
-	if((f = fopen(filename, "r")) == NULL)
-		goto end;
-
-	fscanf(f, "%d", &state);
-	fclose(f);
-
-end:
 	if ( colon_ptr != NULL )
 		*colon_ptr = ':';
 
@@ -89,7 +109,6 @@ end:
 
 void set_send_redirects( int32_t state, char* dev ) {
 
-	FILE *f;
 	char filename[100], *colon_ptr;
 
 	/* if given interface is an alias use parent interface */
@@ -97,14 +116,8 @@ void set_send_redirects( int32_t state, char* dev ) {
 		*colon_ptr = '\0';
 
 	sprintf( filename, "/proc/sys/net/ipv4/conf/%s/send_redirects", dev);
+	set_integer_file(filename, state);
 
-	if((f = fopen(filename, "w")) == NULL)
-		goto end;
-
-	fprintf(f, "%d", state);
-	fclose(f);
-
-end:
 	if ( colon_ptr != NULL )
 		*colon_ptr = ':';
 
@@ -114,7 +127,6 @@ end:
 
 int32_t get_send_redirects( char *dev ) {
 
-	FILE *f;
 	int32_t state = 0;
 	char filename[100], *colon_ptr;
 
@@ -123,14 +135,8 @@ int32_t get_send_redirects( char *dev ) {
 		*colon_ptr = '\0';
 
 	sprintf( filename, "/proc/sys/net/ipv4/conf/%s/send_redirects", dev);
+	state = get_integer_file(filename);
 
-	if((f = fopen(filename, "r")) == NULL)
-		goto end;
-
-	fscanf(f, "%d", &state);
-	fclose(f);
-
-end:
 	if ( colon_ptr != NULL )
 		*colon_ptr = ':';
 
@@ -142,29 +148,14 @@ end:
 
 void set_forwarding(int32_t state)
 {
-	FILE *f;
-
-	if((f = fopen("/proc/sys/net/ipv4/ip_forward", "w")) == NULL)
-		return;
-
-	fprintf(f, "%d", state);
-	fclose(f);
+	set_integer_file("/proc/sys/net/ipv4/ip_forward", state);
 }
 
 
 
 int32_t get_forwarding(void)
 {
-	FILE *f;
-	int32_t state = 0;
-
-	if((f = fopen("/proc/sys/net/ipv4/ip_forward", "r")) == NULL)
-		return 0;
-
-	fscanf(f, "%d", &state);
-	fclose(f);
-
-	return state;
+	return get_integer_file("/proc/sys/net/ipv4/ip_forward");
 }
 
 
-- 
1.6.1.2.549.g547e

