Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 9 Feb 2017 11:20:01 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170209102001.GH4629@otheros>
References: <20170129135743.21312-1-linus.luessing@c0d3.blue>
 <20170129135743.21312-6-linus.luessing@c0d3.blue>
 <1502082.JgMhZiz8zA@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1502082.JgMhZiz8zA@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: restructure rebroadcast
 counter into forw_packet API
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

On Mon, Feb 06, 2017 at 11:25:00AM +0100, Sven Eckelmann wrote:
> I like this change but have some questions (but no time to check it). Is cb 
> initialized when a new skbuff is allocated? 

Hm, good point. It looks like skb->cb is set to zero for newly
allocated skbs via a memset down to skb->tail. However, I could
not find anything resetting it to zero in net/core/dev.c, so there
could potentially be an issue.

It seems like network-coding.c might have the same issue already
for skb::cb::decoded.
