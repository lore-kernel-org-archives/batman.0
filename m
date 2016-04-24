Return-Path: <hwhilse@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Apr 2016 00:02:20 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <571A6F6E.3010901@viisauksena.de>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <1459103215-22444-1-git-send-email-hwhilse@gmail.com>
 <69c47d370308ade423bdc4c2d54d434e@hilses.de>
 <571A6F6E.3010901@viisauksena.de>
Message-ID: <57e11b17875af874d6922592ff9e152d@hilses.de>
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

first: many thanks for testing.

Am 2016-04-22 20:37, schrieb jens:
> ####### patch stuff
> ####### wget https://patchwork.open-mesh.org/patch/15944/raw/ -O 
> tcp.patch
> patch < tcp.patch
> patching file alfred.h
> Hunk #1 succeeded at 90 (offset 1 line).
> Hunk #2 succeeded at 103 (offset 1 line).
> Hunk #3 succeeded at 131 (offset 1 line).
> Hunk #4 succeeded at 147 (offset 1 line).
> Hunk #5 succeeded at 170 (offset 1 line).
> Hunk #6 succeeded at 187 (offset 1 line).
> Hunk #7 succeeded at 200 (offset 1 line).
> Hunk #8 succeeded at 227 (offset 1 line).
> patching file main.c
> patching file netsock.c
> patching file recv.c
> patching file send.c
> patching file server.c
> patching file unix_sock.c
> Hunk #1 succeeded at 229 (offset 7 lines).
> Hunk #2 succeeded at 259 (offset 7 lines).

Is this patch run against git master's HEAD?
Even then, offsets might occur, there were some minor changes since I've 
sent the patch.

> ####### build errors
> make
>     CC main.o
>     CC server.o
>     CC client.o
>     CC netsock.o
>     CC send.o
>     CC recv.o
> recv.c: In function 'recv_alfred_packet':
> recv.c:436:48: warning: passing argument 5 of 'process_alfred_request'
> makes pointer from integer without a cast
>             (struct alfred_request_v0 *)packet, -1);
>                                                 ^
> recv.c:302:12: note: expected 'struct tcp_connection *' but argument is
> of type 'int'
>  static int process_alfred_request(struct globals *globals,
>             ^

Oh dear. I'm not sure how my gcc managed to stay quiet at this. Also, 
I'm astonished it didn't blew to pieces during my tests.
The "-1" is a leftover from an earlier implementation, where I still 
thought that I hadn't that much TCP connection state to carry around - 
so I passed socket fds. I no longer do that, and switched to a struct 
holding the state. In this case, the "-1" should be NULL. It seems to be 
the only oversight of this kind as far as a I can see.

I will update the patch shortly.

> ###### var/log/kern.log
> Apr 22 20:01:06 fffr-spielwiese kernel: [4398895.515177] alfred[31733]:
> segfault at 2f ip 0000000000406034 sp 00007fff9dc39580 error 6 in
> alfred[400000+d000]
> Apr 22 20:02:05 fffr-spielwiese kernel: [4398954.569665] alfred[32657]:
> segfault at 2f ip 0000000000406034 sp 00007ffc45b97d50 error 6 in
> alfred[400000+d000]

In the light of a dereference of a "-1" pointer, that doesn't come as a 
surprise.

-hwh
