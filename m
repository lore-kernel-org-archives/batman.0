Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 23 Mar 2019 04:47:34 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190323034734.GF22805@otheros>
References: <20190216215050.11542-1-linus.luessing@c0d3.blue>
 <1866651.s4yD58eI2F@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1866651.s4yD58eI2F@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Add multicast-to-unicast
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, David Bauer <mail@david-bauer.net>

On Sun, Mar 17, 2019 at 11:11:10AM +0100, Sven Eckelmann wrote:
> I am also not sure what in mind here for the limit? The only thing
> which comes to my mind right now is that we have a fanout of something
> low (16) and the precondition test succeeded because it can only find 16 
> entries. And in the meantime, 100 or more new entries are added. In this 
> situation, you would only send to 32 neighbors, right?

Right, that's the situation I had in mind. If the number of
transmissions were growing too large somehow to limit them.

On the other hand, now that you reiterate this maybe this is such
a minor case that it is not worth bothering for now.

Hm, I think I'll remove these intermediate limit checks to
simplify things. So that we only check once in batadv_mcast_forw_mode()
for the mcast_fanout.
