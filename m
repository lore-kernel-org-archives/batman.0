Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:12:02 +0200
Message-Id: <1378847522-13776-12-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/11] batctl: Don't use hyphen for parameter
	in manpage
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
Cc: Sven Eckelmann <sven@narfation.org>

By default, "-" chars are interpreted as hyphens (U+2010) by groff, not as
minus signs (U+002D). Since options to programs use minus signs (U+002D), this
means for example in UTF-8 locales that you cannot cut and paste options, nor
search for them easily.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/batctl.8 b/man/batctl.8
index d04385b..157f96d 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -269,7 +269,7 @@ except specified). The following packet types are available:
 128 - non batman packets
 .RE
 .RS 7
-Example: batctl td <interface> -p 129 \-> only display batman ogm packets and non batman packets
+Example: batctl td <interface> \-p 129 \-> only display batman ogm packets and non batman packets
 .RE
 .br
 .IP "\fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
-- 
1.8.4.rc3

