Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 16 Nov 2014 11:19:55 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20141116101955.GC2469@odroid>
References: <069201cffe76$c6b720c0$54256240$@dslx.net>
 <20141116062826.GA2469@odroid> <2704279.HXZgGAggkv@sven-edge>
 <1448250.Hgypd91p29@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1448250.Hgypd91p29@sven-edge>
Subject: Re: [B.A.T.M.A.N.] Current OpenWrt build
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Nov 16, 2014 at 10:14:43AM +0100, Sven Eckelmann wrote:
> Yes, there are at least two known problems in batman-adv which are now fixed
> in maint and can be cherry picked by you. Otherwise these problems
> would enable multicast optimization when some nodes have bridges (which they
> shouldn't). This is a bug a not missing feature. So it is still valid that
> multicast_mode is enabled by default.
> 
> I would guess that you can either disable multicast_mode  or apply the
> patches.

Correct.

> 
> > Are there "only" missing patches/issues in the bridge code (the ones you've
> > linked to in the other mail [1]) of OpenWrt which breaks batman-adv with
> > multicast_mode? If yes, why is multicast_mode enabled by default in
> > batman-adv?
> 
> I cannot really answer this and will leave it to Linus.

Turning off multicast_mode is only intended for debugging
purposes at the moment. batman-adv should never break anything by
having multicast_mode enabled (which unfortunately, currently is
not the case for a release / OpenWRT but should be again after the two
multicast counter fixes which just hit the maint-branch trickled
through).

> 
> > Are there "only" missing patches/issues in the bridge code (the ones you've
> > linked to in the other mail [1]) of OpenWrt which breaks batman-adv even
> > without multicast_mode?
> 
> I cannot really answer this and will leave it to Linus.

Nope, the bridge patches in OpenWRT don't break the concept of the
multicast optimizations or multicast handling in general in
batman-adv. The issues of the state of the bridge code in BB are
unrelated to batman-adv and happen with any other enslaved network
device, too.
