Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 29 Nov 2012 11:25:33 +0800
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg5UinZxugVHYRyK70tUFTPQ7FHqRAsn0GP_gV=EZVMWtQ@mail.gmail.com>
 <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
In-Reply-To: <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201211291125.33400.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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


HI,

> Now I switch to MAC address of bat0 as the source and destination
> address. In this case, I only have two nodes. Node A and node C.
> 
> Now, I cannot send packet from node A to node C, and vice versa.
> However, when I do batctl tcpdump bat0 on the receiver side, I can see
> print out shown in the following.
> 
> Warning - packet contains unknown ether type: 0x1337.
> 
> Not sure what should I do now.

this just means that batctl does not know how to print this packet type. Not 
surprising - you just created the packet type yourself. How should batctl know 
about it ? 

I'd say if you get this warning on the other end your packet was successfully 
delivered.

Antonio, wouldn't it be possible to get the bat0 mac address from the global 
table even if there were other clients bridged into that node ? The bat0 entry 
should be the only one with the no_purge flag set.

Cheers,
Marek

