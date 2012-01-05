Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 6 Jan 2012 00:01:32 +0800
References: <201112281811.58622.clemens-john@gmx.de>
In-Reply-To: <201112281811.58622.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201201060001.32518.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
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

On Thursday, December 29, 2011 01:11:48 Clemens John wrote:
> Maybe you can take a look at it and find our mistake?
> 
> This is the patch we use:
> http://trac.freifunk-ol.de/browser/firmware/Trunk/build_patches/bla2/0001-
> batman-adv-bla2.patch
> 
> I made no other changes to the default files that are shipped with the
> latest OpenWrt release.

I added the option to build from alternative branches to the batman-adv-devel 
package. Now you can simply choose "bla2" as your branch to get the latest 
bla2 development into your openwrt (don't forget to adjust the git revision to 
your liking).

Cheers,
Marek
