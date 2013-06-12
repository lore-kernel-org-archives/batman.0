Return-Path: <linus.luessing@web.de>
Date: Wed, 12 Jun 2013 22:33:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130612203325.GA28709@Linus-Debian>
References: <1370848318-18755-1-git-send-email-linus.luessing@web.de>
 <20130612101411.GA13323@pandem0nium>
 <20130612122714.GA27583@Linus-Debian>
 <20130612124437.GA14493@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130612124437.GA14493@pandem0nium>
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

On Wed, Jun 12, 2013 at 02:44:38PM +0200, Simon Wunderlich wrote:
> On Wed, Jun 12, 2013 at 02:27:14PM +0200, Linus Lüssing wrote:
> > On Wed, Jun 12, 2013 at 12:14:11PM +0200, Simon Wunderlich wrote:
> > > Hello Linus,
> > > 
> > > I gave it a try - but there seems something off. What I did is:
> > >  * apply your patches on 3b38a80 - multicast was enabled by default
> > >  * start 2 VMs directly connected
> > >  * ping6 -I bat0 ff02::1
> > > 
> > > I only got a reply locally, but not from the peer. When I disabled
> > > multicast, I got two replies from the local host and the peer.
> > > 
> > > As far as I have tracked the problem down, it appears that
> > > batadv_mcast_forw_mode() returns 1 correctly, but the packet is dropped
> > 
> > Ok, found a bug - the return 1 is actually incorrect. You've
> > chosen the one multicast address where no optimization is
> > conceptually possible. ff02::1 is the only link-local IPv6
> > multicast address which should return a BATADV_FORW_ALL (0)
> > instead.
> 
> Ah, wonderful, and I thought I found a testcase. :D

Well, it was a testcase I hadn't used and you found a bug by that
;).

> 
> Can you advise how the feature can be tested then, practically?
> I guess I'll need to add some routes and ping6 another address?

I was usually using 'ip maddr show' to check which address isn't
in use yet, then I use something like 'ping6 ff02::3%bat0' which should
by default result in no reply.

Then I'd start adding listeners with this tiny C code snippet:
http://pastebin.com/fg9z8z5b on various nodes
(because I didn't find any simple, tiny command line program to do
just that yet).

You'd then get ICMP replies from the according nodes and I checked
via tcpdump that the ICMP packets were forwarded correctly via
unicast or broadcast.


And since "batman-adv: Add dummy soft-interface rx mode handler"
I'm not using that C code snippet that much anymore, but just
adding listeners via "ip maddr add 33:33:00:00:00:03 dev bat0"
for instance. And just checking via tcpdump (since you won't get
any ICMP replies) and the 'batctl tg' output.
