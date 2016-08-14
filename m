Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 14 Aug 2016 19:28:43 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160814172843.GE8599@otheros>
References: <1470928381.10121.0.camel@gmail.com>
 <20160811154723.GJ4483@otheros>
 <1470931774.10121.10.camel@gmail.com>
 <20160811163153.GK4483@otheros>
 <1470988256.16102.4.camel@gmail.com>
 <20160814172128.GD8599@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160814172128.GD8599@otheros>
Subject: Re: [B.A.T.M.A.N.] is the multicast performance throttled?
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

On Sun, Aug 14, 2016 at 07:21:28PM +0200, Linus Lüssing wrote:
> Second guess (which is probably it :-) ): In general, batman-adv
> (re)broadcasts a multicast packet three times on an interface. To
> ensure proper reception even over multiple hops.

PS: As you are compiling batman-adv yourself, you might want to
try different values for BATADV_NUM_BCASTS_WIRELESS in main.h to
(in)validate this hypothesis.
