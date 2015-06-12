Return-Path: <bjo@nord-west.org>
Message-ID: <1434122431.24070.3.camel@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Fri, 12 Jun 2015 17:20:31 +0200
In-Reply-To: <2dca4d7a596a3a7f250b2ef62cf9c3ec@hilses.de>
References: <1434025163.1056.73.camel@nord-west.org>
 <2dca4d7a596a3a7f250b2ef62cf9c3ec@hilses.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Mesh hickups with 2014.3
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

Hi hwh,




> Continuously? So that directions seems fine then.

Yep.




> What does "not possible" mean? There's no reply?

No reply, yes.




> So it's just the gateway that can't reach the "router"?

Correct.

> > Public-IPv6 is announced from a gateway via radvd into the mesh.
> 
> So even in that direction, NDP is fine. Seems only ICMPv6 echo 
> requests 
> are somewhat different then?

ip -6 neigh show says "FAILED".

> > Unfortunately we are out of ideas where we can search for the 
> > reason.
> 
> Look what's actually on the wire on both ends? Tcpdump and batctl 
> tcpdump?
> 
> 

On the gateway, there are neighbor solicitations from the "router" and
advertisements from the gateway.

At the moment, it's not possible to access the "router" to take a look
what's going wrong there.

Regards
bjo
-- 
xmpp bjo@schafweide.org 



