Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/9] batctl: man: Move commands to own section
Date: Sat, 17 Jul 2021 13:01:22 +0200
Message-Id: <20210717110129.25539-3-sven@narfation.org>
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

The commands were implemented as paragraph with specific style in the
options section. But it should actually be a complete new section because
it is not really related to the options at all.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index a820e6e..58656eb 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -41,19 +41,16 @@ functionality to the normal \fBping\fP(1), \fBtraceroute\fP(1), \fBtcpdump\fP(1)
 behaviour or using the B.A.T.M.A.N. advanced protocol. For similar reasons, \fBthroughputmeter\fP, a command to test network
 performances, is also included.
 
-.PP
-.PP
 .SH OPTIONS
-.TP
-.I \fBoptions:
 \-m     specify mesh interface (default 'bat0')
 .br
 \-h     print general batctl help
 .br
 \-v     print batctl version and batman-adv version (if the module is loaded)
 .br
-.TP
-.I \fBcommands:
+
+.SH COMMANDS
+
 .IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fB-M\fP] [\fBadd\fP|\fBdel iface(s)\fP]"
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
 In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
-- 
2.30.2

