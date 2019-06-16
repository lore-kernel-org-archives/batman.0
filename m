Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 16 Jun 2019 16:53:16 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH 2/4] batctl: Integrate hardif setting framework
Message-ID: <20190616145316.GB2727@otheros>
References: <20190613191217.28139-1-sven@narfation.org>
 <20190613191217.28139-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613191217.28139-3-sven@narfation.org>
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

On Thu, Jun 13, 2019 at 09:12:15PM +0200, Sven Eckelmann wrote:
> batctl currently supports settings which are either mesh interface or vlan
> specific. But B.A.T.M.A.N. V introduced two additional settings which are
> hard (slave) interface specific.
> 
> To support these, an additional command prefix called hardif is implemented
> for some sysfs commands:
> 
>   $ batctl -m bat0 hardif eth0 ...
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Three thoughts/questions:

Currently we do not allow adding a hard-interface to two meshes,
right? So the "-m bat0" here is redundant?

Have we used the terminology "hard interface" in UI and
documentation before? Maybe it's just me, but I'm wondering
whether the terms "soft interface" and "hard interface" might be a
bit confusing to users, as these days people not only add
hardware interfaces but also virtual ones. And these terms are not
used in other projects (afaik). Maybe just stick to the more commonly
used term "slave interface" and keep "hard" and "soft" interface as
internal?

I'm wondering how it would look like if we were having settings
both applicable to a soft and hard interface. What about using a
"-s <slave-iface>", similar to the "-m <mesh-iface>" instead of
the "hardif" command prefix? So that you could do things like:

$ batctl [-m <mesh-iface>|-s <slave-iface>] multicast_fanout <int>

in the future, for instance.

Regards, Linus
