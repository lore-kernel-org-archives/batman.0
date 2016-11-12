Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 12 Nov 2016 11:46:24 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161112104624.GE3151@otheros>
References: <CAA_JP8UVeCpytzkirob9WsOA0BOkhVgZyA-Wa1=p+PV0hgRx8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA_JP8UVeCpytzkirob9WsOA0BOkhVgZyA-Wa1=p+PV0hgRx8w@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] MTU for batman-adv w/ vlans?
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

On Fri, Nov 11, 2016 at 07:26:36AM -0700, dan wrote:
> I'm not 100% clear on how batman-adv works with vlans, so excuse me if
> I've taken a wrong path.
> 
> 
> I have a small 2 radio mesh node with 1 ethernet port for non-mesh
> access.  wlan0 and wlan1 in bat0, bat0 and eth0 in mesh-bridge.
> 
> MTU is 1532 on WLAN0.
> 
> If I want a VLAN to pass through the eth0 interface as if it were
> trunk, what needs to be done?
> my thought was, increase WLAN0 MTU to 1536 and eth0 to 1504....

(I had a similar MTU/fragmentation discussion with Marek recently, so
now I can pretend to be smart :D)

For BATMAN_V, if you want VLANs to pass without fragmentation,
then you need to increase the MTU of WLAN0 *and* eth0 to 1536, so +4
bytes compared to what "dmesg" currently suggests, yes.

If you do not care about fragmentation, then the default 1500
should "just work", both for wlan0 and eth0, too.


> will that work?  or do I need to create a vlan  bat0.1 and eth0.1 and
> bridge them?

Depends on what you want. Do bridged-in clients do the
VLAN-tagging on their own? Or do you want the mesh node to tag incoming,
not yet tagged frames?

Or do you just want to split one physical wire into multiple, virtual
ones? Then you'd need VLANs on eth0 (and would add eth0.1 to
batman-adv instead of eth0).


I guess, the question is, what is the original intent. What made you
you think about using VLANs in the first place?

Regards, Linus
