Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <c63cb109-81bf-4a08-6b29-813a89590170@viisauksena.de>
References: <1493216459.18414.3.camel@openmailbox.org>
 <c63cb109-81bf-4a08-6b29-813a89590170@viisauksena.de>
From: dan <dandenson@gmail.com>
Date: Wed, 26 Apr 2017 09:53:23 -0600
Message-ID: <CAA_JP8W9drbSJQDDc4Lqxr-ceDRfydYrHWwSR+ZBCw6R5oyiDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I can't see how it could scale.  Each node needs a table of all other
nodes to calculate the cost for each path.  This is a LOT of data and
each node rebroadcasts it's neighbor's information so the more
neighbors, the more rebroadcasting.

Maybe if you had a long string of nodes with each node only seeing 1-2
other nodes, it might scale up higher, but that's not the point of
mesh networking.

It really means that under idea circumstances, overhead is going to
scale up with node count by percent.  So a few nodes is low overhead,
but 50 nodes might be as much as 50% and so on.

This is a critical flaw in batman-adv to scale up. Requiring each node
to know all other nodes.  If this rule could be changed to have
batman-adv only keep track of gateway nodes and nodes in the path to a
gateway, then it could scale vastly further.



On Wed, Apr 26, 2017 at 9:10 AM, jens <jens@viisauksena.de> wrote:
> i think this could scale , but you will need sufficient power / ethernet
> capacities at the nodes.
>
> and the biggest problem may be that these endpoints make much noise on
> the layer2 level.
> (disovery protocolls and stuff like this)
>
> you could easily imagine what would happen if you have a layer2 switch
> with 100000 ports.
>
> i think that most of the time you will not do this, and implement some
> sort of routing between some clouds of batman-adv networks.
>
>
>
> On 26.04.2017 16:20, fuumind wrote:
>> Hi list!
>>
>> Been lurking for almost a year on the battlemesh list and recently
>> joined here as well.
>>
>> I'm curious about how well batman-adv scales. Would a network of 10 000
>> nodes work well? What about 100 000 nodes or 1 000 000?
>>
>> Thanks!
>> fuumind
>>
>
> --
> make the world nicer, please use PGP encryption
>
