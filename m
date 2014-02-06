Return-Path: <trandatnh@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201402061055.11799.sw@simonwunderlich.de>
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
 <201402061055.11799.sw@simonwunderlich.de>
From: Le Tran Dat <trandatnh@gmail.com>
Date: Thu, 6 Feb 2014 04:06:07 -0800
Message-ID: <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,

Thanks for your response. I've read about Alfred, tomorrow I will try
installing Alfred.

I am browsing the source code of batman adv and if I am not wrong I
can create and send a user-defined message.
I think I can broadcast something like a "struct sk_buff *skb;" to all
clients. However I don't think this one is a good way since it may
impact to the current design of batman adv. How do you think?

One more question, why browsing source code, I can not find the
definition of struct sk_buff; where could I find it?

P/S: I forgot to give the detail of my issue is that I do not know the IP
addresses of all clients but I want to be able to send the
configuration to them.
Is it possible for Alfred to send those configuration without knowing
cients' IP address by using mac-address only?

I haven't tried with IPv6 before. I have no IPv6 knowledge.

Thanks,
Dat

On Thu, Feb 6, 2014 at 1:55 AM, Simon Wunderlich <sw@simonwunderlich.de> wrote:
> Hi Dat,
>
>> Hi,
>>
>> I would like to know if batman adv [2013.2.0] supports a way to
>> send/receive message between server and client?
>>
>> I have setup a mesh network which has 1 server and several clients. I
>> want to broadcast a message to all the clients from the server. The
>> message might contain one more many parameters that I want all clients
>> will use these parameters for their configuration.
>>
>> It would be very convenience if I could execute a script remotely on
>> clients from the server via batman adv without knowing their IP
>> address.
>
> batman-adv does not allow that by itself, but you can find various ways to do
> that. For example, install an HTTP server and let the clients download scripts
> from the default router in your routing table which hopefully points to your
> server. Another alternative would be to use alfred[1], which is designed to
> distribute data through a mesh network and to be used by clients. You can use
> it to send any kind of data over your mesh network. I would not exactly send
> shellscripts over it (might be a security problem), but configuration
> parameters should work just fine.
>
> Cheers,
>     Simon
>
> [1] http://www.open-mesh.org/projects/open-mesh/wiki/Alfred
