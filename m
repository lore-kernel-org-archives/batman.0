In-Reply-To: <560c7c9a0710011056v2c8b64ebj109e29ce00e42862@mail.gmail.com>
References: <20070608201844.GM20739@localhost>
	<F32A30C5-7FD8-408E-A9F8-6A5A237ABA4E@lo-res.org>
	<560c7c9a0706081607q653848eaxce94433ad3f4aed@mail.gmail.com>
	<200706091357.15324.axel@open-mesh.net>
	<87FD50C8-EDAE-43E1-9167-E931AD020EF6@lo-res.org>
	<dd15f4bf0706091535k1c1fb91erac2093ec4d98e002@mail.gmail.com>
	<560c7c9a0710011056v2c8b64ebj109e29ce00e42862@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <07EFF690-E02A-4B92-946E-0C67B32066E3@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Mon, 1 Oct 2007 20:10:51 +0200
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
To: Benjamin Henrion <bh@udev.org>, Rusev Andrej <zethix@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

>

Benjamin Henrion wrote:

> What about using OpenVZ instances (each instance has its own TCP IP
> stack I think)?
>
> I did not manage to have a working 32bit UML kernel+busybox rootfs for
> testing OLSR and/or batman (ifconfig did not work out with the busybox
> rootfs version of
> http://uml.nagafix.co.uk/BusyBox-1.5.0/BusyBox-1.5.0-x86-root_fs.bz2
> and kernel version vmlinux-2.6.18.1-bb2), if someone can recommend me
> one version for each of those.

Well, I have not tried openVZ. I would be interested in it.
UML is quite tricky to get right. As soon as our texas server is up  
and running again, I can
give you kernel .config file which worked for me.


best,
aaron.

---
there's no place like 127.0.0.1



