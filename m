Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 8 Sep 2010 21:12:14 +0200
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<201009081142.31610.sven.eckelmann@gmx.de>
	<AANLkTimnBqkiO26wqEQOm+AgSJgQLtQmAe8R-kB6CqtZ@mail.gmail.com>
In-Reply-To: <AANLkTimnBqkiO26wqEQOm+AgSJgQLtQmAe8R-kB6CqtZ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201009082112.14877.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, Jesse Gross <jesse@nicira.com>, Andi Kleen <andi@firstfloor.org>, davem@davemloft.net

On Wednesday 08 September 2010 20:22:42 Jesse Gross wrote:
> Potentially one way to do this is to build on top of Open vSwitch.  It
> contains a pretty generic flow-based kernel module for forwarding data
> packets and making simple modifications.  Control packets can be sent
> to userspace to handle the routing logic, while data packets remain in
> the kernel for performance.  This would dramatically reduce the amount
> of code that needs to be in the kernel and may even help performance
> by simplifying the fast path.

Thanks for your input.

I had a quick look at the website to get an idea but I had to notice that 
there is quite a collection of daemons, kernel modules and apps. As you seem 
involved in this project, could you point us to the collection of tools that 
you think we would need to achieve the following:

* sending protocol traffic
* transmitting the routing logic
* encapsulation of the various packet types (see http://www.open-
mesh.org/browser/trunk/batman-adv/packet.h to get an idea)
* directly influence the traffic flow, i.e., ARQ for broadcasts, interface 
alternating, bonding, forward error correction, etc
* layer 2 fragmentation


Cheers,
Marek
