Message-ID: <dd15f4bf0706091535k1c1fb91erac2093ec4d98e002@mail.gmail.com>
Date: Sun, 10 Jun 2007 01:35:09 +0300
From: "zethix or something" <zethix@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
In-Reply-To: <87FD50C8-EDAE-43E1-9167-E931AD020EF6@lo-res.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_59889_1442789.1181428509072"
References: <20070608201844.GM20739@localhost>
	<F32A30C5-7FD8-408E-A9F8-6A5A237ABA4E@lo-res.org>
	<560c7c9a0706081607q653848eaxce94433ad3f4aed@mail.gmail.com>
	<200706091357.15324.axel@open-mesh.net>
	<87FD50C8-EDAE-43E1-9167-E931AD020EF6@lo-res.org>
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
To: Aaron Kaplan <aaron@lo-res.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

------=_Part_59889_1442789.1181428509072
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/9/07, Aaron Kaplan <aaron@lo-res.org> wrote:
>
>
> On Jun 9, 2007, at 1:57 PM, Axel Neumann wrote:
>
> > I am currently trying to get a grip on vnuml (
> > http://www.dit.upm.es/vnumlwiki/index.php/Tutorial ) which has good
> > howtos
> > and tutorial for building host- and uml- kernels and root_fs.
> >
> > Especially vnuml offers a framework for virutal network
> > configuration based on
> > xml-configuration files. I think texas-kernel is also patched for
> > vnuml
> > enhancements but for texas's root_fs and network-configuration
> > scripts I am
> > not shure.
> > Maybe aaron can provide some more background on that?
> >
> I _think_ zethix (in the CC) briefly looked into vnuml but it seemed
> to complicated.
> The scripts were all borked and quite unusable for us at least.


Yes, as far as I remember, vnuml needs a lot of things in order to work...
well, things that all
linux distros usually have, but not busybox. It was something like ...
install its boot scripts in the
vnuml'd system, make it mount an fs on the host, then use ssh for something
and so on and so
on. But the biggest problem we had was actually... that it was constantly
making our poor system
crash. Anyway, I guess we just had to drop it in order to move on. I do
believe there are some nice
things about vnuml, but ...



> > In order to releas texas from unproductive trial-and-error
> > configuration
> > testing (and feeling less intervening when applying core-kernel-
> > patches or
> > installing new system-libraries) I started to setup a small vnuml
> > environment
> > on my home-pc. Therefore I found also the following links quite
> > useful:
> >
> > http://www.dit.upm.es/vnumlwiki/index.php/Installation
> >
> > http://www.enic.fr/people/landru/viminal/vnuml.gentoo/how-to/vnuml-
> > gentoo-guide.html
> > ( gentoo oriented setup, host-kernel-enhancement, uml-kernel,
> > root_fs )
> >
> > http://www.dit.upm.es/vnumlwiki/index.php/Howto
> > ( further links for root_fs howtos )
> >
> > @aaron:
> > do you have a link explaining from-scratch busybox-based uml-rootfs
> > generation
> > (as being used on texas) ?
> >
> yes
>
> with an existing root_fs:
>
> mount -o loop root_fs /mnt
> then just copy over things as needed. That is what I did . works!
>
>
> To create an initial root_fs:
>
> dd if=/dev/zero of=roof_fs bs=1M count=XXX
> Then mount this root_fs from inside an existing UML instance and
> fdisk it (./linux ubd1=root_fs )
> and mkfs it
>
> voila!
>
> a.
>
> PS:
> zethix was recently working on a way to do the simulation completely
> without UML but with olsr_switch
> which has still some bugs. Maybe some similar batman_switch
> application can be usefull?



Briefly, the olsr_switch works like this: in olsrd, there is this special
'driver' that doesn't use
a netif for transmission, but a tcp connection instead. that connection goes
to the olsr_switch.
Also, there are some patches preventing all instances to modify the same
routing table. So,
in order to make batman work with olsr_switch (or whatever) I guess
modifications might be
needed.

There is also an N-th way of doing it, probably: pseudo interfaces (like
tap) instead of
tcp connections. Nevertheless, all batmans (or olsrds) will share the same
routing table.

---
> there's no place like 127.0.0.1


Yes, there is - ::1, only bigger ;)

------=_Part_59889_1442789.1181428509072
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 6/9/07, <b class="gmail_sendername">Aaron Kaplan</b> &lt;<a href="mailto:aaron@lo-res.org">aaron@lo-res.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>On Jun 9, 2007, at 1:57 PM, Axel Neumann wrote:<br><br>&gt; I am currently trying to get a grip on vnuml (<br>&gt; <a href="http://www.dit.upm.es/vnumlwiki/index.php/Tutorial">http://www.dit.upm.es/vnumlwiki/index.php/Tutorial
</a> ) which has good<br>&gt; howtos<br>&gt; and tutorial for building host- and uml- kernels and root_fs.<br>&gt;<br>&gt; Especially vnuml offers a framework for virutal network<br>&gt; configuration based on<br>&gt; xml-configuration files. I think texas-kernel is also patched for
<br>&gt; vnuml<br>&gt; enhancements but for texas&#39;s root_fs and network-configuration<br>&gt; scripts I am<br>&gt; not shure.<br>&gt; Maybe aaron can provide some more background on that?<br>&gt;<br>I _think_ zethix (in the CC) briefly looked into vnuml but it seemed
<br>to complicated.<br>The scripts were all borked and quite unusable for us at least.</blockquote><div><br>Yes, as far as I remember, vnuml needs a lot of things in order to work... well, things that all <br>linux distros usually have, but not busybox. It was something like ... install its boot scripts in the 
<br>vnuml&#39;d system, make it mount an fs on the host, then use ssh for something and so on and so <br>on. But the biggest problem we had was actually... that it was constantly making our poor system <br>crash. Anyway, I guess we just had to drop it in order to move on. I do believe there are some nice 
<br>things about vnuml, but ...<br><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; In order to releas texas from unproductive trial-and-error
<br>&gt; configuration<br>&gt; testing (and feeling less intervening when applying core-kernel-<br>&gt; patches or<br>&gt; installing new system-libraries) I started to setup a small vnuml<br>&gt; environment<br>&gt; on my home-pc. Therefore I found also the following links quite
<br>&gt; useful:<br>&gt;<br>&gt; <a href="http://www.dit.upm.es/vnumlwiki/index.php/Installation">http://www.dit.upm.es/vnumlwiki/index.php/Installation</a><br>&gt;<br>&gt; <a href="http://www.enic.fr/people/landru/viminal/vnuml.gentoo/how-to/vnuml-">
http://www.enic.fr/people/landru/viminal/vnuml.gentoo/how-to/vnuml-</a><br>&gt; gentoo-guide.html<br>&gt; ( gentoo oriented setup, host-kernel-enhancement, uml-kernel,<br>&gt; root_fs )<br>&gt;<br>&gt; <a href="http://www.dit.upm.es/vnumlwiki/index.php/Howto">
http://www.dit.upm.es/vnumlwiki/index.php/Howto</a><br>&gt; ( further links for root_fs howtos )<br>&gt;<br>&gt; @aaron:<br>&gt; do you have a link explaining from-scratch busybox-based uml-rootfs<br>&gt; generation<br>&gt; (as being used on texas) ?
<br>&gt;<br>yes<br><br>with an existing root_fs:<br><br>mount -o loop root_fs /mnt<br>then just copy over things as needed. That is what I did . works!<br><br><br>To create an initial root_fs:<br><br>dd if=/dev/zero of=roof_fs bs=1M count=XXX
<br>Then mount this root_fs from inside an existing UML instance and<br>fdisk it (./linux ubd1=root_fs )<br>and mkfs it<br><br>voila!<br><br>a.<br><br>PS:<br>zethix was recently working on a way to do the simulation completely
<br>without UML but with olsr_switch<br>which has still some bugs. Maybe some similar batman_switch<br>application can be usefull?</blockquote><div><br><br>Briefly, the olsr_switch works like this: in olsrd, there is this special &#39;driver&#39; that doesn&#39;t use 
<br>a netif for transmission, but a tcp connection instead. that connection goes to the olsr_switch.<br>Also, there are some patches preventing all instances to modify the same routing table. So, <br>in order to make batman work with olsr_switch (or whatever) I guess modifications might be 
<br>needed.<br><br>There is also an N-th way of doing it, probably: pseudo interfaces (like tap) instead of <br>tcp connections. Nevertheless, all batmans (or olsrds) will share the same routing table.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
---<br>there&#39;s no place like <a href="http://127.0.0.1">127.0.0.1</a></blockquote><div><br>Yes, there is - ::1, only bigger ;) <br></div><br></div><br>

------=_Part_59889_1442789.1181428509072--
