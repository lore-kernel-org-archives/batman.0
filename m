Return-Path: <joe@perches.com>
Message-ID: <1424461955.18211.15.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Fri, 20 Feb 2015 11:52:35 -0800
In-Reply-To: <7679509.IB7arj1Sb8@voltaire>
References: <2621923.3aVJ40SYcy@voltaire>
 <1424375741.18211.4.camel@perches.com> <7679509.IB7arj1Sb8@voltaire>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] checkpatch: Improve "no space is necessary
 after a cast" test
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Marek Lindner <mareklindner@neomailbox.ch>

The "no space is necessary after a cast" sizeof exclusion
doesn't work properly.

The test reports a false positive for code like:

	BUILD_BUG_ON(sizeof(struct batadv_bla_claim_dst) != 6);

Make it work, simplify the exclusions, and add some comments.

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 scripts/checkpatch.pl | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d124359..2898e49 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2552,9 +2552,16 @@ sub process {
 			}
 		}
 
-		if ($line =~ /^\+.*(\w+\s*)?\(\s*$Type\s*\)[ \t]+(?!$Assignment|$Arithmetic|[,;:\?\(\{\}\[\<\>]|&&|\|\||\\$)/ &&
-		    (!defined($1) || $1 !~ /sizeof\s*/)) {
-			if (CHK("SPACING",
+# check for space after cast like "(int) foo" or "(struct foo) bar"
+# avoid checking a few false positives:
+#   "sizeof(<type>)" or "__alignof__(<type>)"
+#   function pointer declarations like "(*foo)(int) = bar;"
+#   structure definitions like "(struct foo) { 0 };"
+#   multiline macros that define functions
+#   known attributes or the __attribute__ keyword
+		if ($line =~ /^\+(.*)\(\s*$Type\s*\)([ \t]++)((?![={]|\\$|$Attribute|__attribute__))/ &&
+		    (!defined($1) || $1 !~ /\b(?:sizeof|__alignof__)\s*$/)) {
+			if (CHK("SPACING",
 				"No space is necessary after a cast\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] =~


