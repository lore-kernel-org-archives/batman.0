From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 11 Apr 2009 06:34:39 +0800
References: <200904101231.14877.sven.eckelmann@gmx.de>
In-Reply-To: <200904101231.14877.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904110634.39509.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Out of tree builds of kernel modules
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> First thing is that there is a Makefile.kbuild which is included with
>  include $(PWD)/Makefile.kbuild
> This will not work in the current situation because the PWD is now
> /usr/src/linux-headers-2.6.29-1-amd64. Is this extra Makefile.kbuild really
> needed?

the Makefile.kbuild was introduced to support OpenWRT better (OpenWRT uses the 
kbuild Makefile only and replaces the main Makefile with its own). Could we do 
the same with debian ?


>  KERNELPATH ?= /lib/modules/$(shell uname -r)/build
>  # sanity check: does KERNELPATH exist?
>  ifeq ($(shell cd $(KERNELPATH) && pwd),)
>  $(warning $(KERNELPATH) is missing, please set KERNELPATH)
>  endif
>
> ok too?

Yes, I think its fine. I commited it.


> The batmand-gateway cannot be build for linux 2.6 if the current kernel is
> a 2.4.x. Isn't it possible to make the obj-m and batgat-objs assignment
> outside the check for the kernel version?

I'm not so sure what you have in mind. Could you explain it further ?


> My current workaround is to install my own version of the Makefile in the
> debian package, but I ask myself if this is really needed or parts of it
> should also be changed upstream.

I think we should try to move as much as possible upstream in order to reduce 
the overhead of the package maintainers.

Regards,
Marek


