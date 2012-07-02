Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120702143604.GD2917@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
	<CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
	<20120702143604.GD2917@ritirata.org>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Mon, 2 Jul 2012 11:47:16 -0300
Message-ID: <CAHD-aqJOoJn9V+5dGJfZTUJSahQ2RECDGh+n-1BgRr=QUBemUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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

Hello Antonio!
thanks for your time,

On Mon, Jul 2, 2012 at 11:36 AM, Antonio Quartulli <ordex@autistici.org> wrote:
> Hello!
>
> Has debug support been compiled in batman-adv? IF yes, it would be interesting
> so see the output of the tt log (batctl ll tt; batctl l)

unfortunately, no :(

root@colmena:~# batctl ll
Error - can't open file '/sys/class/net/bat0/mesh/log_level': No such
file or directory
The option you called seems not to be compiled into your batman-adv
kernel module.

Will compile that option on next firmware cooking :)

> Recently we fixed a bug that which fix has not been released yet. If we are sure
> that this is the cause, you could eventually try an upgrade to a more recente
> dev-version. But let's see the log first (if possible)

Problem is, it's not easy to reproduce. I haven't came across it for
several weeks. Nicolas Echaniz told me he suffered it recently, but i
don't think neither of us can spend the time to try to recreate it on
purpose :(

An enabled debug support waiting for the bug to crop up will probably
be the best we can wait for :)

Thanks!

Gui
