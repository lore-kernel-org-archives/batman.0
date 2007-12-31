From: Acinonyx <acinonyxs@yahoo.gr>
Date: Mon, 31 Dec 2007 02:01:49 +0200
References: <200712271148.14121.holger@layer-acht.org>
	<20071227122037.GA21485@hrz.tu-chemnitz.de>
In-Reply-To: <20071227122037.GA21485@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tFDeHbvT5lOb7Li"
Message-Id: <200712310201.49542.acinonyxs@yahoo.gr>
Subject: [B.A.T.M.A.N.] Quagga zebra API client for BATMAN
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

--Boundary-00=_tFDeHbvT5lOb7Li
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello ppl,

I've added support to send BATMAN routes to zebra daemon and redistribute them 
to other Quagga protocols. The interface is through zebra UNIX socket. A new 
option -q followed by the UNIX socket path is added (see batmand --help) to 
enable route export. I've also implemented a metric for BATMAN routes based 
on TTL value which is essential when using BATMAN as IGP to BGP 
Confederations.

I hope that you find it useful.

The attached patches are against latest stable BATMAN release (revsion 502) 
and Quagga 0.98.6. 

Regards,
Vasilis




--Boundary-00=_tFDeHbvT5lOb7Li
Content-Type: text/x-diff; charset="utf-8";
	name="batmand_0.2-rv502_sources-quagga.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="batmand_0.2-rv502_sources-quagga.diff"

diff -Nur batmand_0.2-rv502_sources/batman.c batmand_0.2-rv502_sources.patched/batman.c
--- batmand_0.2-rv502_sources/batman.c	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/batman.c	2007-12-30 13:13:19.000000000 +0200
@@ -3,6 +3,9 @@
  * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann,
  * Felix Fietkau, Marek Lindner
  *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -83,6 +86,7 @@
  */
 
 uint8_t routing_class = 0;
+uint8_t quagga_export = 0;
 
 
 int16_t orginator_interval = 1000;   /* orginator message interval in miliseconds */
@@ -131,6 +135,7 @@
 	fprintf( stderr, "       -H verbose help\n" );
 	fprintf( stderr, "       -o orginator interval in ms\n" );
 	fprintf( stderr, "       -p preferred gateway\n" );
+	fprintf( stderr, "       -q quagga unix socket\n" );
 	fprintf( stderr, "       -r routing class\n" );
 	fprintf( stderr, "       -s visualisation server\n" );
 	fprintf( stderr, "       -v print version\n" );
@@ -171,6 +176,8 @@
 	fprintf( stderr, "          default: 1000, allowed values: >0\n\n" );
 	fprintf( stderr, "       -p preferred gateway\n" );
 	fprintf( stderr, "          default: none, allowed values: IP\n\n" );
+	fprintf( stderr, "       -q quagga unix socket\n" );
+	fprintf( stderr, "          default: none, allowed values: Socket Path\n\n" );
 	fprintf( stderr, "       -r routing class (only needed if gateway class = 0)\n" );
 	fprintf( stderr, "          default:         0 -> set no default route\n" );
 	fprintf( stderr, "          allowed values:  1 -> use fast internet connection\n" );
@@ -196,7 +203,7 @@
 		netmask = ( uint32_t )orig_node->hna_buff[ ( hna_buff_count * 5 ) + 4 ];
 
 		if ( ( netmask > 0 ) && ( netmask < 33 ) )
-			add_del_route( hna, netmask, orig_node->router->addr, del, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
+			add_del_route( hna, netmask, orig_node->router->addr, orig_node->metric, del, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
 
 		hna_buff_count++;
 
@@ -373,7 +380,7 @@
 			if ( orig_node->hna_buff_len > 0 )
 				add_del_hna( orig_node, 1 );
 
-			add_del_route( orig_node->orig, 32, orig_node->router->addr, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
+			add_del_route( orig_node->orig, 32, orig_node->router->addr, orig_node->metric, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
 
 		}
 
@@ -386,7 +393,7 @@
 				debug_output( 4, "Route changed \n" );
 			}
 
-			add_del_route( orig_node->orig, 32, neigh_node->addr, 0, neigh_node->if_incoming->dev, neigh_node->if_incoming->udp_send_sock );
+			add_del_route( orig_node->orig, 32, neigh_node->addr, orig_node->metric, 0, neigh_node->if_incoming->dev, neigh_node->if_incoming->udp_send_sock );
 
 			orig_node->batman_if = neigh_node->if_incoming;
 			orig_node->router = neigh_node;
diff -Nur batmand_0.2-rv502_sources/batman.h batmand_0.2-rv502_sources.patched/batman.h
--- batmand_0.2-rv502_sources/batman.h	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/batman.h	2007-12-30 13:13:21.000000000 +0200
@@ -1,6 +1,10 @@
 /*
  * Copyright (C) 2006 B.A.T.M.A.N. contributors:
  * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner
+ *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -32,6 +36,7 @@
 #include "hash.h"
 #include "allocate.h"
 #include "profile.h"
+#include "quagga.h"
 
 
 
@@ -62,7 +67,7 @@
 #define JITTER 100
 #define TTL 50                /* Time To Live of broadcast messages */
 #define BIDIRECT_TIMEOUT 2
-#define PURGE_TIMEOUT 200000  /* purge originators after time in ms if no valid packet comes in -> TODO: check influence on SEQ_RANGE */
+#define PURGE_TIMEOUT 20000   /* purge originators after time in ms if no valid packet comes in -> TODO: check influence on SEQ_RANGE */
 #define SEQ_RANGE 128         /* sliding packet range of received orginator messages in squence numbers (should be a multiple of our word size) */
 
 
@@ -78,6 +83,7 @@
 extern uint8_t num_hna;
 extern int16_t orginator_interval;
 extern uint32_t pref_gateway;
+extern uint8_t quagga_export;
 
 extern unsigned char *hna_buff;
 
@@ -125,6 +131,7 @@
 	int16_t  hna_buff_len;
 	uint16_t last_seqno;        /* last and best known squence number */
 	struct list_head neigh_list;
+	uint16_t metric;
 };
 
 struct neigh_node
diff -Nur batmand_0.2-rv502_sources/linux-specific.c batmand_0.2-rv502_sources.patched/linux-specific.c
--- batmand_0.2-rv502_sources/linux-specific.c	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/linux-specific.c	2007-12-30 13:13:23.000000000 +0200
@@ -1,6 +1,10 @@
 /*
  * Copyright (C) 2006 BATMAN contributors:
  * Thomas Lopatic
+ *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -43,7 +47,7 @@
 #include "batman-specific.h"
 
 
-void add_del_route( uint32_t dest, uint16_t netmask, uint32_t router, int8_t del, char *dev, int32_t sock ) {
+void add_del_route( uint32_t dest, uint16_t netmask, uint32_t router, uint16_t metric, int8_t del, char *dev, int32_t sock ) {
 
 	struct rtentry route;
 	char str1[16], str2[16];
@@ -65,7 +69,7 @@
 	addr->sin_addr.s_addr = ( netmask == 32 ? 0xffffffff : htonl( ~ ( 0xffffffff >> netmask ) ) );
 
 	route.rt_flags = ( netmask == 32 ? ( RTF_HOST | RTF_UP ) : RTF_UP );
-	route.rt_metric = 1;
+	route.rt_metric = metric;
 
 	if ( ( dest != router ) || ( ( dest == 0 ) && ( router == 0 ) ) )
 	{
@@ -99,7 +103,7 @@
 
 	route.rt_dev = dev;
 
-	if ( ioctl( sock, del ? SIOCDELRT : SIOCADDRT, &route ) < 0 )
+	if ( (quagga_export ? zebra_add_del_route ( &route, del ) : ioctl( sock, del ? SIOCDELRT : SIOCADDRT, &route )) < 0 )
 		debug_output( 0, "Error - can't %s route to %s/%i via %s: %s\n", del ? "delete" : "add", str1, netmask, str2, strerror(errno) );
 
 }
diff -Nur batmand_0.2-rv502_sources/Makefile batmand_0.2-rv502_sources.patched/Makefile
--- batmand_0.2-rv502_sources/Makefile	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/Makefile	2007-12-30 13:13:26.000000000 +0200
@@ -1,6 +1,9 @@
 #
 # Copyright (C) 2006 BATMAN contributors
 #
+# This file was modified from the original on 30/12/2007
+# by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+#
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
 # License as published by the Free Software Foundation.
@@ -45,8 +48,8 @@
 
 LOG_BRANCH= branches/batman-0.2.x
 
-LINUX_SRC_C= batman.c originator.c schedule.c posix-specific.c posix.c allocate.c bitarray.c hash.c profile.c $(OS_C)
-LINUX_SRC_H= batman.h originator.h schedule.h batman-specific.h list.h os.h allocate.h bitarray.h hash.h profile.h 
+LINUX_SRC_C= batman.c originator.c schedule.c posix-specific.c posix.c allocate.c bitarray.c hash.c profile.c quagga.c $(OS_C)
+LINUX_SRC_H= batman.h originator.h schedule.h batman-specific.h list.h os.h allocate.h bitarray.h hash.h profile.h quagga.h
 
 BINARY_NAME=	batmand
 SOURCE_VERSION_HEADER= batman.h
diff -Nur batmand_0.2-rv502_sources/originator.c batmand_0.2-rv502_sources.patched/originator.c
--- batmand_0.2-rv502_sources/originator.c	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/originator.c	2007-12-30 04:08:40.000000000 +0200
@@ -88,6 +88,7 @@
 	orig_node->orig = addr;
 	orig_node->router = NULL;
 	orig_node->batman_if = NULL;
+	orig_node->metric = TTL;
 
 	orig_node->bidirect_link = debugMalloc( found_ifs * sizeof(uint16_t), 402 );
 	memset( orig_node->bidirect_link, 0, found_ifs * sizeof(uint16_t) );
@@ -196,6 +197,8 @@
 
 	}
 
+	orig_node->metric = TTL + 1 - in->ttl;
+
 	/* update routing table and check for changed hna announcements */
 	update_routes( orig_node, best_neigh_node, hna_recv_buff, hna_buff_len );
 
@@ -296,7 +299,7 @@
 						if ( orig_node->hna_buff_len > 0 )
 							add_del_hna( orig_node, 1 );
 
-						add_del_route( orig_node->orig, 32, orig_node->router->addr, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
+						add_del_route( orig_node->orig, 32, orig_node->router->addr, orig_node->metric, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
 
 						orig_node->router = NULL;
 
diff -Nur batmand_0.2-rv502_sources/originator.h batmand_0.2-rv502_sources.patched/originator.h
--- batmand_0.2-rv502_sources/originator.h	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/originator.h	2007-12-30 13:13:28.000000000 +0200
@@ -1,6 +1,9 @@
 /* Copyright (C) 2006 B.A.T.M.A.N. contributors:
  * Simon Wunderlich, Marek Lindner
  *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
diff -Nur batmand_0.2-rv502_sources/os.h batmand_0.2-rv502_sources.patched/os.h
--- batmand_0.2-rv502_sources/os.h	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/os.h	2007-12-30 13:13:30.000000000 +0200
@@ -1,6 +1,10 @@
 /*
  * Copyright (C) 2006 BATMAN contributors:
  * Thomas Lopatic, Marek Lindner
+ *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -41,7 +45,7 @@
 void set_send_redirects( int32_t state, char* dev );
 int32_t get_send_redirects( char *dev );
 
-void add_del_route( uint32_t dest, uint16_t netmask, uint32_t router, int8_t del, char *dev, int32_t sock );
+void add_del_route( uint32_t dest, uint16_t netmask, uint32_t router, uint16_t metric, int8_t del, char *dev, int32_t sock );
 void add_del_hna( struct orig_node *orig_node, int8_t del );
 int8_t is_aborted();
 void handler( int32_t sig );
diff -Nur batmand_0.2-rv502_sources/posix-specific.c batmand_0.2-rv502_sources.patched/posix-specific.c
--- batmand_0.2-rv502_sources/posix-specific.c	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/posix-specific.c	2007-12-30 13:13:32.000000000 +0200
@@ -1,6 +1,10 @@
 /*
  * Copyright (C) 2006 BATMAN contributors:
  * Thomas Lopatic, Marek Lindner
+ *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -437,6 +441,7 @@
 	struct hna_node *hna_node;
 	struct debug_level_info *debug_level_info;
 	uint8_t found_args = 1, batch_mode = 0;
+	char *zebra_sock_path = NULL;
 	uint16_t netmask;
 	int8_t res;
 
@@ -449,7 +454,7 @@
 	stop = 0;
 
 
-	while ( ( optchar = getopt ( argc, argv, "a:bcd:hHo:g:p:r:s:vV" ) ) != -1 ) {
+	while ( ( optchar = getopt ( argc, argv, "a:bcd:hHo:g:p:r:s:vVq:" ) ) != -1 ) {
 
 		switch ( optchar ) {
 
@@ -624,6 +629,16 @@
 
 				exit(EXIT_SUCCESS);
 
+			case 'q':
+
+				errno = 0;
+
+				quagga_export++;
+				zebra_sock_path = optarg;
+				
+				found_args += 2;
+				break;
+
 			case 'h':
 			default:
 				usage();
@@ -899,6 +914,9 @@
 
 	}
 
+	if ( ( quagga_export != 0 ) && ( !zebra_init(zebra_sock_path) ) )
+		exit(EXIT_FAILURE);
+		
 }
 
 
@@ -1159,7 +1177,7 @@
 
 	if ( add_dev_tun( curr_gw_data->batman_if, curr_gw_data->batman_if->addr.sin_addr.s_addr, curr_gateway_tun_if, sizeof(curr_gateway_tun_if), &curr_gateway_tun_fd ) > 0 ) {
 
-		add_del_route( 0, 0, 0, 0, curr_gateway_tun_if, curr_gw_data->batman_if->udp_send_sock );
+		add_del_route( 0, 0, 0, 0, 0, curr_gateway_tun_if, curr_gw_data->batman_if->udp_send_sock );
 
 	} else {
 
@@ -1298,7 +1316,7 @@
 	}
 
 	/* cleanup */
-	add_del_route( 0, 0, 0, 1, curr_gateway_tun_if, curr_gw_data->batman_if->udp_send_sock );
+	add_del_route( 0, 0, 0, 0, 1, curr_gateway_tun_if, curr_gw_data->batman_if->udp_send_sock );
 
 	close( curr_gateway_tcp_sock );
 	close( curr_gateway_tun_sock );
diff -Nur batmand_0.2-rv502_sources/quagga.c batmand_0.2-rv502_sources.patched/quagga.c
--- batmand_0.2-rv502_sources/quagga.c	1970-01-01 02:00:00.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/quagga.c	2007-12-30 13:13:42.000000000 +0200
@@ -0,0 +1,239 @@
+/*
+ * API client for Quagga zebra daemon
+ *
+ * Copyright (C) 2007 BATMAN contributors:
+ * Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ * based on olsrd_quagga plugin by Immo 'FaUl' Wehrenberg
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <sys/un.h>
+#include <arpa/inet.h>
+#include <errno.h>
+#include "quagga.h"
+#include "allocate.h"
+#include "os.h"
+
+
+struct zebra_api
+{
+  unsigned char cmd;
+  unsigned char type;
+  unsigned char flags;
+  unsigned char message;
+  unsigned char prefixlen;
+  struct in_addr prefix;
+  unsigned char nexthop_num;
+  unsigned char ifindex_num;
+  struct in_addr *nexthop;
+  uint32_t *ifindex;
+  unsigned char distance;
+  uint32_t metric;
+};
+
+static int zebra_sock;
+static int8_t zebra_connect (char *socket_path);
+static unsigned char *zebra_packet (char cmd, struct zebra_api *api);
+static int8_t zebra_send (unsigned char *data);
+
+
+static int8_t
+zebra_connect (char *sock_path)
+{
+  int sock;
+  struct sockaddr_un sock_addr;
+
+  // zebra socket address
+  memset (&sock_addr, 0, sizeof (sock_addr));
+  sock_addr.sun_family = AF_UNIX;
+  strcpy (sock_addr.sun_path, sock_path);
+
+  // create socket  
+  if ((sock = socket (AF_UNIX, SOCK_STREAM, 0)) < 0)
+    {
+      fprintf (stderr, "Error - (Quagga) could not create socket!");
+    }
+  else
+    {
+      // connect to zebra unix socket
+      if (connect
+	  (sock, (struct sockaddr *) &sock_addr, sizeof sock_addr) < 0)
+	{
+	  fprintf (stderr,
+		   "Error - (Quagga) could not connect to zebra! Is zebra running?\n");
+	  close (sock);
+	  return -1;
+	}
+    }
+
+  return sock;
+}
+
+
+int8_t
+zebra_init (char *sock_path)
+{
+  zebra_sock = zebra_connect (sock_path);
+
+  if (zebra_sock < 0)
+    return 0;
+  else
+
+    return 1;
+}
+
+
+int8_t
+zebra_add_del_route (struct rtentry * route, int8_t del)
+{
+  struct zebra_api api;
+  uint32_t netmask;
+
+  // sanity checks
+  if ((route->rt_dst.sa_family & route->rt_genmask.sa_family) != AF_INET)
+    {
+      fprintf (stderr, "Error - (Quagga) only ipv4 is supported so far\n");
+      restore_and_exit (0);
+    }
+  if (((struct sockaddr_in *) &route->rt_gateway)->sin_addr.s_addr == 0)
+    return 0;			// don't add route without gateway
+
+  // prepare api
+  api.type = ZEBRA_ROUTE_BATMAN;
+  api.flags = 0;
+  api.message = ZAPI_MESSAGE_NEXTHOP | (del ? 0 : ZAPI_MESSAGE_METRIC);
+  netmask =
+    ntohl (((struct sockaddr_in *) &route->rt_genmask)->sin_addr.s_addr);
+  for (api.prefixlen = 0; api.prefixlen < 32 && netmask << api.prefixlen > 0;
+       api.prefixlen++);
+  api.prefix.s_addr =
+    ((struct sockaddr_in *) &route->rt_dst)->sin_addr.s_addr;
+  api.nexthop_num = 1;
+  api.ifindex_num = 0;
+  api.nexthop = &((struct sockaddr_in *) &route->rt_gateway)->sin_addr;
+  api.ifindex = NULL;
+  api.distance = 0;
+  api.metric = htonl (route->rt_metric);
+
+  return
+    zebra_send (zebra_packet
+		(del ? ZEBRA_IPV4_ROUTE_DELETE : ZEBRA_IPV4_ROUTE_ADD, &api));
+}
+
+
+static unsigned char *
+zebra_packet (char cmd, struct zebra_api *api)
+{
+  unsigned char *data, *pnt;
+  uint16_t size;
+  uint8_t len, i;
+
+  data = debugMalloc (ZEBRA_MAX_PACKET_SIZ, 601);
+
+  pnt = &data[2];		// reserve 2 bytes for packet size
+  *pnt++ = cmd;
+  *pnt++ = api->type;
+  *pnt++ = api->flags;
+  *pnt++ = api->message;
+  *pnt++ = api->prefixlen;
+  len = (api->prefixlen + 7) / 8;
+  memcpy (pnt, &api->prefix.s_addr, len);
+  pnt = pnt + len;
+  if ((api->message & ZAPI_MESSAGE_NEXTHOP) > 0)
+    {
+      if ((api->flags & ZEBRA_FLAG_BLACKHOLE) > 0)
+	{
+	  *pnt++ = 1;
+	  *pnt++ = ZEBRA_NEXTHOP_BLACKHOLE;
+	}
+      else
+	*pnt++ = api->nexthop_num + api->ifindex_num;
+      for (i = 0; i < api->nexthop_num; i++)
+	{
+	  *pnt++ = ZEBRA_NEXTHOP_IPV4;
+	  memcpy (pnt, &api->nexthop[i].s_addr,
+		  sizeof api->nexthop[i].s_addr);
+	  pnt += sizeof api->nexthop[i].s_addr;
+	}
+      for (i = 0; i < api->ifindex_num; i++)
+	{
+	  *pnt++ = ZEBRA_NEXTHOP_IFINDEX;
+	  memcpy (pnt, &api->ifindex[i], sizeof api->ifindex[i]);
+	  pnt += sizeof api->ifindex[i];
+	}
+    }
+  if ((api->message & ZAPI_MESSAGE_DISTANCE) > 0)
+    *pnt++ = api->distance;
+  if ((api->message & ZAPI_MESSAGE_METRIC) > 0)
+    {
+      memcpy (pnt, &api->metric, sizeof api->metric);
+      pnt += sizeof api->metric;
+    }
+  size = htons (pnt - data);
+  memcpy (data, &size, 2);
+
+  return data;
+}
+
+static int8_t
+zebra_send (unsigned char *data)
+{
+  int ret;
+  int16_t size;
+  unsigned char *pnt;
+
+#ifdef DEBUG
+  zebra_debug (data);
+#endif
+
+  pnt = data;
+  memcpy (&size, pnt, 2);
+  size = ntohs (size);
+
+  do
+    {
+      ret = write (zebra_sock, pnt, size);
+      if (ret < 0)
+	{
+	  if (errno == EINTR)
+	    {
+	      errno = 0;
+	      continue;
+	    }
+	  else
+	    {
+	      fprintf (stderr, "Error - (Quagga) disconnected from zebra\n");
+	      debugFree (data, 1601);
+	      restore_and_exit (0);
+
+	      return ret;
+	    }
+	}
+      pnt = pnt + ret;
+    }
+  while ((size -= ret));
+  debugFree (data, 1601);
+
+  return 0;
+}
diff -Nur batmand_0.2-rv502_sources/quagga.h batmand_0.2-rv502_sources.patched/quagga.h
--- batmand_0.2-rv502_sources/quagga.h	1970-01-01 02:00:00.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/quagga.h	2007-12-30 13:13:44.000000000 +0200
@@ -0,0 +1,110 @@
+/*
+ * API client for Quagga zebra daemon header file
+ *
+ * Copyright (C) 2007 BATMAN contributors:
+ * Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ * based on olsrd_quagga plugin by Immo 'FaUl' Wehrenberg
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include <net/route.h>
+
+/* Zebra message types. */
+#define ZEBRA_INTERFACE_ADD                1
+#define ZEBRA_INTERFACE_DELETE             2
+#define ZEBRA_INTERFACE_ADDRESS_ADD        3
+#define ZEBRA_INTERFACE_ADDRESS_DELETE     4
+#define ZEBRA_INTERFACE_UP                 5
+#define ZEBRA_INTERFACE_DOWN               6
+#define ZEBRA_IPV4_ROUTE_ADD               7
+#define ZEBRA_IPV4_ROUTE_DELETE            8
+#define ZEBRA_IPV6_ROUTE_ADD               9
+#define ZEBRA_IPV6_ROUTE_DELETE           10
+#define ZEBRA_REDISTRIBUTE_ADD            11
+#define ZEBRA_REDISTRIBUTE_DELETE         12
+#define ZEBRA_REDISTRIBUTE_DEFAULT_ADD    13
+#define ZEBRA_REDISTRIBUTE_DEFAULT_DELETE 14
+#define ZEBRA_IPV4_NEXTHOP_LOOKUP         15
+#define ZEBRA_IPV6_NEXTHOP_LOOKUP         16
+#define ZEBRA_IPV4_IMPORT_LOOKUP          17
+#define ZEBRA_IPV6_IMPORT_LOOKUP          18
+#define ZEBRA_INTERFACE_RENAME            19
+#define ZEBRA_ROUTER_ID_ADD               20
+#define ZEBRA_ROUTER_ID_DELETE            21
+#define ZEBRA_ROUTER_ID_UPDATE            22
+#define ZEBRA_MESSAGE_MAX                 23
+
+/* Zebra route's types. */
+#define ZEBRA_ROUTE_SYSTEM               0
+#define ZEBRA_ROUTE_KERNEL               1
+#define ZEBRA_ROUTE_CONNECT              2
+#define ZEBRA_ROUTE_STATIC               3
+#define ZEBRA_ROUTE_RIP                  4
+#define ZEBRA_ROUTE_RIPNG                5
+#define ZEBRA_ROUTE_OSPF                 6
+#define ZEBRA_ROUTE_OSPF6                7
+#define ZEBRA_ROUTE_ISIS                 8
+#define ZEBRA_ROUTE_BGP                  9
+#define ZEBRA_ROUTE_HSLS		 10
+#define ZEBRA_ROUTE_OLSR		 11
+#define ZEBRA_ROUTE_BATMAN		 12
+#define ZEBRA_ROUTE_MAX                  13
+
+/* Zebra's family types. */
+#define ZEBRA_FAMILY_IPV4                1
+#define ZEBRA_FAMILY_IPV6                2
+#define ZEBRA_FAMILY_MAX                 3
+
+/* Error codes of zebra. */
+#define ZEBRA_ERR_RTEXIST               -1
+#define ZEBRA_ERR_RTUNREACH             -2
+#define ZEBRA_ERR_EPERM                 -3
+#define ZEBRA_ERR_RTNOEXIST             -4
+
+/* Zebra message flags */
+#define ZEBRA_FLAG_INTERNAL           0x01
+#define ZEBRA_FLAG_SELFROUTE          0x02
+#define ZEBRA_FLAG_BLACKHOLE          0x04
+#define ZEBRA_FLAG_IBGP               0x08
+#define ZEBRA_FLAG_SELECTED           0x10
+#define ZEBRA_FLAG_CHANGED            0x20
+#define ZEBRA_FLAG_STATIC             0x40
+#define ZEBRA_FLAG_REJECT             0x80
+
+/* Zebra nexthop flags. */
+#define ZEBRA_NEXTHOP_IFINDEX            1
+#define ZEBRA_NEXTHOP_IFNAME             2
+#define ZEBRA_NEXTHOP_IPV4               3
+#define ZEBRA_NEXTHOP_IPV4_IFINDEX       4
+#define ZEBRA_NEXTHOP_IPV4_IFNAME        5
+#define ZEBRA_NEXTHOP_IPV6               6
+#define ZEBRA_NEXTHOP_IPV6_IFINDEX       7
+#define ZEBRA_NEXTHOP_IPV6_IFNAME        8
+#define ZEBRA_NEXTHOP_BLACKHOLE          9
+
+/* For input/output buffer to zebra. */
+#define ZEBRA_MAX_PACKET_SIZ          4096
+
+/* Zebra API message flag. */
+#define ZAPI_MESSAGE_NEXTHOP  0x01
+#define ZAPI_MESSAGE_IFINDEX  0x02
+#define ZAPI_MESSAGE_DISTANCE 0x04
+#define ZAPI_MESSAGE_METRIC   0x08
+
+
+int8_t zebra_init (char *socket_path);
+int8_t zebra_add_del_route (struct rtentry *route, int8_t del);

--Boundary-00=_tFDeHbvT5lOb7Li
Content-Type: text/x-diff; charset="utf-8"; name="quagga-0.98.6-batman.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="quagga-0.98.6-batman.diff"

diff -Nur quagga-0.98.6/bgpd/bgp_vty.c quagga-0.98.6.patched/bgpd/bgp_vty.c
--- quagga-0.98.6/bgpd/bgp_vty.c	2006-03-30 18:12:25.000000000 +0200
+++ quagga-0.98.6.patched/bgpd/bgp_vty.c	2007-12-30 14:18:22.000000000 +0200
@@ -3,6 +3,9 @@
 
 This file is part of GNU Zebra.
 
+This file was modified from the original on 30/12/2007
+by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+
 GNU Zebra is free software; you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by the
 Free Software Foundation; either version 2, or (at your option) any
@@ -7793,8 +7796,12 @@
 	return ZEBRA_ROUTE_STATIC;
       else if (strncmp (str, "r", 1) == 0)
 	return ZEBRA_ROUTE_RIP;
-      else if (strncmp (str, "o", 1) == 0)
+      else if (strncmp (str, "ol", 2) == 0)
+	return ZEBRA_ROUTE_OLSR;
+      else if (strncmp (str, "os", 2) == 0)
 	return ZEBRA_ROUTE_OSPF;
+      else if (strncmp (str, "ba", 2) == 0)
+	return ZEBRA_ROUTE_BATMAN;
     }
   if (afi == AFI_IP6)
     {
@@ -7806,21 +7813,28 @@
 	return ZEBRA_ROUTE_STATIC;
       else if (strncmp (str, "r", 1) == 0)
 	return ZEBRA_ROUTE_RIPNG;
-      else if (strncmp (str, "o", 1) == 0)
+      else if (strncmp (str, "os", 2) == 0)
 	return ZEBRA_ROUTE_OSPF6;
+      else if (strncmp (str, "ol", 2) == 0)
+	return ZEBRA_ROUTE_OLSR;
+      else if (strncmp (str, "ba", 2) == 0)
+	return ZEBRA_ROUTE_BATMAN;
     }
   return 0;
 }
 
 DEFUN (bgp_redistribute_ipv4,
        bgp_redistribute_ipv4_cmd,
-       "redistribute (connected|kernel|ospf|rip|static)",
+       "redistribute (connected|kernel|ospf|rip|static|olsr|batman)",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
-       "Static routes\n")
+       "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+       )
 {
   int type;
 
@@ -7835,13 +7849,15 @@
 
 DEFUN (bgp_redistribute_ipv4_rmap,
        bgp_redistribute_ipv4_rmap_cmd,
-       "redistribute (connected|kernel|ospf|rip|static) route-map WORD",
+       "redistribute (connected|kernel|ospf|rip|static|olsr|batman) route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n")
 {
@@ -7860,13 +7876,15 @@
 
 DEFUN (bgp_redistribute_ipv4_metric,
        bgp_redistribute_ipv4_metric_cmd,
-       "redistribute (connected|kernel|ospf|rip|static) metric <0-4294967295>",
+       "redistribute (connected|kernel|ospf|rip|static|olsr|batman) metric <0-4294967295>",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n")
 {
@@ -7887,13 +7905,15 @@
 
 DEFUN (bgp_redistribute_ipv4_rmap_metric,
        bgp_redistribute_ipv4_rmap_metric_cmd,
-       "redistribute (connected|kernel|ospf|rip|static) route-map WORD metric <0-4294967295>",
+       "redistribute (connected|kernel|ospf|rip|static|olsr|batman) route-map WORD metric <0-4294967295>",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n"
        "Metric for redistributed routes\n"
@@ -7917,13 +7937,15 @@
 
 DEFUN (bgp_redistribute_ipv4_metric_rmap,
        bgp_redistribute_ipv4_metric_rmap_cmd,
-       "redistribute (connected|kernel|ospf|rip|static) metric <0-4294967295> route-map WORD",
+       "redistribute (connected|kernel|ospf|rip|static|olsr|batman) metric <0-4294967295> route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n"
        "Route map reference\n"
@@ -7947,14 +7969,17 @@
 
 DEFUN (no_bgp_redistribute_ipv4,
        no_bgp_redistribute_ipv4_cmd,
-       "no redistribute (connected|kernel|ospf|rip|static)",
+       "no redistribute (connected|kernel|ospf|rip|static|olsr|batman)",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
-       "Static routes\n")
+       "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+       )
 {
   int type;
 
@@ -7970,7 +7995,7 @@
 
 DEFUN (no_bgp_redistribute_ipv4_rmap,
        no_bgp_redistribute_ipv4_rmap_cmd,
-       "no redistribute (connected|kernel|ospf|rip|static) route-map WORD",
+       "no redistribute (connected|kernel|ospf|rip|static|olsr|batman) route-map WORD",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -7978,6 +8003,8 @@
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n")
 {
@@ -7996,7 +8023,7 @@
 
 DEFUN (no_bgp_redistribute_ipv4_metric,
        no_bgp_redistribute_ipv4_metric_cmd,
-       "no redistribute (connected|kernel|ospf|rip|static) metric <0-4294967295>",
+       "no redistribute (connected|kernel|ospf|rip|static|olsr|batman) metric <0-4294967295>",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8004,6 +8031,8 @@
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n")
 {
@@ -8022,7 +8051,7 @@
 
 DEFUN (no_bgp_redistribute_ipv4_rmap_metric,
        no_bgp_redistribute_ipv4_rmap_metric_cmd,
-       "no redistribute (connected|kernel|ospf|rip|static) route-map WORD metric <0-4294967295>",
+       "no redistribute (connected|kernel|ospf|rip|static|olsr|batman) route-map WORD metric <0-4294967295>",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8030,6 +8059,8 @@
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n"
        "Metric for redistributed routes\n"
@@ -8051,7 +8082,7 @@
 
 ALIAS (no_bgp_redistribute_ipv4_rmap_metric,
        no_bgp_redistribute_ipv4_metric_rmap_cmd,
-       "no redistribute (connected|kernel|ospf|rip|static) metric <0-4294967295> route-map WORD",
+       "no redistribute (connected|kernel|ospf|rip|static|olsr|batman) metric <0-4294967295> route-map WORD",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8059,6 +8090,8 @@
        "Open Shurtest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n"
        "Route map reference\n"
@@ -8067,13 +8100,16 @@
 #ifdef HAVE_IPV6
 DEFUN (bgp_redistribute_ipv6,
        bgp_redistribute_ipv6_cmd,
-       "redistribute (connected|kernel|ospf6|ripng|static)",
+       "redistribute (connected|kernel|ospf6|ripng|static|olsr|batman)",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
-       "Static routes\n")
+       "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+       )
 {
   int type;
 
@@ -8089,13 +8125,15 @@
 
 DEFUN (bgp_redistribute_ipv6_rmap,
        bgp_redistribute_ipv6_rmap_cmd,
-       "redistribute (connected|kernel|ospf6|ripng|static) route-map WORD",
+       "redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n")
 {
@@ -8114,13 +8152,15 @@
 
 DEFUN (bgp_redistribute_ipv6_metric,
        bgp_redistribute_ipv6_metric_cmd,
-       "redistribute (connected|kernel|ospf6|ripng|static) metric <0-4294967295>",
+       "redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) metric <0-4294967295>",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n")
 {
@@ -8141,13 +8181,15 @@
 
 DEFUN (bgp_redistribute_ipv6_rmap_metric,
        bgp_redistribute_ipv6_rmap_metric_cmd,
-       "redistribute (connected|kernel|ospf6|ripng|static) route-map WORD metric <0-4294967295>",
+       "redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) route-map WORD metric <0-4294967295>",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n"
        "Metric for redistributed routes\n"
@@ -8171,13 +8213,15 @@
 
 DEFUN (bgp_redistribute_ipv6_metric_rmap,
        bgp_redistribute_ipv6_metric_rmap_cmd,
-       "redistribute (connected|kernel|ospf6|ripng|static) metric <0-4294967295> route-map WORD",
+       "redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) metric <0-4294967295> route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n"
        "Route map reference\n"
@@ -8201,14 +8245,17 @@
 
 DEFUN (no_bgp_redistribute_ipv6,
        no_bgp_redistribute_ipv6_cmd,
-       "no redistribute (connected|kernel|ospf6|ripng|static)",
+       "no redistribute (connected|kernel|ospf6|ripng|static|olsr|batman)",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
        "Kernel routes\n"
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
-       "Static routes\n")
+       "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+      )
 {
   int type;
 
@@ -8224,7 +8271,7 @@
 
 DEFUN (no_bgp_redistribute_ipv6_rmap,
        no_bgp_redistribute_ipv6_rmap_cmd,
-       "no redistribute (connected|kernel|ospf6|ripng|static) route-map WORD",
+       "no redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) route-map WORD",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8232,6 +8279,8 @@
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n")
 {
@@ -8250,7 +8299,7 @@
 
 DEFUN (no_bgp_redistribute_ipv6_metric,
        no_bgp_redistribute_ipv6_metric_cmd,
-       "no redistribute (connected|kernel|ospf6|ripng|static) metric <0-4294967295>",
+       "no redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) metric <0-4294967295>",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8258,6 +8307,8 @@
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n")
 {
@@ -8276,7 +8327,7 @@
 
 DEFUN (no_bgp_redistribute_ipv6_rmap_metric,
        no_bgp_redistribute_ipv6_rmap_metric_cmd,
-       "no redistribute (connected|kernel|ospf6|ripng|static) route-map WORD metric <0-4294967295>",
+       "no redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) route-map WORD metric <0-4294967295>",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8284,6 +8335,8 @@
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n"
        "Metric for redistributed routes\n"
@@ -8305,7 +8358,7 @@
 
 ALIAS (no_bgp_redistribute_ipv6_rmap_metric,
        no_bgp_redistribute_ipv6_metric_rmap_cmd,
-       "no redistribute (connected|kernel|ospf6|ripng|static) metric <0-4294967295> route-map WORD",
+       "no redistribute (connected|kernel|ospf6|ripng|static|olsr|batman) metric <0-4294967295> route-map WORD",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Connected\n"
@@ -8313,6 +8366,8 @@
        "Open Shurtest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
        "Static routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "Default metric\n"
        "Route map reference\n"
@@ -8325,7 +8380,7 @@
 {
   int i;
   const char *str[] = { "system", "kernel", "connected", "static", "rip",
-		  "ripng", "ospf", "ospf6", "isis", "bgp"};
+		  "ripng", "ospf", "ospf6", "isis", "bgp", "hsls", "olsr", "batman"};
 
   /* Unicast redistribution only.  */
   if (safi != SAFI_UNICAST)
diff -Nur quagga-0.98.6/lib/zebra.h quagga-0.98.6.patched/lib/zebra.h
--- quagga-0.98.6/lib/zebra.h	2005-06-15 14:54:18.000000000 +0300
+++ quagga-0.98.6.patched/lib/zebra.h	2007-12-30 14:18:22.000000000 +0200
@@ -3,6 +3,9 @@
 
 This file is part of GNU Zebra.
 
+This file was modified from the original on 30/12/2007
+by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+
 GNU Zebra is free software; you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by the
 Free Software Foundation; either version 2, or (at your option) any
@@ -378,7 +381,9 @@
 #define ZEBRA_ROUTE_ISIS                 8
 #define ZEBRA_ROUTE_BGP                  9
 #define ZEBRA_ROUTE_HSLS		 10
-#define ZEBRA_ROUTE_MAX                  11
+#define ZEBRA_ROUTE_OLSR		 11
+#define ZEBRA_ROUTE_BATMAN		 12
+#define ZEBRA_ROUTE_MAX                  13
 
 /* Zebra's family types. */
 #define ZEBRA_FAMILY_IPV4                1
diff -Nur quagga-0.98.6/ospfd/ospf_vty.c quagga-0.98.6.patched/ospfd/ospf_vty.c
--- quagga-0.98.6/ospfd/ospf_vty.c	2006-03-30 17:41:20.000000000 +0200
+++ quagga-0.98.6.patched/ospfd/ospf_vty.c	2007-12-30 14:18:22.000000000 +0200
@@ -3,6 +3,9 @@
  *
  * This file is part of GNU Zebra.
  *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * GNU Zebra is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -106,11 +109,15 @@
     *source = ZEBRA_ROUTE_STATIC;
   else if (strncmp (str, "r", 1) == 0)
     *source = ZEBRA_ROUTE_RIP;
-  else if (strncmp (str, "b", 1) == 0)
+  else if (strncmp (str, "bg", 2) == 0)
     *source = ZEBRA_ROUTE_BGP;
+  else if (strncmp (str, "ol", 2) == 0)
+    *source = ZEBRA_ROUTE_OLSR;
+  else if (strncmp (str, "ba", 2) == 0)
+    *source = ZEBRA_ROUTE_BATMAN;
   else
     return 0;
-
+  
   return 1;
 }
 
@@ -5302,13 +5309,15 @@
 
 DEFUN (ospf_redistribute_source_metric_type,
        ospf_redistribute_source_metric_type_routemap_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric <0-16777214> metric-type (1|2) route-map WORD",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric <0-16777214> metric-type (1|2) route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "OSPF default metric\n"
        "OSPF exterior metric type for redistributed routes\n"
@@ -5346,13 +5355,15 @@
 
 ALIAS (ospf_redistribute_source_metric_type,
        ospf_redistribute_source_metric_type_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric <0-16777214> metric-type (1|2)",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric <0-16777214> metric-type (1|2)",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "OSPF default metric\n"
        "OSPF exterior metric type for redistributed routes\n"
@@ -5361,25 +5372,29 @@
 
 ALIAS (ospf_redistribute_source_metric_type,
        ospf_redistribute_source_metric_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric <0-16777214>",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric <0-16777214>",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "OSPF default metric\n")
 
 DEFUN (ospf_redistribute_source_type_metric,
        ospf_redistribute_source_type_metric_routemap_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric-type (1|2) metric <0-16777214> route-map WORD",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric-type (1|2) metric <0-16777214> route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "OSPF exterior metric type for redistributed routes\n"
        "Set OSPF External Type 1 metrics\n"
        "Set OSPF External Type 2 metrics\n"
@@ -5417,13 +5432,15 @@
 
 ALIAS (ospf_redistribute_source_type_metric,
        ospf_redistribute_source_type_metric_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric-type (1|2) metric <0-16777214>",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric-type (1|2) metric <0-16777214>",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "OSPF exterior metric type for redistributed routes\n"
        "Set OSPF External Type 1 metrics\n"
        "Set OSPF External Type 2 metrics\n"
@@ -5432,7 +5449,7 @@
 
 ALIAS (ospf_redistribute_source_type_metric,
        ospf_redistribute_source_type_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric-type (1|2)",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric-type (1|2)",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
@@ -5440,28 +5457,35 @@
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
        "OSPF exterior metric type for redistributed routes\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Set OSPF External Type 1 metrics\n"
        "Set OSPF External Type 2 metrics\n")
 
 ALIAS (ospf_redistribute_source_type_metric,
        ospf_redistribute_source_cmd,
-       "redistribute (kernel|connected|static|rip|bgp)",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman)",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
-       "Border Gateway Protocol (BGP)\n")
+       "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+	)
 
 DEFUN (ospf_redistribute_source_metric_routemap,
        ospf_redistribute_source_metric_routemap_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric <0-16777214> route-map WORD",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric <0-16777214> route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Metric for redistributed routes\n"
        "OSPF default metric\n"
        "Route map reference\n"
@@ -5490,13 +5514,15 @@
 
 DEFUN (ospf_redistribute_source_type_routemap,
        ospf_redistribute_source_type_routemap_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) metric-type (1|2) route-map WORD",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) metric-type (1|2) route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "OSPF exterior metric type for redistributed routes\n"
        "Set OSPF External Type 1 metrics\n"
        "Set OSPF External Type 2 metrics\n"
@@ -5526,13 +5552,15 @@
 
 DEFUN (ospf_redistribute_source_routemap,
        ospf_redistribute_source_routemap_cmd,
-       "redistribute (kernel|connected|static|rip|bgp) route-map WORD",
+       "redistribute (kernel|connected|static|rip|bgp|olsr|batman) route-map WORD",
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
        "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Route map reference\n"
        "Pointer to route-map entries\n")
 {
@@ -5553,14 +5581,17 @@
 
 DEFUN (no_ospf_redistribute_source,
        no_ospf_redistribute_source_cmd,
-       "no redistribute (kernel|connected|static|rip|bgp)",
+       "no redistribute (kernel|connected|static|rip|bgp|olsr|batman)",
        NO_STR
        "Redistribute information from another routing protocol\n"
        "Kernel routes\n"
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
-       "Border Gateway Protocol (BGP)\n")
+       "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+       )
 {
   struct ospf *ospf = vty->index;
   int source;
@@ -5574,7 +5605,7 @@
 
 DEFUN (ospf_distribute_list_out,
        ospf_distribute_list_out_cmd,
-       "distribute-list WORD out (kernel|connected|static|rip|bgp)",
+       "distribute-list WORD out (kernel|connected|static|rip|bgp|olsr|batman)",
        "Filter networks in routing updates\n"
        "Access-list name\n"
        OUT_STR
@@ -5582,7 +5613,10 @@
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
-       "Border Gateway Protocol (BGP)\n")
+       "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+)
 {
   struct ospf *ospf = vty->index;
   int source;
@@ -5596,7 +5630,7 @@
 
 DEFUN (no_ospf_distribute_list_out,
        no_ospf_distribute_list_out_cmd,
-       "no distribute-list WORD out (kernel|connected|static|rip|bgp)",
+       "no distribute-list WORD out (kernel|connected|static|rip|bgp|olsr|batman)",
        NO_STR
        "Filter networks in routing updates\n"
        "Access-list name\n"
@@ -5605,7 +5639,10 @@
        "Connected\n"
        "Static routes\n"
        "Routing Information Protocol (RIP)\n"
-       "Border Gateway Protocol (BGP)\n")
+       "Border Gateway Protocol (BGP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
+)
 {
   struct ospf *ospf = vty->index;
   int source;
@@ -7121,7 +7158,8 @@
 
 
 const char *distribute_str[] = { "system", "kernel", "connected", "static",
-				"rip", "ripng", "ospf", "ospf6", "isis", "bgp"};
+				"rip", "ripng", "ospf", "ospf6", "isis", "bgp",
+				"hsls","olsr","batman"};
 int
 config_write_ospf_redistribute (struct vty *vty, struct ospf *ospf)
 {
diff -Nur quagga-0.98.6/zebra/redistribute.c quagga-0.98.6.patched/zebra/redistribute.c
--- quagga-0.98.6/zebra/redistribute.c	2005-06-15 14:54:51.000000000 +0300
+++ quagga-0.98.6.patched/zebra/redistribute.c	2007-12-30 14:18:22.000000000 +0200
@@ -3,6 +3,9 @@
  *
  * This file is part of GNU Zebra.
  *
+ * This file was modified from the original on 30/12/2007
+ * by Vasilis Tsiligiannis <acinonyxs@yahoo.gr>
+ *
  * GNU Zebra is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -253,6 +256,8 @@
     case ZEBRA_ROUTE_OSPF:
     case ZEBRA_ROUTE_OSPF6:
     case ZEBRA_ROUTE_BGP:
+    case ZEBRA_ROUTE_OLSR:
+    case ZEBRA_ROUTE_BATMAN:
       if (! client->redist[type])
 	{
 	  client->redist[type] = 1;
@@ -281,6 +286,8 @@
     case ZEBRA_ROUTE_OSPF:
     case ZEBRA_ROUTE_OSPF6:
     case ZEBRA_ROUTE_BGP:
+    case ZEBRA_ROUTE_OLSR:
+    case ZEBRA_ROUTE_BATMAN:
       client->redist[type] = 0;
       break;
     default:
diff -Nur quagga-0.98.6/zebra/zebra_vty.c quagga-0.98.6.patched/zebra/zebra_vty.c
--- quagga-0.98.6/zebra/zebra_vty.c	2004-12-18 18:03:29.000000000 +0200
+++ quagga-0.98.6.patched/zebra/zebra_vty.c	2007-12-30 14:25:48.000000000 +0200
@@ -53,6 +53,10 @@
       return "isis";
     case ZEBRA_ROUTE_BGP:
       return "bgp";
+    case ZEBRA_ROUTE_OLSR:
+      return "olsr";
+    case ZEBRA_ROUTE_BATMAN:
+      return "batman";
     default:
       return "unknown";
     }
@@ -84,6 +88,12 @@
       return 'I';
     case ZEBRA_ROUTE_BGP:
       return 'B';
+    case ZEBRA_ROUTE_HSLS:
+      return 'H';
+    case ZEBRA_ROUTE_OLSR:
+      return 'L';
+    case ZEBRA_ROUTE_BATMAN:
+      return 'M';
     default:
       return '?';
     }
@@ -755,8 +765,8 @@
 }
 
 #define SHOW_ROUTE_V4_HEADER "Codes: K - kernel route, C - connected, " \
-  "S - static, R - RIP, O - OSPF,%s       I - ISIS, B - BGP, " \
-  "> - selected route, * - FIB route%s%s"
+  "S - static, R - RIP, O - OSPF,%s       I - ISIS, B - BGP, H - HSLS, " \
+  "L - OLSR, M - BATMAN, > - selected route, * - FIB route%s%s"
 
 DEFUN (show_ip_route,
        show_ip_route_cmd,
@@ -874,7 +884,7 @@
 
 DEFUN (show_ip_route_protocol,
        show_ip_route_protocol_cmd,
-       "show ip route (bgp|connected|isis|kernel|ospf|rip|static)",
+       "show ip route (bgp|connected|isis|kernel|ospf|rip|olsr|batman|static)",
        SHOW_STR
        IP_STR
        "IP routing table\n"
@@ -884,6 +894,8 @@
        "Kernel\n"
        "Open Shortest Path First (OSPF)\n"
        "Routing Information Protocol (RIP)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Static routes\n")
 {
   int type;
@@ -892,13 +904,13 @@
   struct rib *rib;
   int first = 1;
 
-  if (strncmp (argv[0], "b", 1) == 0)
+  if (strncmp (argv[0], "bg", 2) == 0)
     type = ZEBRA_ROUTE_BGP;
   else if (strncmp (argv[0], "c", 1) == 0)
     type = ZEBRA_ROUTE_CONNECT;
   else if (strncmp (argv[0], "k", 1) ==0)
     type = ZEBRA_ROUTE_KERNEL;
-  else if (strncmp (argv[0], "o", 1) == 0)
+  else if (strncmp (argv[0], "os", 2) == 0)
     type = ZEBRA_ROUTE_OSPF;
   else if (strncmp (argv[0], "i", 1) == 0)
     type = ZEBRA_ROUTE_ISIS;
@@ -906,6 +918,10 @@
     type = ZEBRA_ROUTE_RIP;
   else if (strncmp (argv[0], "s", 1) == 0)
     type = ZEBRA_ROUTE_STATIC;
+  else if (strncmp (argv[0], "ol", 2) == 0)
+    type = ZEBRA_ROUTE_OLSR;
+  else if (strncmp (argv[0], "ba", 2) == 0)
+    type = ZEBRA_ROUTE_BATMAN;
   else 
     {
       vty_out (vty, "Unknown route type%s", VTY_NEWLINE);
@@ -1732,7 +1748,7 @@
 
 DEFUN (show_ipv6_route_protocol,
        show_ipv6_route_protocol_cmd,
-       "show ipv6 route (bgp|connected|isis|kernel|ospf6|ripng|static)",
+       "show ipv6 route (bgp|connected|isis|kernel|ospf6|ripng|olsr|batman|static)",
        SHOW_STR
        IP_STR
        "IP routing table\n"
@@ -1742,6 +1758,8 @@
        "Kernel\n"
        "Open Shortest Path First (OSPFv3)\n"
        "Routing Information Protocol (RIPng)\n"
+       "Optimized Link State Routing (OLSR)\n"
+       "Better Approach to Mobile Ad-Hoc Networking (BATMAN)\n"
        "Static routes\n")
 {
   int type;
@@ -1750,13 +1768,13 @@
   struct rib *rib;
   int first = 1;
 
-  if (strncmp (argv[0], "b", 1) == 0)
+  if (strncmp (argv[0], "bg", 2) == 0)
     type = ZEBRA_ROUTE_BGP;
   else if (strncmp (argv[0], "c", 1) == 0)
     type = ZEBRA_ROUTE_CONNECT;
   else if (strncmp (argv[0], "k", 1) ==0)
     type = ZEBRA_ROUTE_KERNEL;
-  else if (strncmp (argv[0], "o", 1) == 0)
+  else if (strncmp (argv[0], "os", 2) == 0)
     type = ZEBRA_ROUTE_OSPF6;
   else if (strncmp (argv[0], "i", 1) == 0)
     type = ZEBRA_ROUTE_ISIS;
@@ -1764,7 +1782,11 @@
     type = ZEBRA_ROUTE_RIPNG;
   else if (strncmp (argv[0], "s", 1) == 0)
     type = ZEBRA_ROUTE_STATIC;
-  else 
+  else if (strncmp (argv[0], "ol", 2) == 0)
+     type = ZEBRA_ROUTE_OLSR;
+  else if (strncmp (argv[0], "ba", 2) == 0)
+     type = ZEBRA_ROUTE_BATMAN;
+  else
     {
       vty_out (vty, "Unknown route type%s", VTY_NEWLINE);
       return CMD_WARNING;

--Boundary-00=_tFDeHbvT5lOb7Li--
