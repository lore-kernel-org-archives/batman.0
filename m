Return-Path: <linus.luessing@web.de>
Date: Fri, 11 Dec 2009 22:06:23 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091211210623.GA3538@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Fix array out of bound exception
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
To: b.a.t.m.a.n@lists.open-mesh.net

This patch fixes an array out of bound exception in line 201 of
functions.c. We need to reserve one extra character for the
appended null character.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---

Index: batctl/functions.c
===================================================================
--- batctl/functions.c	(revision 1491)
+++ batctl/functions.c	(working copy)
@@ -161,10 +161,10 @@
 
 	if (read_opt & USE_READ_BUFF) {
 		read_ptr = read_buff;
-		read_len = sizeof(read_buff);
+		read_len = sizeof(read_buff)-1;
 	} else {
 		read_ptr = lbuff;
-		read_len = sizeof(lbuff);
+		read_len = sizeof(lbuff)-1;
 	}
 
 open:
