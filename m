Return-Path: <joe@perches.com>
Message-ID: <dcf282fa0590654a5e24be79022e1d47fe0cf033.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Fri, 25 May 2018 11:20:55 -0700
In-Reply-To: <6fd70d33-11f7-33dd-3b11-e5031fe46466@cogentembedded.com>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
 <20180524120300.15829-3-sw@simonwunderlich.de>
 <fec8128d-0021-74db-b047-305fb1f70104@cogentembedded.com>
 <2946906.LStWHluSmG@bentobox>
 <6fd70d33-11f7-33dd-3b11-e5031fe46466@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Sven Eckelmann <sven@narfation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Fri, 2018-05-25 at 14:13 +0300, Sergei Shtylyov wrote:
> On 5/25/2018 1:50 PM, Sven Eckelmann wrote:
> 
> > [...]
> > > > --- a/net/batman-adv/Kconfig
> > > > +++ b/net/batman-adv/Kconfig
> > > > @@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
> > > > bool "batman-adv debugfs entries"
> > > > depends on BATMAN_ADV
> > > > depends on DEBUG_FS
> > > > -       default y
> > > > +       default n
> > > 
> > >      N is the default default. :-) You don't need this line.
> > 
> > Hm, looks like this would have to be changed in a lot of places (~782
> > according to `git grep 'default n$'|wc -l` in my slightly outdated linux-
> > next). Do you want to fix it everywhere?
> 
>     No, but we can at least not add the new ones...
> 
> > Might be good to get this integrated
> > in checkpatch.pl when this will become a new policy.
> 
>     Adding Joe Perches. Joe, can you add a check for "default n"?

OK.

This also improves the Kconfig boolean->bool test above
as it's broken for multiple section Kconfig files with
help texts.
---
 scripts/checkpatch.pl | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index baddac9379f0..1f980be4950b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2888,9 +2888,22 @@ sub process {
 
 # discourage the use of boolean for type definition attributes of Kconfig options
 		if ($realfile =~ /Kconfig/ &&
-		    $line =~ /^\+\s*\bboolean\b/) {
-			WARN("CONFIG_TYPE_BOOLEAN",
-			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
+		    $rawline =~ /^\+\s*\bboolean\b/) {
+			if (WARN("CONFIG_TYPE_BOOLEAN",
+				 "Use of boolean is deprecated, please use bool instead.\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bboolean\b/bool/;
+			}
+		}
+
+# discourage the use of 'default n' in Kconfig files as that's the default
+		if ($realfile =~ /Kconfig/ &&
+		    $rawline =~ /^\+\s*default\s+n\s*$/) {
+			if (WARN("CONFIG_DEFAULT_N",
+				 "Unnecessary Use of 'default n'\n" . $herecurr) &&
+			    $fix) {
+				fix_delete_line($fixlinenr, $rawline);
+			}
 		}
 
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&

