Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 9/9] batctl: man: Rewrite SEE ALSO list
Date: Sat, 17 Jul 2021 13:01:29 +0200
Message-Id: <20210717110129.25539-10-sven@narfation.org>
In-Reply-To: <20210717110129.25539-1-sven@narfation.org>
References: <20210717110129.25539-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

The dot command is not relevant anymore to batctl because the vis command
is no longer provided by batctl/batman-adv.

The ip and ip-link are the main tools to handle the kernel net_devices via
rtnetlink. They are therefore a must for anyone trying to use the batadv
interfaces.

The trace-cmd is the tool which has to be used to gather the logs from the
kernel when batctl enabled the various loglevels for an batadv interface.

The bridge utility is the main tool to configure bridges over the
batman-adv interfaces. It must also be used to read out the mdb state in
case the multicast handling of batman-adv has to be debugged.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 1470beb..b5be0b8 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -506,11 +506,14 @@ provided host name or replace MAC addresses in debug output and logs. Host names
 addresses.
 
 .SH SEE ALSO
-.BR ping (1),
-.BR traceroute (1),
-.BR tcpdump (1),
+.BR bridge (8),
 .BR dmesg (1),
-.BR dot (1)
+.BR ip (8),
+.BR ip-link (8),
+.BR ping (8),
+.BR tcpdump (8),
+.BR traceroute (1),
+.BR trace-cmd (1)
 .SH AUTHOR
 batctl was written by Andreas Langer <an.langer@gmx.de> and Marek Lindner <mareklindner@neomailbox.ch>.
 .PP
-- 
2.30.2

