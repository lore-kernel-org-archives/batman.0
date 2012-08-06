Return-Path: <gmazzurco89@gmail.com>
Message-ID: <501FE731.6050306@gmail.com>
Date: Mon, 06 Aug 2012 17:48:01 +0200
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
MIME-Version: 1.0
References: <501FC12D.3040608@gmail.com> <20120806134309.GK12879@ritirata.org>
In-Reply-To: <20120806134309.GK12879@ritirata.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] multicast packet loss
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, babel-users@lists.alioth.debian.org

The problem was that babeld assumed bat0 as a wired interface so when 2
or 3 packet was lost it marked the route as unreachable, now the problem
is fixed thanks to a patch from julius

by the way it is not normal that batman loss packet on wired links and I
think we should do some debug to understand what is happening...

I am going to do some test as ordex said trying to make things clear

On 08/06/2012 03:43 PM, Antonio Quartulli wrote:
> On Mon, Aug 06, 2012 at 03:05:49PM +0200, Gioacchino Mazzurco wrote:
>> Hi all!
>>
>> I am experiencing a multicast packet loss on batman-adv mesh, this can
>> appear normal but it is not because the mesh is on top of wired Ethernet
>> link!
>>
>> the host fe80::c8e0:2cff:fe9b:6d1f is sending a multicast hello message
>> every 4 seconds on bat0 interface, but as you can see from the dump
>> timing on a machine attached on the same switch they are not arriving
>> regurarly so what is happening? Is this normal?
> 
> Hello Gioacchino,
> 
> I'd say that losing packets is not normal :-)
> Have you tried to use batctl td on the wired interface? You should see the
> "broadcast" packets going around. It would be interesting to understand if on
> batctl you had more packets than what you are receiving on the node.
> 
> Cheers,
> 
> 
> p.s. what kind of hello messages are they? Their size is changing over time..
> 

