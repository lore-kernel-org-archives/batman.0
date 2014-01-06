Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon,  6 Jan 2014 16:36:54 +0800
Message-Id: <1388997414-7390-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: remove gateway class left-overs in
	the manpage
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 man/batctl.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index fafe735..316c9ab 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -107,15 +107,15 @@ If no parameter is given the current gateway mode is displayed otherwise the par
 second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server'
 was the first argument). If the node is a server this parameter is used to inform other nodes in the network about
 this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv
-module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload
+module will propagate the entered value in the mesh. Use "/" to separate the down\(hy and upload rates. You can omit the upload
 rate and the module will assume an upload of download / 5.
 .RS 17
-default: 2000 \-> gateway class 20
+default: 10000 \-> 10.0/2.0 MBit
 .RE
 .RS 16
-examples: 5000 \-> gateway class 49
+examples:  5000 \->  5.0/1.0 MBit
 .RE
-.RS 25
+.RS 26
  5000kbit
  5mbit
  5mbit/1024
-- 
1.8.4.4

