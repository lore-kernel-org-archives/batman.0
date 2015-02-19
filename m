Return-Path: <joe@perches.com>
Message-ID: <1424375741.18211.4.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Thu, 19 Feb 2015 11:55:41 -0800
In-Reply-To: <2621923.3aVJ40SYcy@voltaire>
References: <2621923.3aVJ40SYcy@voltaire>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] checkpatch: CHECK: No space is necessary after a
	cast
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, 2015-02-19 at 13:35 +0800, Marek Lindner wrote:
> Hi Joe,

Hi Marek

> we have come across a checkpatch false-positive:
[]
> 	BUILD_BUG_ON(sizeof(struct batadv_bla_claim_dst) != 6);
> CHECK: No space is necessary after a cast
> #440: FILE: main.c:440:
> +       BUILD_BUG_ON(sizeof(struct batadv_bla_claim_dst) != 6);
[]
> Can you make a suggestion / patch for checkpatch to better handle this case ?

The "sizeof" test in the current script doesn't work.

I believe the patch below works with no false positives
but <shrug> it's perl regexes against odd coding styles
and weird macros, who knows for sure...

I did run it against drivers/, net/ and include/

Give this a try:
---
 scripts/checkpatch.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d124359..2f5bb27 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2552,9 +2552,15 @@ sub process {
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
+		if ($line =~ /^\+(.*)\(\s*$Type\s*\)([ \t]++)((?![={]|\\$))/ &&
+		    (!defined($1) || $1 !~ /\b(?:sizeof|__alignof__)\s*$/)) {
+			if (CHK("SPACING",
 				"No space is necessary after a cast\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] =~


