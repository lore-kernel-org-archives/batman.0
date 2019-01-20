Return-Path: <joe@perches.com>
Message-ID: <d9eb35b2594d9cfedd8525dc32a18b40c60451b0.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Sun, 20 Jan 2019 10:39:55 -0800
In-Reply-To: <3904432.cpar7GfAiZ@sven-edge>
References: <20190116102651.489113812@linutronix.de>
 <20190116104127.698565432@linutronix.de> <3904432.cpar7GfAiZ@sven-edge>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [patch 2/2] scripts/spdxcheck.py: Handle special
 quotation mark comments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, b.a.t.m.a.n@lists.open-mesh.org

On Sun, 2019-01-20 at 16:32 +0100, Sven Eckelmann wrote:
> On Wednesday, 16 January 2019 11.26.53 CET Thomas Gleixner wrote:
> > The SuperH boot code files use a magic format for the SPDX identifier
> > comment:
> > 
> >   LIST "SPDX-License-Identifier: .... "
> > 
> > The trailing quotation mark is not stripped before the token parser is
> > invoked and causes the scan to fail. Handle it gracefully.
> [...]
> 
> This patch introduces a false positive when checking files with an ANSI-C 
> style /* SPDX-License-Identifier: .... */ comment line.
> 
>     $ ./scripts/checkpatch.pl -q -f include/linux/bug.h
>     WARNING: 'SPDX-License-Identifier: GPL-2.0 */' is not supported in LICENSES/...
>     #1: FILE: include/linux/bug.h:1:
>     +/* SPDX-License-Identifier: GPL-2.0 */
>     
>     total: 0 errors, 1 warnings, 79 lines checked
> 
> checkpatch.pl is already stripping the "/* " prefix and only sends the 
> remaining "SPDX-License-Identifier: GPL-2.0 */" via stdin to
> scripts/spdxcheck.py. Thus the newly introduced check
> 
> > +                # Remove trailing comment closure
> > +                if line.startswith('/*'):
> > +                    expr = expr.rstrip('*/').strip()
> 
> doesn't match and thus the code doesn't remove the " */" at the end of the 
> line.

Well, maybe checkpatch should remove the comment trailer.
---
Miscellanea:

o Indent a block properly too

 scripts/checkpatch.pl | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 155fa9305166..e0b542008256 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3029,8 +3029,10 @@ sub process {
 				$checklicenseline = 2;
 			} elsif ($rawline =~ /^\+/) {
 				my $comment = "";
+				my $trailer = "";
 				if ($realfile =~ /\.(h|s|S)$/) {
 					$comment = '/*';
+					$trailer = '*/';
 				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
 					$comment = '//';
 				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
@@ -3044,11 +3046,12 @@ sub process {
 					 WARN("SPDX_LICENSE_TAG",
 					      "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
-					 my $spdx_license = $1;
-					 if (!is_SPDX_License_valid($spdx_license)) {
-						  WARN("SPDX_LICENSE_TAG",
-						       "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
-					 }
+					my $spdx_license = rtrim($1);
+					$spdx_license =~ s/\s*\Q$trailer\E$//;
+					if (!is_SPDX_License_valid($spdx_license)) {
+						WARN("SPDX_LICENSE_TAG",
+						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
+					}
 				}
 			}
 		}


