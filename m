Return-Path: <andrew@lunn.ch>
Date: Wed, 26 Aug 2009 12:47:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090826104706.GG20818@lunn.ch>
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261001.31814.sven.eckelmann@gmx.de>
	<200908261651.16980.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908261651.16980.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Breaking long lines...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

> > I found also some other things and also told that Marek - but I think that
> > not everything was included in the patch I send some weeks ago. Maybe it
> > was only to break printk statements to fit in 80 chars per line, but I am
> > not sure right now.
> 
> Yes, you found a way to break a long string into smaller pieces although I 
> can't quite remember how you did it.  ;-)

ANSI C/C++ allows:

"foor"
"bar"

and the compiler will glue the parts back together as "foobar". 

However, i often don't like the resulting code layout. I also think
there might be a bug in checkpatch. The relevant code is:

#80 column limit
                if ($line =~ /^\+/ && $prevrawline !~ /\/\*\*/ &&
                    $rawline !~ /^.\s*\*\s*\@$Ident\s/ &&
                    $line !~ /^\+\s*printk\s*\(\s*(?:KERN_\S+\s*)?"[X\t]*"\s*(?:,|\)\s*;)\s*$/ &&
                    $length > 80)
                {
                        WARN("line over 80 characters\n" . $herecurr);
                }

my perl is not good, but it appears to be looking for KERN_, eg
KERN_ERR, KERN_WARNING etc, and maybe should be ignoring such lines?

          Andrew
