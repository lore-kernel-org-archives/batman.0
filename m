Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 6 Apr 2021 21:51:22 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: How to mesh over ethernet VLAN?
Message-ID: <20210406195122.GG2742@otheros>
References: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Apr 04, 2021 at 07:52:35PM +0200, Andi Depressivum wrote:
> Hello everybody,
> 
> What's the correct setup to mesh also over an existing ethernet VLAN link?
> 
> My core network with all routers & servers is running on VLAN 3
> (eth0.3 in the routers). How do I have to setup batman-adv to a) mesh
> also over this existing link and b) propagate this VLAN also over
> wireless links. Bridging eth0.3 with bat0.3 and adding eth0.3 also as
> a hardif doesn't work, as it will remove eth0.3 from the bridge.

Right, that is not supported. That goes in the direction of
creating an encapsulating loop. It's best to avoid sharing a link for both
the payload frames and the mesh layer.

One option could be to add an extra VLAN, like VLAN 4, dedicated
for the mesh layer with the batman-adv frames, parallel to the
VLAN 3.

Or if most/all hosts are running batman-adv, so if architecturally
batman-adv is forming the backbone of your network, you could
run batman-adv over this VLAN 3 only. And then either run
batman-adv on the servers themselves or bridge the servers into the
batman-adv mesh on their adjacent mesh router(s).

Regards, Linus
