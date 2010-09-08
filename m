Return-Path: <jesse@nicira.com>
MIME-Version: 1.0
In-Reply-To: <201009081142.31610.sven.eckelmann@gmx.de>
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<87sk1kiu5m.fsf@basil.nowhere.org>
	<201009081142.31610.sven.eckelmann@gmx.de>
Date: Wed, 8 Sep 2010 11:22:42 -0700
Message-ID: <AANLkTimnBqkiO26wqEQOm+AgSJgQLtQmAe8R-kB6CqtZ@mail.gmail.com>
From: Jesse Gross <jesse@nicira.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Andi Kleen <andi@firstfloor.org>, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.net

On Wed, Sep 8, 2010 at 2:42 AM, Sven Eckelmann <sven.eckelmann@gmx.de> wrote:
> Hi,
>
> here are some raw references without any judgment. Maybe Marek will send some
> more information about that topic later.
>
> Andi Kleen wrote:
>> Sven Eckelmann <sven.eckelmann@gmx.de> writes:
>> > B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a routing
>> > protocol for multi-hop ad-hoc mesh networks. The networks may be wired or
>> > wireless. See http://www.open-mesh.org/ for more information and user
>> > space tools.
>>
>> It seems rather unusual to have the complete routing protocol in
>> kernel. And this is a lot of code. The normal way to do such things is
>> to have the routing policy etc. in a user daemon and only let the kernel
>> provide some services to this.
>>
>> Could you elaborate a bit why this approach was not chosen?
>>
>> I assume if it needs a switch it could have a switching "hot path" layer
>> in kernel and the policy somewhere else.

Potentially one way to do this is to build on top of Open vSwitch.  It
contains a pretty generic flow-based kernel module for forwarding data
packets and making simple modifications.  Control packets can be sent
to userspace to handle the routing logic, while data packets remain in
the kernel for performance.  This would dramatically reduce the amount
of code that needs to be in the kernel and may even help performance
by simplifying the fast path.

I don't know the details of your protocol well enough to know if this
is feasible but it seems like something you might want to look into.
Open vSwitch is currently in the process of finalizing its interfaces
to prepare for upstreaming.
