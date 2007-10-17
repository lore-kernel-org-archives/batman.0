From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batmand_0.3 segmentation fault
Date: Wed, 17 Oct 2007 11:09:16 +0200
References: <20071016020242.GA4608@apoderado.ometepe.net>
	<20071016185253.GA7250@apoderado.ometepe.net>
	<20071016194803.GA8315@apoderado.ometepe.net>
In-Reply-To: <20071016194803.GA8315@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710171109.17045.axel@open-mesh.net>
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

since rv 498 the interface initialization and probing for the tun module is 
done before the daemon forks into background.
However, the warning for "tun not loaded" has not reflected this. Now it goes 
to stderr!

Can you try rv 727 ?

ciao,
/axel

On Dienstag 16 Oktober 2007, Jan Hetges wrote:
> On Tue, Oct 16, 2007 at 12:52:53PM -0600, Jan Hetges wrote:
> > On Tue, Oct 16, 2007 at 11:25:52AM -0600, Jan Hetges wrote:
> > > On Tue, Oct 16, 2007 at 03:13:52PM +0200, Marek Lindner wrote:
> > > > > i just tried both and batmand_0.3-beta-rv674 gives a segmenation
> > > > > fault and
> > > >
> > > > are you sure it segfaults or is it simply not running ? Please
> > >
> > > yes, at least it said "Segmentation fault"
> > >
> > > > > batmand_0.2-rv502 doesn't start (probably segfault as well).
> > >
> > > this one is simply not running
> > >
> > > so i installed
> > > http://downloads.open-mesh.net/batman/development/misc/batmand_0.3-beta
> > >-rv724_mipsel-wr-elf-32-lsb-dynamic-unstripped.tgz md5sum
> > > /tmp/batmand_0.3-beta-rv724_mipsel-wr-elf-32-lsb-dynamic
> > > 955cc1f203c4ad47fea84427b7b7c5c4
> > > /tmp/batmand_0.3-beta-rv724_mipsel-wr-elf-32-lsb-dynamic
> >
> > the safe way to reproduce this:
> > flash openwrt-g-freifunk-1.6.9-es.bin to a wrt54g
> > then put scr lui http;//freifunk.schmudde.com/ipkg into /etc/ipkg.conf
> > ipkg update
> > ipkg install freifunk-batman freifunk-recommended-es
> > install
> > http://downloads.open-mesh.net/batman/development/misc/batmand_0.3-beta-r
> >v724_mipsel-wr-elf-32-lsb-dynamic-unstripped.tgz without rebooting!
> > i insmod /lib/modules/.../tun.o and tried again... still segfaults
> > after rebooting the box no more segfault!
>
> because i'm upgrading some more wrt54g, i can do some more testing :-).
> so i tried some random 0.3 versions and *ALL* of them gave a segmentation
> fault (all the way back including batmand_III_rv405)
> and i veryfied 0.2-rv502 with logread -f , and there was something with
> tun not loaded , can't try again because someone rebooted the box ;-)
> but i have some more :)
>
>   --Jan


