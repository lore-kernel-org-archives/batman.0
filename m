From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] development-ipkgs broken
Date: Thu, 18 Oct 2007 14:08:50 +0200
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
	<200710161204.38008.onelektra@gmx.net>
	<BLU122-W8053274D7F88798A76C4AF69C0@phx.gbl>
In-Reply-To: <BLU122-W8053274D7F88798A76C4AF69C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710181408.50444.axel@open-mesh.net>
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

Hey Dennis,

On Dienstag 16 Oktober 2007, Dennis Bartsch wrote:
> hey,
>
> installation of the latest development-ipkgs (at least the i386 ones) of
> 0.3-beta fails, because control.tar.gz is missing:
>
> root@NicoAP5G:~# ipkg install
> http://downloads.open-mesh.net/batman/development/i386/batmand_0.3-beta-rv7
>22_i386-gc-elf-32-lsb-dynamic.tgz Downloading

Hmm, the tgz in that folder is a tgz :-) 
I think there has never been a ipk in the development/i386 folder - maybe 
there should. 
Anyway, there are ipk packages for i386 here:
http://downloads.open-mesh.net/batman/development/misc/batmand_0.3-beta-current_i386-gc-elf-32-lsb-static.ipk
or here:
http://downloads.open-mesh.net/batman/development/misc/batmand_0.3-beta-current_i386-gc-elf-32-lsb-dynamic.ipk

If you can confirm that its working for i386-kamikaze I'll open a 
deveopment/i386-kamikaze folder.

Yesterday you also mentioned some problems with the binary packages for ARM 
CPUs. Ipkg and tgz can be found here: 
http://downloads.open-mesh.net/batman/development/armv5te/
Unfortunately, I do not remember the exact problem description ;-)

ciao
/axel
