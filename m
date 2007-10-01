Message-ID: <560c7c9a0710011056v2c8b64ebj109e29ce00e42862@mail.gmail.com>
Date: Mon, 1 Oct 2007 19:56:01 +0200
From: "Benjamin Henrion" <bh@udev.org>
Sender: zoobab@gmail.com
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
In-Reply-To: <dd15f4bf0706091535k1c1fb91erac2093ec4d98e002@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070608201844.GM20739@localhost>
	<F32A30C5-7FD8-408E-A9F8-6A5A237ABA4E@lo-res.org>
	<560c7c9a0706081607q653848eaxce94433ad3f4aed@mail.gmail.com>
	<200706091357.15324.axel@open-mesh.net>
	<87FD50C8-EDAE-43E1-9167-E931AD020EF6@lo-res.org>
	<dd15f4bf0706091535k1c1fb91erac2093ec4d98e002@mail.gmail.com>
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

On 6/10/07, zethix or something <zethix@gmail.com> wrote:
>
>
> On 6/9/07, Aaron Kaplan <aaron@lo-res.org> wrote:
> >
> > On Jun 9, 2007, at 1:57 PM, Axel Neumann wrote:
> >
> > > I am currently trying to get a grip on vnuml (
> > > http://www.dit.upm.es/vnumlwiki/index.php/Tutorial )
> which has good
> > > howtos
> > > and tutorial for building host- and uml- kernels and root_fs.
> > >
> > > Especially vnuml offers a framework for virutal network
> > > configuration based on
> > > xml-configuration files. I think texas-kernel is also patched for
> > > vnuml
> > > enhancements but for texas's root_fs and network-configuration
> > > scripts I am
> > > not shure.
> > > Maybe aaron can provide some more background on that?
> > >
> > I _think_ zethix (in the CC) briefly looked into vnuml but it seemed
> > to complicated.
> > The scripts were all borked and quite unusable for us at least.
>
> Yes, as far as I remember, vnuml needs a lot of things in order to work...
> well, things that all
> linux distros usually have, but not busybox. It was something like ...
> install its boot scripts in the
> vnuml'd system, make it mount an fs on the host, then use ssh for something
> and so on and so
> on. But the biggest problem we had was actually... that it was constantly
> making our poor system
> crash. Anyway, I guess we just had to drop it in order to move on. I do
> believe there are some nice
> things about vnuml, but ...
>
>
> > > In order to releas texas from unproductive trial-and-error
> > > configuration
> > > testing (and feeling less intervening when applying core-kernel-
> > > patches or
> > > installing new system-libraries) I started to setup a small vnuml
> > > environment
> > > on my home-pc. Therefore I found also the following links quite
> > > useful:
> > >
> > > http://www.dit.upm.es/vnumlwiki/index.php/Installation
> > >
> > >
> http://www.enic.fr/people/landru/viminal/vnuml.gentoo/how-to/vnuml-
> > > gentoo-guide.html
> > > ( gentoo oriented setup, host-kernel-enhancement, uml-kernel,
> > > root_fs )
> > >
> > > http://www.dit.upm.es/vnumlwiki/index.php/Howto
> > > ( further links for root_fs howtos )
> > >
> > > @aaron:
> > > do you have a link explaining from-scratch busybox-based uml-rootfs
> > > generation
> > > (as being used on texas) ?
> > >
> > yes
> >
> > with an existing root_fs:
> >
> > mount -o loop root_fs /mnt
> > then just copy over things as needed. That is what I did . works!
> >
> >
> > To create an initial root_fs:
> >
> > dd if=/dev/zero of=roof_fs bs=1M count=XXX
> > Then mount this root_fs from inside an existing UML instance and
> > fdisk it (./linux ubd1=root_fs )
> > and mkfs it
> >
> > voila!
> >
> > a.
> >
> > PS:
> > zethix was recently working on a way to do the simulation completely
> > without UML but with olsr_switch
> > which has still some bugs. Maybe some similar batman_switch
> > application can be usefull?
>
>
> Briefly, the olsr_switch works like this: in olsrd, there is this special
> 'driver' that doesn't use
> a netif for transmission, but a tcp connection instead. that connection goes
> to the olsr_switch.
> Also, there are some patches preventing all instances to modify the same
> routing table. So,
> in order to make batman work with olsr_switch (or whatever) I guess
> modifications might be
> needed.
>
> There is also an N-th way of doing it, probably: pseudo interfaces (like
> tap) instead of
> tcp connections. Nevertheless, all batmans (or olsrds) will share the same
> routing table.

What about using OpenVZ instances (each instance has its own TCP IP
stack I think)?

I did not manage to have a working 32bit UML kernel+busybox rootfs for
testing OLSR and/or batman (ifconfig did not work out with the busybox
rootfs version of
http://uml.nagafix.co.uk/BusyBox-1.5.0/BusyBox-1.5.0-x86-root_fs.bz2
and kernel version vmlinux-2.6.18.1-bb2), if someone can recommend me
one version for each of those.

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
