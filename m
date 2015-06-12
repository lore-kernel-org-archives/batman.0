Return-Path: <hw@haveyouseenthiscat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jun 2015 22:39:27 +0200
From: Hans-Werner Hilse <hw@haveyouseenthiscat.de>
In-Reply-To: <1434122431.24070.3.camel@nord-west.org>
References: <1434025163.1056.73.camel@nord-west.org>
 <2dca4d7a596a3a7f250b2ef62cf9c3ec@hilses.de>
 <1434122431.24070.3.camel@nord-west.org>
Message-ID: <ab2fa29c0bc05ca697c3a389bd4980cc@hilses.de>
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

Hi,

Am 2015-06-12 17:20, schrieb Bjoern Franke:
>> > Public-IPv6 is announced from a gateway via radvd into the mesh.
>> 
>> So even in that direction, NDP is fine. Seems only ICMPv6 echo
>> requests
>> are somewhat different then?
> 
> ip -6 neigh show says "FAILED".

My bad: I planned to write "RA" instead of NDP. In fact, NDP seems to be 
failing, as you have determined.

>> Look what's actually on the wire on both ends? Tcpdump and batctl
>> tcpdump?
> 
> On the gateway, there are neighbor solicitations from the "router" and
> advertisements from the gateway.

The advertisements are fine then, good.

I've seen the behaviour you're looking at with Linux bridge code and 
icmp snooping. Mind you: with *activated* icmp snooping. The NDP does 
not (does it?) register ICMP multicast with listener notices (or does it 
once, too early?), and the bridge code does then not consider the 
relevant end that should receive NDP traffic a destination for the 
multicast traffic that should have gotten there.

Of course, the question that evolves it whether the solicitation is 
actually received, then handled - answered to - by the gateway.

Did any network bridges come into play on the gateway(s) that hadn't 
been there before?

-hwh
