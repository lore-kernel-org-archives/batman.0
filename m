Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 29 Jun 2015 04:52:48 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150629025248.GC2527@odroid>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
 <2472003.5ybaWVxMcq@voltaire> <20150628035913.GB2398@odroid>
 <5065799.yHsM5BUa9O@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5065799.yHsM5BUa9O@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/1] batman-adv: Always flood IGMP/MLD
 reports
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Jun 28, 2015 at 09:21:34PM +0800, Marek Lindner wrote:
> On Sunday, June 28, 2015 05:59:14 Linus Lüssing wrote:
> > > I am not quite clear on what the patch does. It helps to support a feature
> > > that is yet to come (upcoming bridge integration) or improves the
> > > situation
> > > today ?
> > 
> > The former. It's not fixing or improving anything for the current
> > implementation.
> 
> If this patch isn't doing anything (for now) maybe it should be merged when it 
> becomes useful ?

Hm, good point. The intention was to keep things in small chunks for
easy reviewing. With the unicasted reports approach there were
more lines of code changed and an actual (but broken /
insufficient) change / "improvement". Now it got rather small with
no practical advantage so far. So yes, could be added to the
multicast-bridge patchset.

> 
> 
> > > > +#if IS_ENABLED(CONFIG_IPV6)
> > > > 
> > > >  	case ETH_P_IPV6:
> > > >  		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
> > > >  		
> > > >  							 is_unsnoopable);
> > > > 
> > > > +#endif
> > > > 
> > > >  	default:
> > > >  		return -EINVAL;
> > > >  	
> > > >  	}
> > > 
> > > This hunk seems not really related to the patch itself ?
> > 
> > I think it's necessary for the new ipv6_mc_check_mld() which isn't
> > there if building a kernel without any IPv6 support.
> 
> You may want to send a separate patch then ? This change seems unrelated to 
> the rest.

The use of ipv6_mc_check_mld() is added in this patch. I think
it's necessary in this patch?

I'm not quite sure if I understand. If I move this "#if" and the
one around the function definition to a seperate patch after this
one then I get for net-next (with the version number in the
Makefile changed to 4.2) with CONFIG_IPV6 disabled:

"WARNING: "ipv6_mc_check_mld" [/home/tux/dev/batman-adv-t_x/net/batman-adv/batman-adv.ko] undefined!"

The "#if"'s aren't necessary prior this patch, so making an extra
patch before this patch here doesn't make sense to me either. The
"#if's" become necessary with the changes introduced in this
patch.


> 
> 
> > > By removing mcast v1 you effectively are breaking compatibility with all
> > > nodes running v1 and require everyone to upgrade to v2.
> > 
> > No, no v1 nodes are required to upgrade. v1 and v2 nodes are still
> > able to communicate. v1 nodes (like any pre v1 node) might downgrade the
> > mesh to a mcast-optimizations-disabled state for now though, yes.
> 
> I do understand that 'normal' packet exchange is not affected. However, the 
> TVLVs were introduced with the intend of maintaining best possible 
> compatibility with future versions. With the first tvlv version bump we already 
> require upgrading everyone or compatibility is already broken ? Is there 
> really nothing we can do ? v2 could at least be compatible to v1 ?

Hm, you mean while v1 nodes would downgrade a bridged v2 setup,
whether we could at least keep things compatible in a non-bridged
setup with a mix of v1 and v2 nodes?

The alternative to bumping the version number would be to introduce
another flag into the mcast tvlv and keep counters and lists similar
to the num_disabled or want_* ones. So maybe about 80 more lines of
code and additional state and complexity to maintain.

My current feeling is that these 80 lines of code would never be
used / useful for someone:

The only benefit of this approach arises if someone is using a
non-bridged mesh of v2014.2.0 to v2015.0 without any v2014.4.0 or
v2014.1.0 nodes. For one thing there aren't many people using
non-bridged setups I think. For another these few people probably
don't rely on the multicast feature since without bridges there
usually isn't that much multicast traffic to safe with the
current feature.

> 
> 
> > We cannot safely use the multicast optimizations with bridges if
> > there are nodes which do not handle reports properly. The bump
> > isn't needed for any packet changes but the internal, local behaviour
> > of a node.
> > 
> > I haven't heard of anyone using the multicast optimization feature
> > in practice yet (that is, a setup without bridges), so I think it
> > is safe to do a version bump?
> 
> A version bump for a feature which does not do anything useful yet (see my 
> initial question) ? How likely is it that we will need another version bump by 
> the time this feature does become useful ?

Hopefully none ;). The next revision for the multicast bridge
integration is ready for submission in the branch
linus/multicast-bridge.

Of coures, if more people would like to dig into the conceptual
part of IGMP/MLD and the planned integration with batman-adv as
described on the wiki, I'd definitely welcome that.


But I'm starting to get a good feeling about this :P. The concept
isn't easy but it's now been thought about and discussed a lot
between Simon and me over the last two years.

I'm also angry with myself that I missed this issue before, but I
think it wasn't really a trivial one either. On the plus side,
it made me really paranoid and I probably got over the whole
concept and the wiki pages another ten times to make sure there
isn't another one year set back because of having missed
something. So I can't say with 100% certainity that something else
was missed and could introduce another version bump but I'm also
quite confident, that it's rather unlikely that we might have
missed another such issue.

> 
> 
> > Hm, good question :). Need to recheck, I vaguely remember having
> > had issues with the IP header parsing due to unset skb network
> > headers.
> 
> If it is related to this patch please add a comment. The change is non-
> obvious.

Oki doki.

> 
> Cheers,
> Marek

Cheers, Linus
