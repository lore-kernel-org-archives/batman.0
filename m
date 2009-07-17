Return-Path: <jtmze87@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200907161900.54293.lindner_marek@yahoo.de>
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907160936.25169.sven.eckelmann@gmx.de>
	<9B01495A-3D13-463A-B4FC-3C5E129D32EF@7degrees.co.za>
	<200907161900.54293.lindner_marek@yahoo.de>
Date: Fri, 17 Jul 2009 09:10:55 +0200
Message-ID: <1739bfe0907170010n67ae2bd8m9bf9813d09687951@mail.gmail.com>
From: jonathan mzengeza <jtmze87@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

I looked at the site and it talked about something I had already tried
which works well. Here is another patch hope its better.

Signed-off-by: Jonathan Mzengeza <jtmze87@gmail.com>
Index: vis.c
===================================================================
--- vis.c	(revision 1343)
+++ vis.c	(working copy)
@@ -566,6 +566,7 @@
 	buffer_t *last_send = NULL;
 	size_t ret;
 	char* send_buffer = NULL;
+  	char tmp[4096];

 	while ( !is_aborted() ) {

@@ -600,6 +601,17 @@

 	}

+	shutdown(thread_data->socket, SHUT_WR);
+	
+	for(;;) {
+		ret=read(thread_data->socket, tmp, sizeof(tmp));
+		if(ret < 0) {
+			break;
+		}
+		if(!ret) {
+			break;
+		}
+	}			
 	if ( debug_level > 0 )
 		debug_output( "TCP client has left: %s \n", thread_data->ip );
