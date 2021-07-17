Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/9] batctl: man: Fix alignment after json list
Date: Sat, 17 Jul 2021 13:01:21 +0200
Message-Id: <20210717110129.25539-2-sven@narfation.org>
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

The manpage uses RS macro to indent elements of a list and the resets the
indentation again with RE. ut the usage of these macros were mixed up for
the last entries. This caused a misalignment of the following entries.

Fixes: 20086d207940 ("batctl: Add transtable_local_json command")
Fixes: 35d8327f9d98 ("batctl: Add vlan_json command")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 80077bb..a820e6e 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -338,13 +338,13 @@ List of available JSON queries:
 .RS 10
 \- transtable_global_json|tgj
 .RE
-.RE
+.RS 10
 \- transtable_local_json|tlj
 .RE
-.RE
+.RS 10
 \- vlan_json|vj
 .RE
-.RS 10
+.RE
 .br
 .IP "[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 
-- 
2.30.2

