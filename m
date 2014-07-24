Return-Path: <tobias@hachmer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Jul 2014 06:40:24 +0200
From: Tobias Hachmer <tobias@hachmer.de>
In-Reply-To: <53D05D84.20700@altermundi.net>
References: <53D00BAF.9070506@hachmer.de> <53D05D84.20700@altermundi.net>
Message-ID: <88409a9ed363089a1dfc08d0baa9dea5@hachmer.de>
Subject: Re: [B.A.T.M.A.N.] alfred - one gateway - multiple interfaces
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hallo Gui,

thanks for your reply.

On 24.07.2014 03:12, Gui Iribarren wrote:
> On 23/07/14 16:23, Tobias Hachmer wrote:
>> Guess what: We have the requirement to run one alfred instance for
>> each batman domain. What is the suggested way to achieve this?
> 
> a tangential question:
> 
> given you have a big enough hardware (since you mention ubuntu 14.04)
> have you considered turning it into a "hardnode" and using any kind of
> virtualization technology? openvz, lxc...
> 
> it would help with isolation and simplify things in the long run
> (including having two alfred instances)

Yeah, this could be an approach later. But for now our gates are either 
a VM or just small hardware (Atom). But I don't want to discuss this 
here.

It is possible to create multiple batman interfaces wich are serving 
different domains. Corollary, alfred has to also.

As I said, a workaround could be to just simply duplicate the init 
script (adjusting all relevant names like pid and so on, of course).

But there could be more communities out there which will stumble over 
the same issue, sooner or later. So I just wanted the developer to know, 
that there is such a requirement.

And, maybe, this could be achieved in a way we don't know about?
Anybody here?

Greetings,
Tobias
