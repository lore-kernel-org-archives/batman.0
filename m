Return-Path: <linus.luessing@web.de>
Date: Fri, 17 May 2013 03:38:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130517013855.GF22374@Linus-Debian>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <20130516115129.GA27948@pandem0nium>
 <20130516174200.GA22374@Linus-Debian>
 <20130516183132.GA29196@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130516183132.GA29196@pandem0nium>
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

Hi,

On Thu, May 16, 2013 at 08:31:32PM +0200, Simon Wunderlich wrote:
> On Thu, May 16, 2013 at 07:42:00PM +0200, Linus Lüssing wrote:
> > Hi Simon,
> > 
> > On Thu, May 16, 2013 at 01:51:29PM +0200, Simon Wunderlich wrote:
> > > Hey Linus,
> > > 
> > > thanks for working and integrating this patchset!
> > > 
> > > On Sat, May 11, 2013 at 07:23:24PM +0200, Linus Lüssing wrote:
> > > > This set of patches is the first one for a more efficient, group aware
> > > > multicast forwarding infrastructure in batman-adv.
> > > > 
> > > > This initial set mainly consists of the integration of announcing the
> > > > location of multicast listeners via the translation table mechanism to
> > > > be able to find out which batman-adv nodes are actually interested in
> > > > certain multicast traffic. As well as the signalizing of this
> > > > announcement capability via a new multicast TVLV.
> > > > 
> > > > Finally some basic multicast forwarding opitimizations are introduced:
> > > > If all nodes signalized the MLA capability then link-local IPv6 traffic
> > > > will be dropped if there is no interested listener or gets forwarded
> > > > via a batman-adv unicast packet if there is just one node interested
> > > > in the data.
> > > 
> > > I've seen that you've only implemented that for IPv6, would it be possible
> > > to use it for IPv4 too in the current state? (I use some media streaming
> > > thingy at home where I could test ;])
> > 
> > Hmm, I need to think about it. The thing is it looks like IPv4 does
> > not seem to require IGMP. And according to RFC4541, an
> > informational one, link-local IPv4 multicast shoud be excluded as
> > there might be some applications not issuing IGMP reports.
> > 
> > For non-link-local addresses we'd need MRD first, as we'd
> > otherwise miss to forward things to multicast routers.
> > 
> > However when using no bridge, like it is the case now, RFC4541
> > does not apply and we can in fact reliably get and distribute
> > link-local IPv4 multicast addresses as we do not rely on IGMP
> > here... 
> > 
> > One option would be to introduce another flag. But that might
> > become confusing for users, it might not be easy to explain to
> > users why their 224.0.0.123 would be working on raw bat0 but not
> > when they add a bridge and why this would never work. Instead we
> > could wait for the MRD implementation and tell people that
> > 224.0.0.0/24 won't work.
> > 
> 
> Hmm, as far as I read the RFC 4541) (2.1.2, point 2) we should just
> treat 224.0.0.0/24 (which would translate to 01:00:5e:00:00:xx) as
> broadcast - we should do that in any state of the multicast implementation
> IMHO, and are then on the safe side. For all other IPv4 multicast
> addresses we can assume that IGMP is used.

Ok, yes, that's what I thought, too (although like I said before
technically there is the possibility to safely optimize 224.0.0.0/24, too
if there are no bridges involved - but ok, let's forget that thought).

> 
> For the non-link-local IPv4 multicast addresses, could we use the
> current mechanism (drop/unicast/broadcast) by getting the assigned
> multicast addresses? (of course, assuming we have no bridge)

We could - after implementing MRD. The thing is we might have one
or more IPv4 multicast routers in our network. If we are having
two multicast listeners on our link, then everything will be fine,
we will broadcast, multicast routers receive the multicast
packets, too and the multicast data gets routed further. However
with no MRD and if there is just one or no multicast listener
then we'd do the unicast/drop and the multicast router on the link
and any listener more than one hop away would not receive that data
anymore.

> > > 
> > > > 
> > > > For now, these optimizations only apply if all nodes in the mesh have
> > > > no bridge interface on top their bat0 interface. However making it
> > > > possible with bridges, too, and other features are on the roadmap. See
> > > > the according wiki page for details [1].
> > > 
> > > So from what I understand this means:
> > > 
> > >  * multicast support is working for non-bridged interfaces for now, because
> > >    we lack proper multicast router discovery support (MRD) in the bridge code
> > >  --> you told me someone is working on that, or you'll pick up to get this done?
> > 
> > Yes, I had been exchanging some emails with a group of people a
> > few months ago who wanted to implement MRD and a proper IGMP/MLD
> > querier protocol in the bridge code but didn't hear from them again.
> > So yes, I guess I'll pick up on that.
> 
> OK, cool.
> > 
> > 
> > For MRD I was thinking about taking a short-cut for now as
> > implementing would need a few more lines of code. Instead I think
> > I go for detecting whether a querier is on the link both in
> > batman-adv and the bridge code for IPv4 or IPv6 and if not disabling
> > optimizations accordingly and issuing a warning. That way
> > non-link-local IPv6 multicast traffic could be optimized already
> > for instance if running an mrd6 instance in userspace which
> > already performs both MLD querying and MRD.
> > 

Sorry, I ment: "For MLD querying I was...". mrd6 does perform MRD,
so sending things like multicast router advertisements. But
bridges or batman-adv would still need to parse these
advertisements and should send multicast router solicitations
(e.g. when an interface comes up) to be able to quickly determine
which bridge ports or nodes have multicast routers and want the
non-link-local multicast traffic.

> 
> Hmm, sorry I still get a little confused in that MRD/MLD/IGMP terminology.
> So as I understand there might be a userspace component which does the MLD/MRD
> instead of the kernel?

Yes, the layer 3 multicast routing table is in the kernel, but it
is configured from userspace from daemons like mrd6. And mrd6 also
does some non-performance critical protocol stuff like the MLD
Querier protocol and the MRD multicast router advertisements like
I said above.

> Also, is it required to get implement MRD/MLD specifically
> in batman-adv or bridges, or would it be possible to use a "general" approach
> which could be used for any interface to emit/exchange these kind of messages?

The MLD querier is something which only makes sense to me in case
of multicast snooping bridges and I don't see any benefit in having
it anywhere else. If there are just the plain interfaces with no
multicast router then you don't need an MLD querier (and in fact
no MLD reports from the listeners either). If there's just
batman-adv with no bridges, then you don't need it either.
Although...

There is one use-case where a more general approach might be of
interest: Wireless interfaces - it might be of interest for the
mac80211 to know whether there is a listener (or router) behind
the link provided by your wlan0 device. The wifi driver could then
decide to refrain from broadcasting a multicast packet or to use
the (minimum) bitrate of just the(se) listener(s) (/router(s)).
Or maybe a drop/unicast/flood on an eth0 itself might be nice, too,
especially if there is a large switch/hub connected to it.

Although that'd probably be awesome to have, I think it's easier
to just have the MLD querier in the bridge code for now (especilly
as there already is some MLD querier code in the bridge - though
it is so incomplete that it got disabled in April 2012 because of
causing issues).

Hm, for the MRD RA parsing and MRD RS I thought about implementing
that both in the bridge and batman-adv code (it's about 300
lines of C++ code in mrd6). Not sure how easy it'd be to implement
a more general approach on top of a Linux netdev for instance.
Would need to check that.

> 
> Sorry if I ask stupid questions. :)
> 
> Maybe some example or architecture overview (could be put on the wiki page) would
> help?

I guess you mean some visualizaton with things like simple
devices, bridge, batman-adv, maybe various kinds of multicast
types (e.g. scope == link-local vs. scope > link-local, IPv6 transient
vs. IPv6 well-known) and the according RFCs? Hm, not quite sure
how that could look like would need to think about it - or maybe
you have some idea about how you think that could/should look
like?

> 
> > > 
> > >  * the current optimization is to handle multicast like:
> > >    * no listener - drop
> > >    * one listener - unicast
> > >    * more listener - broadcast
> > >  --> I think that is a good and simple optimization. :) The "tracker" packets
> > >      can come later (as shown in your roadmap). This might require to announce
> > >      that tracker packets are supported in the TVLV?
> > 
> > Yes, we'll probably need to add another capability flag to the
> > multicast TVLV.
> > 
> 
> OK. We could also increase the version number of the TVLV and interpret
> both versions in newer multicast implementations, but if we already know
> that we can define this information in the current implementation.

But a newer TVLV version would break compatibility for older
batman-adv versions, they wouldn't recognize the newer TVLV
version. Or a node would need to add TVLVs for both versions to
its OGM. But that'd be some more overhead compared to just adding
another flag.

> 
> > > 
> > > Would you consider Antonios comments and update your patchset? I would like to
> > > test it in the next days ...
> > 
> > Yes, I will. I had written some comments for the comments on IRC,
> > but I guess it'll be better to write them here on the list again.
> > 
> 
> Mailing list would be better, yes. Thanks. :)

Done :).

> 
> > > 
> > > Thanks,
> > > 	Simon
> > 
> > Another thing I was thinking about conceptually yesterday was
> > whether we should use more refined flags instead of just
> > MULTICAST_LISTENER_ANNOUNCEMENTS for everything (non-link-local
> > IPv4, all IPv6 except the all-nodes address).
> > 
> > That way we could for instance already add some cases for when to
> > use the multicast optimizations when having a bridge, for
> > instance:
> > 
> > When batman-adv detects that there is an MLD querier and if all
> > nodes have a MULTICAST_LISTENER_ANNOUNCEMENTS or
> > MLA_IPV6_TRANSIENT_LINK_LOCAL flag it could  already
> > optimize link-local, transient IPv6 multicast traffic
> > without needing to modify anything in the bridge code except the
> > addition of the export which was already posted as an RFC on the
> > bridge mailing list.
> > 
> > Hm, again will need to think about that. Whether the extra
> > conceptual complexity is okay because of being able to add some
> > more use-cases with less code in small chunks already.
> 
> Hmm, again I'm not completely sure to follow, but the idea here is
> to enable functionality when having a userspace MLD instead of
> the (planned) bridge MLD stuff?

Yes, that would be the idea.

> 
> If we need the bridge MLD stuff anyway (to have the full feature set
> etc), I'd rather not do more intermediate steps which might be
> obsolete later. However, if the userspace MLD thing is equivalent
> feature-wise than this might be interesting to do.

Hm, don't know. I was thinking that most setups I know of involve
bridges on top of bat0 and to be able to make use of any multicast
optimizations in batman-adv in case of such bridging we need an
MLD querier on the link. Implementing a proper MLD querier might
need several iterations over the bridge / netdev mailing lists and
might therefore need quite some time. During that time those
setups won't be able to make any use of these optimizations.

Unless taking the suggested short-cut which shouldn't be that
difficult to implement, I think, then these bat0+bridge setups
could already enjoy some multicast optimizations and such mesh
networks might already be able to play with multicast streams as I
think updating and merging the tracker packet patches will be done
some time before getting MLD querier bridge code upstream.
(but maybe I'm estimating all this wrong, dunno)

> 
> Cheers,
> 	Simon

Cheers, Linus
