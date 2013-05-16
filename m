Return-Path: <linus.luessing@web.de>
Date: Thu, 16 May 2013 19:42:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130516174200.GA22374@Linus-Debian>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <20130516115129.GA27948@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130516115129.GA27948@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,

On Thu, May 16, 2013 at 01:51:29PM +0200, Simon Wunderlich wrote:
> Hey Linus,
> 
> thanks for working and integrating this patchset!
> 
> On Sat, May 11, 2013 at 07:23:24PM +0200, Linus Lüssing wrote:
> > This set of patches is the first one for a more efficient, group aware
> > multicast forwarding infrastructure in batman-adv.
> > 
> > This initial set mainly consists of the integration of announcing the
> > location of multicast listeners via the translation table mechanism to
> > be able to find out which batman-adv nodes are actually interested in
> > certain multicast traffic. As well as the signalizing of this
> > announcement capability via a new multicast TVLV.
> > 
> > Finally some basic multicast forwarding opitimizations are introduced:
> > If all nodes signalized the MLA capability then link-local IPv6 traffic
> > will be dropped if there is no interested listener or gets forwarded
> > via a batman-adv unicast packet if there is just one node interested
> > in the data.
> 
> I've seen that you've only implemented that for IPv6, would it be possible
> to use it for IPv4 too in the current state? (I use some media streaming
> thingy at home where I could test ;])

Hmm, I need to think about it. The thing is it looks like IPv4 does
not seem to require IGMP. And according to RFC4541, an
informational one, link-local IPv4 multicast shoud be excluded as
there might be some applications not issuing IGMP reports.

For non-link-local addresses we'd need MRD first, as we'd
otherwise miss to forward things to multicast routers.

However when using no bridge, like it is the case now, RFC4541
does not apply and we can in fact reliably get and distribute
link-local IPv4 multicast addresses as we do not rely on IGMP
here... 

One option would be to introduce another flag. But that might
become confusing for users, it might not be easy to explain to
users why their 224.0.0.123 would be working on raw bat0 but not
when they add a bridge and why this would never work. Instead we
could wait for the MRD implementation and tell people that
224.0.0.0/24 won't work.

> 
> > 
> > For now, these optimizations only apply if all nodes in the mesh have
> > no bridge interface on top their bat0 interface. However making it
> > possible with bridges, too, and other features are on the roadmap. See
> > the according wiki page for details [1].
> 
> So from what I understand this means:
> 
>  * multicast support is working for non-bridged interfaces for now, because
>    we lack proper multicast router discovery support (MRD) in the bridge code
>  --> you told me someone is working on that, or you'll pick up to get this done?

Yes, I had been exchanging some emails with a group of people a
few months ago who wanted to implement MRD and a proper IGMP/MLD
querier protocol in the bridge code but didn't hear from them again.
So yes, I guess I'll pick up on that.


For MRD I was thinking about taking a short-cut for now as
implementing would need a few more lines of code. Instead I think
I go for detecting whether a querier is on the link both in
batman-adv and the bridge code for IPv4 or IPv6 and if not disabling
optimizations accordingly and issuing a warning. That way
non-link-local IPv6 multicast traffic could be optimized already
for instance if running an mrd6 instance in userspace which
already performs both MLD querying and MRD.

> 
>  * the current optimization is to handle multicast like:
>    * no listener - drop
>    * one listener - unicast
>    * more listener - broadcast
>  --> I think that is a good and simple optimization. :) The "tracker" packets
>      can come later (as shown in your roadmap). This might require to announce
>      that tracker packets are supported in the TVLV?

Yes, we'll probably need to add another capability flag to the
multicast TVLV.

> 
> Would you consider Antonios comments and update your patchset? I would like to
> test it in the next days ...

Yes, I will. I had written some comments for the comments on IRC,
but I guess it'll be better to write them here on the list again.

> 
> Thanks,
> 	Simon

Another thing I was thinking about conceptually yesterday was
whether we should use more refined flags instead of just
MULTICAST_LISTENER_ANNOUNCEMENTS for everything (non-link-local
IPv4, all IPv6 except the all-nodes address).

That way we could for instance already add some cases for when to
use the multicast optimizations when having a bridge, for
instance:

When batman-adv detects that there is an MLD querier and if all
nodes have a MULTICAST_LISTENER_ANNOUNCEMENTS or
MLA_IPV6_TRANSIENT_LINK_LOCAL flag it could  already
optimize link-local, transient IPv6 multicast traffic
without needing to modify anything in the bridge code except the
addition of the export which was already posted as an RFC on the
bridge mailing list.

Hm, again will need to think about that. Whether the extra
conceptual complexity is okay because of being able to add some
more use-cases with less code in small chunks already.


Cheers, Linus
