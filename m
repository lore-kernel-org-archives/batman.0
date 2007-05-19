From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] problems running batman rev350
Date: Sat, 19 May 2007 17:49:22 +0200
References: <464F0FEF.6090603@gmx.net>
In-Reply-To: <464F0FEF.6090603@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705191749.22823.axel@open-mesh.net>
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

Hey Dragan,

>
>  #!/bin/sh
>     iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10 ap
> 02:CA:FF:EE ifconfig eth2 104.130.30.9

(just to be shure) this should be 02:CA:FF:EE:BA:BE 

..
>
> i am starting batman with:
>
> #!/bin/bash
>     iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10
>     ifconfig eth2 105.130.30.9
>     ifconfig eth2 up
>     sleep 1
>     batmand -d 1 -p 105.131.41.5 -r 1 eth2
can  you start batmand in background with: 
batmand -r 1 -p 105.131.41.5  eth2
instead and tell if the problem continues. This command instantly returns your 
prompt but a:
ps -aux | grep batmand
should show the running main-daemon in the background.
Also please check that there are no predefined host routes for the 105.0.0.0/8 
network before you start batmand and after it stopped. Meaning a:
route -n | grep ^105 
berfore and after the daemon is running should only show:
105.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 eth2
While batmand is running it should of course show routing entries for all 
other known batman nodes but if such host routes are still there after the 
daemon stopped it is a definitive sign for an uncorect termination of teh 
daemon.

>
> #!/bin/bash
> batmand -c -d 2
>
> in another terminal.

It should of course always be possible to access the debug output from the 
running batmand main-daemon by launching a batmand-client with
batmand -c -d <1-4>
or in batch mode (providing just a single outputpage and returns to the 
prompt) with:
batmand -c -d <1-4> -b
However, it would be interesting to know if the crash is related to existence 
of a batmand-client connecting to the main daemon. For example for 
batmand-0.2.0-rc2-rv350 (and before) debug level 4:
batmand -c -d 4
is known to cause the batmand to crash after a short time and it might be 
possible that this problems also occur with other debug-levels.
Try 
batmand -c -d 1
and 
batmand -c -d 2
instead.

ciao,
axel


>
> when batman starts, the 'batmand -c' script shows, that i am connected
> to another gateway, but not to preferred one:
>
>      Gateway              Router (#/128)
> => 105.192.99.62      105.130.30.1 ( 3), gw_class 10 - 6 MBit,
> reliability: 0
>    105.192.99.61      105.130.30.1 ( 1), gw_class  7 - 2 MBit,
> reliability: 0
>    105.131.83.5       105.130.30.1 ( 1), gw_class 11 - >6 MBit,
> reliability: 0
>    105.131.41.5       105.130.30.1 ( 2), gw_class 11 - >6 MBit,
> reliability: 0
>    105.192.99.103     105.130.30.1 ( 3), gw_class  7 - 2 MBit,
> reliability: 0
>    105.192.99.192     105.130.30.1 ( 2), gw_class 10 - 6 MBit,
> reliability: 0
>
> ...........
>
> this always is a number 105.192.99.....(.62, .103, .192).
> this condition than stays for 2 or 3 up to 10 minutes, and in that time
> i cannot even ping the 105.130.30.1 which is the next  point here.
>
> after some minutes, the connection changes, so that 'batmand -c' shows
> that i am connected to 105.131.41.5 and i am able to ping 141.1.1.1.
> unfortunately, after some minutes (or even shorter), the batman script
> stops and the terminal is at the prompt again. there is no segfault,
> using 'ulimit -c unlimited' will not produce a core-dump. i suppose that
> this is not a driver bug, cause looking at this moment at 'dmesg', i can
> see that the driver is loaded using the 02:ca:ff:ee:ba:by - if i stop
> batmand and start olsrd, i will be connected to the internet as expected.
>
> i am really not aware of what else information i could provide to you,
> in order to make batmand running stable here, but if you have any idea,
> please let me know!
>
> cheers,
> doc
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
