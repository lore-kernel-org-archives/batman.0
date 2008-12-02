Message-ID: <ac3d5a10868a68b63ff9054d1c45dde6.squirrel@wm.ddmesh.de>
In-Reply-To: <200812021306.20569.axel@open-mesh.net>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812021306.20569.axel@open-mesh.net>
Date: Tue, 2 Dec 2008 14:59:58 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-exp rev.1154 still using 94% CPU load
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

Hi axel,

> Do you feel this problem has arised with a specific revision (has it been
> there with rv1069 and before) or has it always been there and your setup has
> changed?
The first time I saw this was on revistion 1105. But a similar problem was already
on revision 972 where I still could call "batmand -c -r 3" but not with "-d...".
I can not say if this is still the same problem.

My setup of compiling batmand was not changed.
The compile flags I used were:
CFLAGS =        -Wall -O1 -DMEMORY_USAGE -DPROFILE_DATA -DDEBUG_MALLOC
LDFLAGS =       -lpthread

Today I changed to revision 1171 and use the following flags:
CFLAGS =        -Wall -O2 -g -DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA
LDFLAGS =       -lpthread

I compile batmand within the whiterussian_rc6 openwrt environment.
I wanted to create a core file but it seems that the openwrt kernel does not support it.
(ulimit -c unlimited, and kill -6 xxx)

> Actually not. Unfortunately I'll be probably be offline during the next week
> and cant do much. There is a completely thread-free version waiting to be
> checked in, then we can see if this helps, But actually I would prefer to
> nail down the source of the problem...
When do you expect a thread-free version of the batman-experimental branch?
I also like to solve such problems instead of using new code in hope that the problem
is gone.

Bye Stephan
---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


