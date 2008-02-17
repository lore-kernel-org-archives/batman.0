Message-ID: <20080217214820.h3br6pf544s4s0ok@webmail.ddmesh.de>
Date: Sun, 17 Feb 2008 21:48:20 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi Axel,

when I use rv980 and call "kill -STOP $(pidof tincd)" then batman works
for a while (1-2 minutes) and exists with the following error:

[    411413] Error - can't send udp packet: Resource temporarily unavailable.
Connection terminated by remote host

When I restart batmand when tincd is still stopped, the OGM are processed and
I see the neighbour nodes until I get the same error after about 1-2 minutes.
good news, it does not block.

Because of the error message I have inserted at posix/posix.c: 705 "return 0"
(send_udp_packet()).

I have tested two wrt54gl that had the problems before with the rev980 and
the "return 0" statement. Both routers has be running for 18 hours when
tincd was running without creating a connection.
After that I called "kill -STOP $(pidof tincd)" on both routers. Both routers
running now since 13 hours without problems.


Please check and insert the "return 0" at posix/posix:705 if it is the right
solution.

Have a nice week

/Stephan


Zitat von Axel Neumann <axel@open-mesh.net>:

> Hi Stephan,
>
> can you check if rv980 solves the problem ?
>
> ciao,
> axel
>
> On Donnerstag 14 Februar 2008, Freifunk Dresden wrote:
>> Hi Axel,
>>
>> I have done some checks. First I have added the tincd tap interface to
>> a bridge and used the bridge as parameter for batmand. This is currently
>> running since 10h.
>>
>> The second what I have tried is to call "kill -STOP $(pidof tincd)".
>> On the WRT54GL batmand stopped quite fast, but it stopped also fast without
>> the "kill". On the WRT54SL where I never have seen batmand stopping, the
>> "kill" has stopped batmand after 5-10 minutes. I could reproduce this
>> serveral times with the GS.
>>
>> When calling batmand -c -a 120.56.56.56/32 I get the following output on
>> batmand -cd3:
>>
>> [    275531] Unix socket: got connection
>> [    275539] got request: 10
>> [    275540] Unix socket: Requesting adding of HNA 120.56.56.34/32 -
>> put this on todo list...
>> [    275544] got request: 10
>> [    275545] Unix client closed connection ...
>>
>> Three batmand processes are running and batmand -c returns:
>> WARNING: You are using BatMan-eXp 0.3-alpha (compatibility version 10) !
>> /sbin/batmand [not-all-options-displayed] -r 2 -a 10.12.10.16/28 eth1 tbb
>>
>> After calling "killall batmand" only one of three batmand processes is
>> killed. I have to killall -9 to get rid of it.
>>
>> Regards
>> /Stephan
>>
>>
>>
>>
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>





