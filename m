Return-Path: <hwhilse@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 27 Mar 2016 20:37:37 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <1459103215-22444-1-git-send-email-hwhilse@gmail.com>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <1459103215-22444-1-git-send-email-hwhilse@gmail.com>
Message-ID: <69c47d370308ade423bdc4c2d54d434e@hilses.de>
Subject: Re: [B.A.T.M.A.N.] [RFC v2] alfred: implement TCP support for
 server-to-server communication
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

Hi,

Am 2016-03-27 20:26, schrieb Hans-Werner Hilse:
> [...]
> Changes in v2:
>    - non-blocking sending over TCP sockets

This uses non-blocking IO also for sending via TCP.
TCP is chosen when the message size exceeds MAX_UDP_ANSWER (from 
alfred.h), which is for now conservatively chosen to fit in bad-case MTU 
settings - or if the data request came via TCP (as the same connection 
is then used for the reply).

I've run this for a few hours in a test setup with 3x alfred as master 
and 30 slaves, with some errors, dups and latency thrown in for good 
measure (yay for VDE, virtual distributed ethernet).

The current implementation has a downside: non-blocking TCP sending for 
now assembles the full data that is to be sent in a memory buffer, which 
will then get sent bit by bit (depending on buffers, network and the 
remote side). This is a consequence of the lack of a good way to 
guarantee a consistent state of the data store over the time it takes 
until the full message stream is completely transmitted to the remote 
end (the data store might get modified between beginning and finishing 
transmission).

An alternative approach - and a major redesign of data storage - would 
be some kind of log-based approach. I'm not so sure if that really is 
warranted for, and in any case, that's quite a different undertaking.

The flag "-t" is still present and will toggle whether alfred will try 
to request using TCP at all. This will allow to use a TCP-enabled alfred 
in an environment that is not yet fully TCP enabled (this matters only 
for the master servers AFAICS).

-hwh
