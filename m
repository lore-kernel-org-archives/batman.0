Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  9 Dec 2011 10:18:27 +0100
Message-Id: <1323422308-4897-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Generate config compatible with
	kbuild macros
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

Linux 3.0-rc1-30-g2a11c8e introduced the macros IS_ENABLED, IS_BUILTIN and
IS_MODULE that can be used to identify which state a tristate option had. The
compat-autoconf.h needs to provide additional precompiler variables that these
marcros can use.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gen-compat-autoconf.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 440accc..1a020c1 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -12,15 +12,22 @@ gen_config() {
 	VALUE="${2}"
 
 	echo "#undef ${KEY}"
+	echo "#undef __enabled_${KEY}"
+	echo "#undef __enabled_${KEY}_MODULE"
 	case "${VALUE}" in
 	y)
 		echo "#define ${KEY} 1"
+		echo "#define __enabled_${KEY} 1"
+		echo "#define __enabled_${KEY}_MODULE 0"
 		;;
 	m)
 		echo "#define ${KEY} 1"
+		echo "#define __enabled_${KEY} 0"
+		echo "#define __enabled_${KEY}_MODULE 1"
 		;;
 	n)
-		# leave it undefined
+		echo "#define __enabled_${KEY} 0"
+		echo "#define __enabled_${KEY}_MODULE 0"
 		;;
 	*)
 		echo "#define ${KEY} \"${VALUE}\""
-- 
1.7.7.3

