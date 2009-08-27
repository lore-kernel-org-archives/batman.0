Return-Path: <bernd@firmix.at>
From: Bernd Petrovitsch <bernd@firmix.at>
In-Reply-To: <200908261651.16980.lindner_marek@yahoo.de>
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261001.31814.sven.eckelmann@gmx.de>
	<200908261651.16980.lindner_marek@yahoo.de>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 15:57:25 +0200
Message-Id: <1251381445.4430.60.camel@gimli.petrovitsch.priv.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
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

On Mit, 2009-08-26 at 16:51 +0800, Marek Lindner wrote:
> On Wednesday 26 August 2009 16:01:27 Sven Eckelmann wrote:
[...]
> > I found also some other things and also told that Marek - but I think that
> > not everything was included in the patch I send some weeks ago. Maybe it
> > was only to break printk statements to fit in 80 chars per line, but I am
> > not sure right now.
> 
> Yes, you found a way to break a long string into smaller pieces although I 
> can't quite remember how you did it.  ;-)

As a b.a.t.m.a.n@ lurker but kernel-ML reader (not necessarily LKML, but
the more specialized ones):
- moving the ML to vger.kernel.org was for several folks the simple way
  to open the list without the risk of daily countless spam (and there
  is next to no spam on these lists).
  Yes, the list (or another list) is than hosted elsewhere.
  But open-only-for-subscriber lists tend to be - at least - criticized
  and - IMHO probably - excluded from the MAINTAINERS file[0].
  I don't know/have no opinion on if it makes sense to make a new list
  (@vger.) primarily for the layer 2 "variant" (and it's driver
  actually).
  Current people will probably subscribe that too (and if you sort it
  into the same folder, it also looks almost like now). Perhaps the
  admins there even accept a list with to-be-subscribed email addresses
  (which makes sense for list migrations. Auto-subscribed email 
  addresses get an email anyways).
- the "80 chars per line" rule in checkpatch.pl is one of the most (if
  not *the* most) debated one. There even were requests/patches to
  simply remove that check. Or at least deactivate it per default.
  (Core) Kernel people prefer code readability over such too simple
  "technical" limits[1].
  For simple strings in "printk()"[1]: IMHO ignore the warning and
  reject patches from random people which take "checkpatch" output and
  silence it with the plain simple reason: "what exactly is it
  unreadable now?".
Disclaimer: Feel free to ignore the above (and I'm the last to decide
such issues here).

	Bernd

[0]: Accept it - it's LKML policy.
[1]: Personally it would bury the historical "80" and - in times with
     wide-screen monitors replace it with at least "132" (and I tend to
     have > 6 xterms on each virtual desktop) - at least in
     checkpatch.pl. YMMV .....
[2]: I didn't look at the source.
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

