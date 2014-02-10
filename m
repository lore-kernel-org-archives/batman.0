Return-Path: <trandatnh@gmail.com>
MIME-Version: 1.0
In-Reply-To: <52F3871B.4020704@meshcoding.com>
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
 <201402061055.11799.sw@simonwunderlich.de>
 <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
 <52F3831F.3080203@meshcoding.com>
 <CAOyZXpRA2+gLxwNc-10c-HVJcN58vP8bnfFSGb5f-m9wzCh2rw@mail.gmail.com>
 <52F3871B.4020704@meshcoding.com>
From: Le Tran Dat <trandatnh@gmail.com>
Date: Mon, 10 Feb 2014 09:27:35 +0800
Message-ID: <CAOyZXpTP6X3x9Zf7FX-XDE7K1Uy5B9z0fS=GxunZASaNHvCSpQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] How to send message/execute script on clients
	from server?
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

Thanks all,

I used alfred to share configuration parameters to the whole network.
Everything works fine.

Anyway, If I want to know any change of the current parameter then I
need to periodically check for every 5 minutes. Is there any event
triggered when a new value has just been set to alfred?

Thanks,
Dat

On Thu, Feb 6, 2014 at 8:59 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
> On 06/02/14 13:54, Le Tran Dat wrote:
>> Hi Antonio,
>>
>> Could you explain more about opening a socket on the bat0 interface?
>> Should I write a new user space deamon or write it inside batman adv?
>
> everything is userspace in this case. It's about writing a program in
> userspace that sends raw Ethernet frames. batman-adv in this case can be
> seen like an Ethernet switch, so you can treat you bat0 like it was a
> normal eth0 connected to this switch. No need to touch batman-adv at all.
>
> Cheers,
>
> --
> Antonio Quartulli
>
