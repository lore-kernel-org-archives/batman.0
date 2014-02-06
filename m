Return-Path: <trandatnh@gmail.com>
MIME-Version: 1.0
In-Reply-To: <52F3831F.3080203@meshcoding.com>
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
 <201402061055.11799.sw@simonwunderlich.de>
 <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
 <52F3831F.3080203@meshcoding.com>
From: Le Tran Dat <trandatnh@gmail.com>
Date: Thu, 6 Feb 2014 04:54:39 -0800
Message-ID: <CAOyZXpRA2+gLxwNc-10c-HVJcN58vP8bnfFSGb5f-m9wzCh2rw@mail.gmail.com>
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

Hi Antonio,

Could you explain more about opening a socket on the bat0 interface?
Should I write a new user space deamon or write it inside batman adv?

Thanks
Dat

On Thu, Feb 6, 2014 at 4:42 AM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
> On 06/02/14 13:06, Le Tran Dat wrote:
>> Hi Simon,
>>
>> Thanks for your response. I've read about Alfred, tomorrow I will try
>> installing Alfred.
>>
>> I am browsing the source code of batman adv and if I am not wrong I
>> can create and send a user-defined message.
>> I think I can broadcast something like a "struct sk_buff *skb;" to all
>> clients. However I don't think this one is a good way since it may
>> impact to the current design of batman adv. How do you think?
>>
>> One more question, why browsing source code, I can not find the
>> definition of struct sk_buff; where could I find it?
>>
>> P/S: I forgot to give the detail of my issue is that I do not know the IP
>> addresses of all clients but I want to be able to send the
>> configuration to them.
>> Is it possible for Alfred to send those configuration without knowing
>> cients' IP address by using mac-address only?
>
> Instead of touching the batman-adv code or using Alfred you could just
> open a socket on the bat0 interface and send raw Ethernet frames having
> the broadcast address as destination.
>
> This is something you can do with any Ethernet compatible interface (so
> also with your normal eth0) and therefore also with batman-adv.
>
> Regards,
>
> --
> Antonio Quartulli
>
