Return-Path: <dreamtrick@gmail.com>
Message-ID: <1471284198.10713.0.camel@gmail.com>
From: Ignacio Quezada <dreamtrick@gmail.com>
Date: Mon, 15 Aug 2016 20:03:18 +0200
In-Reply-To: <20160814172843.GE8599@otheros>
References: <1470928381.10121.0.camel@gmail.com>
 <20160811154723.GJ4483@otheros> <1470931774.10121.10.camel@gmail.com>
 <20160811163153.GK4483@otheros> <1470988256.16102.4.camel@gmail.com>
 <20160814172128.GD8599@otheros> <20160814172843.GE8599@otheros>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,


> > Second guess (which is probably it :-) ): In general, batman-adv
> > (re)broadcasts a multicast packet three times on an interface. To
> > ensure proper reception even over multiple hops.
> 
> PS: As you are compiling batman-adv yourself, you might want to
> try different values for BATADV_NUM_BCASTS_WIRELESS in main.h to
> (in)validate this hypothesis.

This was indeed "the problem". Setting that value to 1 allowed much
more throughput. Is the value 3 just an arbitrary number to "ensure"
reliability? Because that would mean that if dropping some multicast
packets now and then is not really an issue, I could just set this to 1
in my case.

--
MVH
Ignacio Quezada
