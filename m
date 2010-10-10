Return-Path: <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 21:00:37 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101010190037.GA2240@Sellars>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-2-git-send-email-linus.luessing@web.de>
	<201010101442.08908.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201010101442.08908.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Introduce generic
 BAT_ATTR_* macros
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Marek,

actually, there were two reasons for renaming that I guess. One
was out of "laziness" and I wanted to keep the number of
parameters of a BAT_ATTR_* macro as less as possible. Otherwise
I'd have to have another field, one for stating the name in sysfs
and one for the name in bat_priv.

I then was wondering why the names between sysfs and bat_priv
shouldn't be the same instead (or +_enabled for switch/bool
attributes). I could have renamed the part in bat_priv to
aggregate_ogms_enabled but found that a little long (the same for
fragmentation_enabled). Or the _enabled parts could be removed in
bat_priv, but making it less obvious, what kind of values they
might take.

So I thought that just aggregation might be a good trade-off. And
that anyone who might be confused by the names, not knowing what
they might be used for, should use batctl instead (and its manpage
for explanations).

Or would anybody prefer another solution (of the ones described
above)?

Cheers, Linus

On Sun, Oct 10, 2010 at 02:42:08PM +0200, Marek Lindner wrote:
> On Sunday 10 October 2010 06:29:58 Linus Lüssing wrote:
> > Additionally, the sysfs entries "aggregate_ogms" and "fragmentation"
> > get renamed to "aggregation" and "frag" for consistency reasons, they
> > match the *_enabled parts in bat_priv now.
> 
> I don't quite understand why you want to rename these names. I like the 
> "aggregate_ogms" as it makes clear what is being aggregated. 
> 
> Please keep in mind that the kernel people won't be happy if we modify the 
> user space API. Right now, it is less of an issue but once we leave the 
> staging tree it is mostly unchangeable.
> 
> Regards,
> Marek
> 
