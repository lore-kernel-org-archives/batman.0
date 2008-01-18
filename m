From: Acinonyx <acinonyxs@yahoo.gr>
Subject: Re: [B.A.T.M.A.N.] Quagga zebra API client for BATMAN
Date: Fri, 18 Jan 2008 18:16:35 +0200
References: <200712271148.14121.holger@layer-acht.org>
	<20071227122037.GA21485@hrz.tu-chemnitz.de>
	<200712310201.49542.acinonyxs@yahoo.gr>
In-Reply-To: <200712310201.49542.acinonyxs@yahoo.gr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jDNkHMXhBUi3qYv"
Message-Id: <200801181816.35869.acinonyxs@yahoo.gr>
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

--Boundary-00=_jDNkHMXhBUi3qYv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=CE=A3=CF=84=CE=B9=CF=82 Monday 31 December 2007 02:01:49 =CE=BF/=CE=B7 Aci=
nonyx =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> Hello ppl,
>
> I've added support to send BATMAN routes to zebra daemon and redistribute
> them to other Quagga protocols. The interface is through zebra UNIX socke=
t.
> A new option -q followed by the UNIX socket path is added (see batmand
> --help) to enable route export. I've also implemented a metric for BATMAN
> routes based on TTL value which is essential when using BATMAN as IGP to
> BGP
> Confederations.
>

Hello again,

I've fixed a bug in zebra client route update which tried to delete=20
routes with the new metric instead of the previously installed.

I've also tried to calculate a metric based on link quality. Unfortunately,=
 I=20
wasn't able to find a way to compare latency between two different=20
originators. Originators could only be compared based on packet loss which=
=20
isn't what we want because it would lead to having the same metric (1) for=
=20
all nodes if there isn't some packet loss present. So, we are staying for t=
he=20
moment with the TTL approach with some adjustment to make it safer with=20
different TTL settings.

I also want to point out an issue with batmand host routes and Quagga.=20
Although Quagga succesfully installs host routes, it doesn't treat them as=
=20
valid gateways if the associated interface isn't flaged as P-t-P. I don't=20
know if this is a bug or a feature but it renders all batmand second level=
=20
routes inactive. I added a workaround in zebra client which disables host=20
route installation. This means that you can use quagga zebra client only if=
=20
you have standard broadcast subnets.

The attached patch is against latest stable BATMAN release (revsion 502).

Regards,
Vasilis


--Boundary-00=_jDNkHMXhBUi3qYv
Content-Type: text/x-diff; charset="utf-8";
	name="batmand_0.2-rv502_sources-quagga-0.3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="batmand_0.2-rv502_sources-quagga-0.3.diff"

diff -Nur batmand_0.2-rv502_sources/batman.c batmand_0.2-rv502_sources.patched/batman.c
--- batmand_0.2-rv502_sources/batman.c	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/batman.c	2008-01-18 03:30:26.000000000 +0200
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
@@ -113,6 +116,7 @@
 struct vis_if vis_if;
 struct unix_if unix_if;
 struct debug_clients debug_clients;
+struct zebra zebra;
 
 unsigned char *vis_packet = NULL;
 uint16_t vis_packet_size = 0;
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
 
@@ -347,6 +354,7 @@
 
 	prof_start( PROF_update_routes );
 	static char orig_str[ADDR_STR_LEN], next_str[ADDR_STR_LEN];
+	uint16_t metric;
 
 
 	debug_output( 4, "update_routes() \n" );
@@ -373,7 +381,7 @@
 			if ( orig_node->hna_buff_len > 0 )
 				add_del_hna( orig_node, 1 );
 
-			add_del_route( orig_node->orig, 32, orig_node->router->addr, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
+			add_del_route( orig_node->orig, 32, orig_node->router->addr, orig_node->metric, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
 
 		}
 
@@ -386,10 +394,12 @@
 				debug_output( 4, "Route changed \n" );
 			}
 
-			add_del_route( orig_node->orig, 32, neigh_node->addr, 0, neigh_node->if_incoming->dev, neigh_node->if_incoming->udp_send_sock );
+			metric = 255 - neigh_node->last_ttl;
+			add_del_route( orig_node->orig, 32, neigh_node->addr, metric, 0, neigh_node->if_incoming->dev, neigh_node->if_incoming->udp_send_sock );
 
 			orig_node->batman_if = neigh_node->if_incoming;
 			orig_node->router = neigh_node;
+			orig_node->metric = metric;
 
 			/* add new announced network(s) */
 			if ( hna_buff_len > 0 ) {
diff -Nur batmand_0.2-rv502_sources/batman.h batmand_0.2-rv502_sources.patched/batman.h
--- batmand_0.2-rv502_sources/batman.h	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/batman.h	2008-01-17 20:34:03.000000000 +0200
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
 
 
@@ -100,6 +105,7 @@
 extern struct vis_if vis_if;
 extern struct unix_if unix_if;
 extern struct debug_clients debug_clients;
+extern struct zebra zebra;
 
 extern char *gw2string[];
 
@@ -125,6 +131,7 @@
 	int16_t  hna_buff_len;
 	uint16_t last_seqno;        /* last and best known squence number */
 	struct list_head neigh_list;
+	uint16_t metric;
 };
 
 struct neigh_node
@@ -226,6 +233,13 @@
 	struct batman_if *batman_if;
 };
 
+struct zebra
+{
+	uint8_t enabled;
+	char *unix_path;
+	int32_t unix_sock;
+};
+
 
 int8_t batman( void );
 void usage( void );
diff -Nur batmand_0.2-rv502_sources/linux-specific.c batmand_0.2-rv502_sources.patched/linux-specific.c
--- batmand_0.2-rv502_sources/linux-specific.c	2007-10-11 19:56:11.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/linux-specific.c	2007-12-31 17:19:33.000000000 +0200
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
+	if ( (zebra.enabled ? zebra_add_del_route ( &route, del ) : ioctl( sock, del ? SIOCDELRT : SIOCADDRT, &route )) < 0 )
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
+++ batmand_0.2-rv502_sources.patched/originator.c	2008-01-17 20:34:05.000000000 +0200
@@ -88,6 +88,7 @@
 	orig_node->orig = addr;
 	orig_node->router = NULL;
 	orig_node->batman_if = NULL;
+	orig_node->metric = 255;
 
 	orig_node->bidirect_link = debugMalloc( found_ifs * sizeof(uint16_t), 402 );
 	memset( orig_node->bidirect_link, 0, found_ifs * sizeof(uint16_t) );
@@ -296,7 +297,7 @@
 						if ( orig_node->hna_buff_len > 0 )
 							add_del_hna( orig_node, 1 );
 
-						add_del_route( orig_node->orig, 32, orig_node->router->addr, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
+						add_del_route( orig_node->orig, 32, orig_node->router->addr, orig_node->metric, 1, orig_node->batman_if->dev, orig_node->batman_if->udp_send_sock );
 
 						orig_node->router = NULL;
 
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
+++ batmand_0.2-rv502_sources.patched/posix-specific.c	2007-12-31 18:36:57.000000000 +0200
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
@@ -445,11 +449,12 @@
 	uint32_t vis_server = 0;
 
 
+	memset(&zebra, 0, sizeof(zebra));
 	memset( &tmp_ip_holder, 0, sizeof (struct in_addr) );
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
+				zebra.enabled++;
+				zebra.unix_path = optarg;
+				
+				found_args += 2;
+				break;
+
 			case 'h':
 			default:
 				usage();
@@ -899,6 +914,9 @@
 
 	}
 
+	if ( ( zebra.enabled != 0 ) && ( !zebra_init(zebra.unix_path) ) )
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
@@ -1385,6 +1403,9 @@
 	if ( unix_if.unix_sock )
 		close( unix_if.unix_sock );
 
+	if ( zebra.unix_sock > 0 )
+		close( zebra.unix_sock );
+
 	if ( unix_if.listen_thread_id != 0 )
 		pthread_join( unix_if.listen_thread_id, NULL );
 
diff -Nur batmand_0.2-rv502_sources/quagga.c batmand_0.2-rv502_sources.patched/quagga.c
--- batmand_0.2-rv502_sources/quagga.c	1970-01-01 02:00:00.000000000 +0200
+++ batmand_0.2-rv502_sources.patched/quagga.c	2008-01-18 03:23:02.000000000 +0200
@@ -0,0 +1,247 @@
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
+#include <net/if.h>
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
+static int32_t zebra_connect (char *socket_path);
+static unsigned char *zebra_packet (char cmd, struct zebra_api *api);
+static int8_t zebra_send (unsigned char *data);
+
+
+static int32_t
+zebra_connect (char *unix_path)
+{
+  int sock;
+  struct sockaddr_un sock_addr;
+
+  // zebra socket address
+  memset (&sock_addr, 0, sizeof (sock_addr));
+  sock_addr.sun_family = AF_UNIX;
+  strcpy (sock_addr.sun_path, unix_path);
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
+zebra_init (char *unix_path)
+{
+  zebra.unix_sock = zebra_connect (unix_path);
+
+  if (zebra.unix_sock < 0)
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
+  uint32_t netmask, ifindex;
+
+  // sanity checks
+  if ((route->rt_dst.sa_family & route->rt_genmask.sa_family) != AF_INET)
+    {
+      fprintf (stderr, "Error - (Quagga) only ipv4 is supported so far\n");
+      restore_and_exit (0);
+    }
+  if (((struct sockaddr_in *) &route->rt_gateway)->sin_addr.s_addr == 0)
+    return 0;			/* Quagga BUG workaround: don't add routes with destination = gateway
+				   see http://lists.olsr.org/pipermail/olsr-users/2006-June/001726.html */
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
+  if ((((struct sockaddr_in *) &route->rt_gateway)->sin_addr.s_addr != 0)
+      || api.prefixlen < 32)
+    {
+      api.nexthop_num = 1;
+      api.ifindex_num = 0;
+    }
+  else
+    {
+      api.message |= ZAPI_MESSAGE_IFINDEX;
+      api.nexthop_num = 0;
+      api.ifindex_num = 1;
+    }
+  api.nexthop = &((struct sockaddr_in *) &route->rt_gateway)->sin_addr;
+  ifindex = htonl (if_nametoindex (route->rt_dev));
+  api.ifindex = &ifindex;
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
+  pnt = data;
+  memcpy (&size, pnt, 2);
+  size = ntohs (size);
+
+  do
+    {
+      ret = write (zebra.unix_sock, pnt, size);
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

--Boundary-00=_jDNkHMXhBUi3qYv--
