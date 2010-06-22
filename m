Return-Path: <linus.luessing@web.de>
Date: Tue, 22 Jun 2010 16:42:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100622144219.GA20481@Sellars>
References: <201006211611.45412.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201006211611.45412.clemens-john@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Cannot build actual OpenWrt Backfire branch with
 Batman Advanced
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

Hi Clemens,

seems to have been some svn weirdness...
with deleted branches you have to use
'svn co -r 1611 "http://downloads.open-mesh.org/svn/batman/branches/batctl-0.2.x@1611"'
(which I also didn't know before) instead of
'svn co -r 1611 "http://downloads.open-mesh.org/svn/batman/branches/batctl-0.2.x"

Should be fixed in OpenWRT commit 21880 now. Please let us
know, if it works for you too :).

Cheers, Linus

On Mon, Jun 21, 2010 at 04:11:40PM +0200, Clemens John wrote:
> Hi,
> 
> I tried to build OpenWrt Backfire with Batman adv from an actual branch 5 
> minutes ago and it fails with the following error  (seems to be a 
> version/download problem):
> 
> ------------
> --2010-06-21 16:03:50--  http://mirror2.openwrt.org/sources/batctl-
> maint-1611.tar.gz
> Resolving mirror2.openwrt.org... 88.198.39.176
> Connecting to mirror2.openwrt.org|88.198.39.176|:80... connected.
> HTTP request sent, awaiting response... 404 Not Found
> 2010-06-21 16:03:50 ERROR 404: Not Found.
> 
> Download failed.
> --2010-06-21 16:03:50--  http://downloads.openwrt.org/sources/batctl-
> maint-1611.tar.gz
> Resolving downloads.openwrt.org... 78.24.191.177
> Connecting to downloads.openwrt.org|78.24.191.177|:80... connected.
> HTTP request sent, awaiting response... 404 Not Found
> 2010-06-21 16:03:50 ERROR 404: Not Found.
> 
> Download failed.
> No more mirrors to try - giving up.
> Checking out files from the svn repository...
> svn: Write error: Broken pipe
> svn: '/svn/batman/!svn/bc/1718/branches/batctl-0.2.x' path not found
> svn: '/svn/batman/!svn/bc/1718/branches/batctl-0.2.x' path not found
> make[3]: *** [/home/floh1111/openwrtbuild_luci/dl/batctl-maint-1611.tar.gz] 
> Error 1
> make[3]: Leaving directory 
> `/home/floh1111/openwrtbuild_luci/feeds/packages/net/batman-advanced'
> make[2]: *** [package/feeds/packages/batman-advanced/compile] Error 2
> make[2]: Leaving directory `/home/floh1111/openwrtbuild_luci'
> make[1]: *** [/home/floh1111/openwrtbuild_luci/staging_dir/target-
> mips_uClibc-0.9.30.1/stamp/.package_compile] Error 2
> make[1]: Leaving directory `/home/floh1111/openwrtbuild_luci'
> make: *** [world] Fehler 2
> -------
> 
> It seems to be that the source file saved in the makefile is not right.
> https://dev.openwrt.org/browser/packages/net/batman-advanced/Makefile
> 
> Can someone fix this please?
> 
> Another question:
> What´s up with the latest release (Batman-adv 2010.0.0)?
> Will I be able to build it with the Backfire branch? Maybe someone can update 
> the makefile?
> 
> Thanks
> Clemens


