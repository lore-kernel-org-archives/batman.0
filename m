Return-Path: <jens@viisauksena.de>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <1459103215-22444-1-git-send-email-hwhilse@gmail.com>
 <69c47d370308ade423bdc4c2d54d434e@hilses.de>
From: jens <jens@viisauksena.de>
Message-ID: <571A6F6E.3010901@viisauksena.de>
Date: Fri, 22 Apr 2016 20:37:34 +0200
MIME-Version: 1.0
In-Reply-To: <69c47d370308ade423bdc4c2d54d434e@hilses.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

i installed your patch .. here some feedback/problems a had

with OpenWRT and gluon i succeeded ... actually testet it on a tplink841n=
-v9
runs with or without -m (master) for a while (30 min++)
/usr/sbin/alfred -i br-client -b bat0 -m
[my big wonder is , why do these router always only output their own
entry for alfred -r 158 , while there are master .. on debian based
master this is filled up to 290]

on debian 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt20-1+deb8u3
(2016-01-17) x86_64 GNU/Linux
i got some build errors .. and than after a short while in alfred master
mode ... segmentation fault
(1 or 2 minutes, sometimes only seconds)
this after master announcements and already collecting some 90+ alfred
information.

####### patch stuff
####### wget https://patchwork.open-mesh.org/patch/15944/raw/ -O tcp.patc=
h
patch < tcp.patch
patching file alfred.h
Hunk #1 succeeded at 90 (offset 1 line).
Hunk #2 succeeded at 103 (offset 1 line).
Hunk #3 succeeded at 131 (offset 1 line).
Hunk #4 succeeded at 147 (offset 1 line).
Hunk #5 succeeded at 170 (offset 1 line).
Hunk #6 succeeded at 187 (offset 1 line).
Hunk #7 succeeded at 200 (offset 1 line).
Hunk #8 succeeded at 227 (offset 1 line).
patching file main.c
patching file netsock.c
patching file recv.c
patching file send.c
patching file server.c
patching file unix_sock.c
Hunk #1 succeeded at 229 (offset 7 lines).
Hunk #2 succeeded at 259 (offset 7 lines).

####### build errors
make
    CC main.o
    CC server.o
    CC client.o
    CC netsock.o
    CC send.o
    CC recv.o
recv.c: In function 'recv_alfred_packet':
recv.c:436:48: warning: passing argument 5 of 'process_alfred_request'
makes pointer from integer without a cast
            (struct alfred_request_v0 *)packet, -1);
                                                ^
recv.c:302:12: note: expected 'struct tcp_connection *' but argument is
of type 'int'
 static int process_alfred_request(struct globals *globals,
            ^
    CC hash.o
    CC unix_sock.o
    CC util.o
    CC debugfs.o
    CC batadv_query.o
    LD alfred
make -C vis all
make[1]: Entering directory '/home/freifunk/alfred/vis'
    CC vis.o
    CC debugfs.o
    LD batadv-vis
make[1]: Leaving directory '/home/freifunk/alfred/vis'
make -C gpsd all
make[1]: Entering directory '/home/freifunk/alfred/gpsd'
    CC alfred-gpsd.o
    LD alfred-gpsd
make[1]: Leaving directory '/home/freifunk/alfred/gpsd'

###### var/log/kern.log
Apr 22 20:01:06 fffr-spielwiese kernel: [4398895.515177] alfred[31733]:
segfault at 2f ip 0000000000406034 sp 00007fff9dc39580 error 6 in
alfred[400000+d000]
Apr 22 20:02:05 fffr-spielwiese kernel: [4398954.569665] alfred[32657]:
segfault at 2f ip 0000000000406034 sp 00007ffc45b97d50 error 6 in
alfred[400000+d000]


On 27.03.2016 20:37, Hans-Werner Hilse wrote:
> Hi,
>
> Am 2016-03-27 20:26, schrieb Hans-Werner Hilse:
>> [...]
>> Changes in v2:
>>    - non-blocking sending over TCP sockets
>
> This uses non-blocking IO also for sending via TCP.
> TCP is chosen when the message size exceeds MAX_UDP_ANSWER (from
> alfred.h), which is for now conservatively chosen to fit in bad-case
> MTU settings - or if the data request came via TCP (as the same
> connection is then used for the reply).
>
> I've run this for a few hours in a test setup with 3x alfred as master
> and 30 slaves, with some errors, dups and latency thrown in for good
> measure (yay for VDE, virtual distributed ethernet).
>
> The current implementation has a downside: non-blocking TCP sending
> for now assembles the full data that is to be sent in a memory buffer,
> which will then get sent bit by bit (depending on buffers, network and
> the remote side). This is a consequence of the lack of a good way to
> guarantee a consistent state of the data store over the time it takes
> until the full message stream is completely transmitted to the remote
> end (the data store might get modified between beginning and finishing
> transmission).
>
> An alternative approach - and a major redesign of data storage - would
> be some kind of log-based approach. I'm not so sure if that really is
> warranted for, and in any case, that's quite a different undertaking.
>
> The flag "-t" is still present and will toggle whether alfred will try
> to request using TCP at all. This will allow to use a TCP-enabled
> alfred in an environment that is not yet fully TCP enabled (this
> matters only for the master servers AFAICS).
>
> -hwh

--=20
make the world nicer, please use PGP encryption


