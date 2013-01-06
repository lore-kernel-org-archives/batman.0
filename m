Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun,  6 Jan 2013 21:44:55 +0800
Message-Id: <1357479895-12659-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: man page - fix undefined macro
	warning
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

A line beginning with ' or . in a groff file has a special meaning and
cannot be used for literal text. Instead the interpreter will try to
execute it and fail doing so. A zero-width space or reformatting the
paragraph can be used as simple workaround.

This problem was detected using: LC_ALL=en_US.UTF-8 MANROFFSEQ=''
MANWIDTH=80 man --warnings -E UTF-8 -l -Tutf8 -Z man/batctl.8
>/dev/null

Reported-by: Pau Koning <paukoning@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 v2:
     * Use different approach to solve issue as first attempt was too
       obscure.

 man/batctl.8 |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 62e9de2..7af78e9 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -2,7 +2,7 @@
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
 .\" other parameters are allowed: see man(7), man(1)
-.TH "BATCTL" "8" "Jan 04, 2010" "Linux" "B.A.T.M.A.N. Advanced Control Tool"
+.TH "BATCTL" "8" "Jan 06, 2013" "Linux" "B.A.T.M.A.N. Advanced Control Tool"
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
@@ -18,6 +18,8 @@
 .\" --------------------------------------------------------------------------
 .\" Process this file with
 .\" groff -man batctl.8 -Tutf8
+.\" Retrieve format warnings with
+.\" man --warnings batctl.8 > /dev/null
 .\" --------------------------------------------------------------------------
 .ad l
 .SH NAME
@@ -100,8 +102,8 @@ replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
 If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The
-second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if
-'server' was the first argument). If the node is a server this parameter is used to inform other nodes in the network about
+second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server'
+was the first argument). If the node is a server this parameter is used to inform other nodes in the network about
 this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv
 module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload
 rate and the module will assume an upload of download / 5.
-- 
1.7.10.4

