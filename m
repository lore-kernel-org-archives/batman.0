Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 26 Apr 2019 19:29:55 +0200
Message-Id: <20190426172955.18574-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add noflood command
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

Adds support for the new 'noflood' setting in batman-adv.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile     |  1 +
 README.rst   | 10 ++++++++++
 batman_adv.h | 10 ++++++++++
 man/batctl.8 |  7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/Makefile b/Makefile
index df8b7b9..6a363d7 100755
--- a/Makefile
+++ b/Makefile
@@ -61,6 +61,7 @@ $(eval $(call add_command,multicast_mode,y))
 $(eval $(call add_command,nc_nodes,y))
 $(eval $(call add_command,neighbors,y))
 $(eval $(call add_command,network_coding,y))
+$(eval $(call add_command,noflood,y))
 $(eval $(call add_command,orig_interval,y))
 $(eval $(call add_command,originators,y))
 $(eval $(call add_command,ping,y))
diff --git a/README.rst b/README.rst
index 03ea5e5..67d42f6 100644
--- a/README.rst
+++ b/README.rst
@@ -571,6 +571,16 @@ Usage::
 * Example 4: ``batctl mark 0x0f``
 
 
+batctl noflood
+=======================
+
+display or modify noflood setting (<disabled>|<cautious>|<aggressive>)
+
+Usage::
+
+  batctl noflood|nf [0|1|2]
+
+
 batctl translocal
 =================
 
diff --git a/batman_adv.h b/batman_adv.h
index 67f4636..ea2ffda 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -480,6 +480,16 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_NOFLOOD: defines if and how strictly flooding prevention
+	 * is configured. If the value is 0 then flood prevention is disabled.
+	 * If the value is 1 then flood prevention is enabled for all multicast
+	 * /broadcast packets excluding ICMPv6 and IGMP (cautious mode). If set
+	 * to 2 then flood prevention is enabled for all multicast/broadcast
+	 * packets (aggressive mode).
+	 */
+        BATADV_ATTR_NOFLOOD,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/man/batctl.8 b/man/batctl.8
index 8d7332a..7518f9c 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -116,6 +116,13 @@ If no parameter is given the current multicast fanout setting is displayed. Othe
 the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
 multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
 .br
+.IP "\fBnoflood\fP|\fBnf\fP [\fB0|1|2\fP]"
+If no parameter is given the current noflood setting is displayed. Otherwise the parameter is used to set the
+the noflood option. The noflood option defines if and how strictly flooding prevention is configured. If the value is
+0 then flood prevention is disabled. If the value is 1 then flood prevention is enabled for all multicast/broadcast
+packets excluding ICMPv6 and IGMP (cautious mode). If set to 2 then flood prevention is enabled for all multicast/broadcast
+packets (aggressive mode).
+.br
 .IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
-- 
2.20.1

