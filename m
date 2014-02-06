Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 6 Feb 2014 10:55:11 +0100
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
In-Reply-To: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402061055.11799.sw@simonwunderlich.de>
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Dat,

> Hi,
> 
> I would like to know if batman adv [2013.2.0] supports a way to
> send/receive message between server and client?
> 
> I have setup a mesh network which has 1 server and several clients. I
> want to broadcast a message to all the clients from the server. The
> message might contain one more many parameters that I want all clients
> will use these parameters for their configuration.
> 
> It would be very convenience if I could execute a script remotely on
> clients from the server via batman adv without knowing their IP
> address.

batman-adv does not allow that by itself, but you can find various ways to do 
that. For example, install an HTTP server and let the clients download scripts 
from the default router in your routing table which hopefully points to your 
server. Another alternative would be to use alfred[1], which is designed to 
distribute data through a mesh network and to be used by clients. You can use 
it to send any kind of data over your mesh network. I would not exactly send 
shellscripts over it (might be a security problem), but configuration 
parameters should work just fine.

Cheers,
    Simon

[1] http://www.open-mesh.org/projects/open-mesh/wiki/Alfred
