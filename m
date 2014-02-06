Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 6 Feb 2014 13:40:08 +0100
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
 <201402061055.11799.sw@simonwunderlich.de>
 <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
In-Reply-To: <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402061340.08606.sw@simonwunderlich.de>
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
To: Le Tran Dat <trandatnh@gmail.com>
Cc: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

Hello Dat,

> Hi Simon,
> 
> Thanks for your response. I've read about Alfred, tomorrow I will try
> installing Alfred.
> 
> I am browsing the source code of batman adv and if I am not wrong I
> can create and send a user-defined message.
> I think I can broadcast something like a "struct sk_buff *skb;" to all
> clients. However I don't think this one is a good way since it may
> impact to the current design of batman adv. How do you think?

well in theory you can do a lot of things, but in practice I'd really not 
recommend to send userspace-specific stuff through the kernel. I think it would 
be better to just a userspace tool (alfred, wget/httpd, netcat, your own tool) 
to transfer this kind of data.

> 
> One more question, why browsing source code, I can not find the
> definition of struct sk_buff; where could I find it?

This is part of the linux kernel headers, to be found in 
include/linux/skbuff.h. Again, you should really look into sending this kind of 
information via userspace, e.g. use an UDP-socket and send a broadcast 
message. In case you have never done something like that, have a look
at that guide:

http://beej.us/guide/bgnet/

> 
> P/S: I forgot to give the detail of my issue is that I do not know the IP
> addresses of all clients but I want to be able to send the
> configuration to them.
> Is it possible for Alfred to send those configuration without knowing
> cients' IP address by using mac-address only?

Yes, that is possible.
> 
> I haven't tried with IPv6 before. I have no IPv6 knowledge.

That's not a problem, just turn on IPv6 in your system and the interface will 
get a link-local address assigned automatically.

Cheers,
    Simon
