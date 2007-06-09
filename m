In-Reply-To: <200706091357.15324.axel@open-mesh.net>
References: <20070608201844.GM20739@localhost>
	<F32A30C5-7FD8-408E-A9F8-6A5A237ABA4E@lo-res.org>
	<560c7c9a0706081607q653848eaxce94433ad3f4aed@mail.gmail.com>
	<200706091357.15324.axel@open-mesh.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87FD50C8-EDAE-43E1-9167-E931AD020EF6@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Sat, 9 Jun 2007 15:14:41 +0200
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
Cc: zethix something or <zethix@gmail.com>


On Jun 9, 2007, at 1:57 PM, Axel Neumann wrote:

> I am currently trying to get a grip on vnuml (
> http://www.dit.upm.es/vnumlwiki/index.php/Tutorial ) which has good  
> howtos
> and tutorial for building host- and uml- kernels and root_fs.
>
> Especially vnuml offers a framework for virutal network  
> configuration based on
> xml-configuration files. I think texas-kernel is also patched for  
> vnuml
> enhancements but for texas's root_fs and network-configuration  
> scripts I am
> not shure.
> Maybe aaron can provide some more background on that?
>
I _think_ zethix (in the CC) briefly looked into vnuml but it seemed  
to complicated.
The scripts were all borked and quite unusable for us at least.

> In order to releas texas from unproductive trial-and-error  
> configuration
> testing (and feeling less intervening when applying core-kernel- 
> patches or
> installing new system-libraries) I started to setup a small vnuml  
> environment
> on my home-pc. Therefore I found also the following links quite  
> useful:
>
> http://www.dit.upm.es/vnumlwiki/index.php/Installation
>
> http://www.enic.fr/people/landru/viminal/vnuml.gentoo/how-to/vnuml- 
> gentoo-guide.html
> ( gentoo oriented setup, host-kernel-enhancement, uml-kernel,  
> root_fs )
>
> http://www.dit.upm.es/vnumlwiki/index.php/Howto
> ( further links for root_fs howtos )
>
> @aaron:
> do you have a link explaining from-scratch busybox-based uml-rootfs  
> generation
> (as being used on texas) ?
>
yes

with an existing root_fs:

mount -o loop root_fs /mnt
then just copy over things as needed. That is what I did . works!


To create an initial root_fs:

dd if=/dev/zero of=roof_fs bs=1M count=XXX
Then mount this root_fs from inside an existing UML instance and  
fdisk it (./linux ubd1=root_fs )
and mkfs it

voila!

a.

PS:
zethix was recently working on a way to do the simulation completely  
without UML but with olsr_switch
which has still some bugs. Maybe some similar batman_switch  
application can be usefull?



---
there's no place like 127.0.0.1


