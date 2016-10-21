Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 21 Oct 2016 08:03:58 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161021060358.GH32033@otheros>
References: <20161020215614.GG32033@otheros>
 <123097163.ZmppEksrjh@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <123097163.ZmppEksrjh@voltaire>
Subject: Re: [B.A.T.M.A.N.] Add VLAN tag size to MTU recommendation?
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

On Fri, Oct 21, 2016 at 11:53:44AM +0800, Marek Lindner wrote:
> 
> Hi,
> 
> On Thursday, October 20, 2016 11:56:14 PM HKT Linus Lüssing wrote:
> > First of all, just wanted to forward this awesome diagram
> > regarding MTUs in Gluon-Setups which Freifunk Hamburg created
> > 
> > :D :
> > https://twitter.com/ohrensesselnet/status/789176399655350272
> 
> this link leads to a router pic ?
> Found the diagram you were (probably) referring to by searching in his/her 
> tweetface history. 

Urgh, I'm very, very sorry, yes, I ment this one instead :( :

https://twitter.com/ffhhnoc/status/787771192853798915

> > While checking the calculations Freifunk Hamburg did, I was
> > wondering whether the batadv_hardif_min_mtu() function should add
> > an extra 4 bytes for VLAN tagged, encapsulated payload to the MTU
> > calculations and the kmesg recommendations
> I am wondering whether we are trying to solve a problem that isn't a batman 
> problem. You could have any number of encapsulation interfaces on top of bat0 
> (QinQ, GRE, etc) adding overhead. Do we reserve space for all these headers 
> too ?

Hm, not quite sure whether it is 100% the same. While the problem
is the same, for VLANs and GRE etc., in practice they behave a
little different: When you have a network card with an MTU of
1500 bytes, then it usually works both with or without VLANs. And
without fragmentation.

GRE or other tunneling protocols don't have that property. And
I'm wondering whether we should try to preserve such VLAN
properties.
