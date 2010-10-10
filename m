Return-Path: <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 16:49:30 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101010144930.GA1843@Sellars>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-4-git-send-email-linus.luessing@web.de>
	<201010101453.52594.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201010101453.52594.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Make number of
 (re)broadcasts configurable via sysfs
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

On Sun, Oct 10, 2010 at 02:53:51PM +0200, Marek Lindner wrote:
> On Sunday 10 October 2010 06:30:00 Linus Lüssing wrote:
> > Depending on the scenario, people might want to adjust the number of
> > (re)broadcast of data packets - usually higher values in sparse or lower
> > values in dense networks.
> 
> Is there a good reason to change this value at runtime or would a define be 
> enough ? I just get scared when we add too many options that almost nobody 
> cares about.
Well, as said before, in some cases the default value of 3 might
be too much, in other cases too less, depending on the topology.
However, you might know the kind of topology you have in advance
and would like to tweak that without having to know how to for
example rebuild a complete image and reflashing it on all
devices. You might want to test different values for your topology
for tweaking, without having to reflash / reload the kernel module
on all devices.

I also don't think too many configuration options in sysfs are
that much of a problem. There are also a dozen options for
tweaking IP in /proc/sys/net which nearly no one uses. But if
someone might need it, (s)he'll be very pleased to not having to
recompile and restart the whole kernel for that (or a kernel module
in our case).

The average user who might be scared of too many configuration
options will be using batctl anyway, won't (s)he? So I'd rather
plead to add tweaking options to the sysfs, but omitting them in
batctl. Or what do you think?
> 
> In other words: What is the use case ? Can we handle it by some kind of auto-
> detection ?
Sure we could, but then we'd need some more information about the
neighbourhood, i.e. with something like a seperate neighbor
discovery protocol giving 2-hop-neighbourhood information.
Otherwise a node would probably usually send the maximum amount of
rebroadcasts as there might be a node in the far distance with a
very low tq-value. But that'd require much more effort to
implement then these couple of lines :).

Thanks for reviewing

Cheers, Linus
> 
> Regards,
> Marek
> 
