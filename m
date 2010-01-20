Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 Jan 2010 05:58:51 +0800
References: <20100118112706.91160@gmx.net> <20100119193701.GA18515@pandem0nium>
	<20100120140530.4750@gmx.net>
In-Reply-To: <20100120140530.4750@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001210558.52086.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

> I just took a fresh checkout and now it compiles without problems. The
>  errors I got were in gateway functionality, so I guess they were under
>  development?

yap. If you want something more stable stay with the last release.


> It's still complining about the bat_printk:
> make[2]: *** No rule to make target
>  `/home/ylo/batman-adv/trunk/batman-adv-kernelland-ARM/bat_printk.o',
>  needed by
>  `/home/ylo/batman-adv/trunk/batman-adv-kernelland-ARM/batman-adv.o'. Stop.

That was fixed today (revision 1559).

Regards,
Marek
