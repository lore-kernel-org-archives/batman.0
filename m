From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Sat, 9 Jun 2007 13:57:14 +0200
References: <20070608201844.GM20739@localhost>
	<F32A30C5-7FD8-408E-A9F8-6A5A237ABA4E@lo-res.org>
	<560c7c9a0706081607q653848eaxce94433ad3f4aed@mail.gmail.com>
In-Reply-To: <560c7c9a0706081607q653848eaxce94433ad3f4aed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706091357.15324.axel@open-mesh.net>
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

I am currently trying to get a grip on vnuml ( 
http://www.dit.upm.es/vnumlwiki/index.php/Tutorial ) which has good howtos 
and tutorial for building host- and uml- kernels and root_fs.

Especially vnuml offers a framework for virutal network configuration based on 
xml-configuration files. I think texas-kernel is also patched for vnuml 
enhancements but for texas's root_fs and network-configuration scripts I am 
not shure. 
Maybe aaron can provide some more background on that?

In order to releas texas from unproductive trial-and-error configuration 
testing (and feeling less intervening when applying core-kernel-patches or 
installing new system-libraries) I started to setup a small vnuml environment 
on my home-pc. Therefore I found also the following links quite useful:

http://www.dit.upm.es/vnumlwiki/index.php/Installation

http://www.enic.fr/people/landru/viminal/vnuml.gentoo/how-to/vnuml-gentoo-guide.html
( gentoo oriented setup, host-kernel-enhancement, uml-kernel, root_fs )

http://www.dit.upm.es/vnumlwiki/index.php/Howto
( further links for root_fs howtos )

@aaron:
do you have a link explaining from-scratch busybox-based uml-rootfs generation 
(as being used on texas) ? 


ciao,
axel

On Saturday 09 June 2007 01:07, Benjamin Henrion wrote:
> No I am looking for UML kernels + rootfs (which includes olsr or
> batman)  I can boot on my 32bit computer. Texas seems to be a 64bit
> machine.
>
> Do you sources and/or config files for the UML kernel? Where did you
> get the rootfs?
>
> Best,
>
> On 6/9/07, Aaron Kaplan <aaron@lo-res.org> wrote:
> > If you want to code on it you can even test there. But only one
> > tester at a time please
> >
> > alle the best,
> > a.
> >
> > On Jun 8, 2007, at 10:18 PM, Benjamin Henrion wrote:
> > > Hi,
> > >
> > > I would like to test OLSR and BATMAN on UML instances, since I don't
> > > have the hardware to make real tests.
> > >
> > > Would it be possible to have a copy of the binaries running on the
> > > simulator of http://texas.funkfeuer.at/, in order to launch it on my
> > > computer?
> > >
> > > Best,
> > >
> > > --
> > > Benjamin Henrion <bhenrion@ffii.org>
> > > FFII Brussels - +32-484-566109 - +32-2-4148403
> > > _______________________________________________
> > > B.A.T.M.A.N mailing list
> > > B.A.T.M.A.N@open-mesh.net
> > > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
> > ---
> > there's no place like 127.0.0.1
> >
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
