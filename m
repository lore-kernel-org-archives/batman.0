Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 1/4] alfred: remove meaningless printf() call
Date: Sun,  2 Jan 2022 12:31:33 +0100
Message-Id: <20220102113136.470299-1-mareklindner@neomailbox.ch>
In-Reply-To: <3748133.vRqKQLy7FI@rousseau>
References: <3748133.vRqKQLy7FI@rousseau>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 server.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/server.c b/server.c
index b4925e7..85bf453 100644
--- a/server.c
+++ b/server.c
@@ -442,7 +442,6 @@ int alfred_server(struct globals *globals)
 			netsock_check_error(globals, &errfds);
=20
 			if (FD_ISSET(globals->unix_sock, &fds)) {
-				printf("read unix socket\n");
 				unix_sock_read(globals);
 				continue;
 			} else {
--=20
2.32.0.rc0
