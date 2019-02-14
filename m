Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 14 Feb 2019 14:44:52 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190214134452.GA1602@otheros>
References: <20190214124301.6222-1-linus.luessing@c0d3.blue>
 <1687264.beubBEU3KB@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687264.beubBEU3KB@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, David Bauer <mail@david-bauer.net>, Jiri Pirko <jiri@mellanox.com>

On Thu, Feb 14, 2019 at 01:46:35PM +0100, Sven Eckelmann wrote:
> On Thursday, 14 February 2019 13:43:01 CET Linus Lüssing wrote:
> > 
> > +What:           /sys/class/net/<mesh_iface>/mesh/multicast_fanout
> > +Date:           Feb 2019
> > +Contact:        Linus Lüssing <linus.luessing@c0d3.blue>
> > +Description:
> > +                Defines the maximum number of packet copies that may
> > +               be generated for a multicast-to-unicast conversion.
> > +               Once this limit is exceeded distribution will fall
> > +               back to broadcast.
> > +
> 
> No new sysfs config files.

Why? The bridge for instance does the same.
