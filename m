Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 22 Jul 2014 23:59:10 +0200
Message-Id: <1406066350-26579-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Don't use hyphen for parameter in
	manpage
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
index 110020e..bbe888c 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -61,7 +61,7 @@ originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
-disable ap isolation. This command can be used in conjunction with "-m" option to target per VLAN configurations.
+disable ap isolation. This command can be used in conjunction with "\-m" option to target per VLAN configurations.
 .br
 .IP "\fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable
-- 
2.0.1

