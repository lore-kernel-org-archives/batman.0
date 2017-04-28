Return-Path: <fuumind@openmailbox.org>
Message-ID: <1493389596.28193.10.camel@openmailbox.org>
From: fuumind <fuumind@openmailbox.org>
Date: Fri, 28 Apr 2017 16:26:36 +0200
In-Reply-To: <3080757.qWi1On8dnJ@prime>
References: <1493216459.18414.3.camel@openmailbox.org>
 <1504855.vmUtePouqW@prime> <1493376248.28193.6.camel@openmailbox.org>
 <3080757.qWi1On8dnJ@prime>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] how well does batman-adv scale
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

Now I get it. :) That makes sense.

Thanks!

fre 2017-04-28 klockan 14:23 +0200 skrev Simon Wunderlich:
> Hi,
> 
> On Friday, April 28, 2017 12:44:08 PM CEST fuumind wrote:
> > 
> > Ok, so clouds of a few hundred nodes would work reasonably well and
> > at
> > the same time keep customization to a minimum.
> Yes
> 
> > 
> > 
> > What makes OSPF a better candidate for interfacing between the
> > clouds?
> > Does it keep a more limited routing table and thus minimize
> > overhead
> > traffic? I haven't been able to figure it out good enough yet.
> The idea would be that you do a layer 3 protocol only on a few
> selected 
> "gateway" nodes of the clouds. Those gateways would forward traffic
> from one 
> cloud to the other, without having the details (and thus not having
> the 
> overhead) of the state of the mesh.
> 
> Which technology is the best is beyond my knowledge.
> 
> Cheers,
>       Simon
> 
