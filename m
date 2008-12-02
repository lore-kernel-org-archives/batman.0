From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batman-exp rev.1154 still using 94% CPU load
Date: Tue, 2 Dec 2008 13:06:19 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
In-Reply-To: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812021306.20569.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,


On Dienstag 02 Dezember 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> Hi,
>
> I have still the problem that batman-exp is hanging on 94% cpu load.
> perhaps it has nothing to do with the gateway task. It is possible that
> I run more "batmand -c" at same time?
yes, should be possible. I am often connecting different debug clients, also 
while changing for example the preferred gateway or the gateway-class.

Do you feel this problem has arised with a specific revision (has it been 
there with rv1069 and before) or has it always been there and your setup has 
changed?

> The current batman revision is  1154.
> Do you have any idea?
Actually not. Unfortunately I'll be probably be offline during the next week 
and cant do much. There is a completely thread-free version waiting to be 
checked in, then we can see if this helps, But actually I would prefer to 
nail down the source of the problem...

cu,
axel

>
>
> Mem: 15700K used, 14924K free, 0K shrd, 1440K buff, 6600K cached
> CPU:  5.8% usr 94.1% sys  0.0% nice  0.0% idle  0.0% io  0.0% irq  0.0%
> softirq Load average: 1.62 1.39 0.98
>   PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
> 24256  1843 root     R     1264  4.1 94.7 /sbin/batmand -s 10.12.0.1 -a
> 10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
> --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
>  1156     1 root     S     1264  4.1  0.0 /sbin/batmand -s 10.12.0.1 -a
> 10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
> --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
>  1843  1156 root     S     1264  4.1  0.0 /sbin/batmand -s 10.12.0.1 -a
> 10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
> --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
> 24462 24460 root     S     1216  3.9  0.0 batmand -cb -d2
> 24857 24815 root     S     1216  3.9  0.0 batmand -c -b -r 1
>
> ---------------------------------------
> Dipl.Informatiker(FH) Stephan Enderlein
> Freifunk Dresden
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


