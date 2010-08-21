Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 21 Aug 2010 08:01:16 +0200
References: <4C6437BF.9080909@web.de>
	<201008201824.22693.lindner_marek@yahoo.de>
	<4C6F5DC7.5010303@bb.banban.jp>
In-Reply-To: <4C6F5DC7.5010303@bb.banban.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008210801.17503.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
	in my case
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

On Saturday 21 August 2010 07:01:59 Kazuki Shimada wrote:
> PKG_REV:=1729
>
> [..]
> ------------------------------------
> 
> My update procedure is
> cd openwrt/trunk
> ./script/feeds update
> 
> .... Is this wrong? :-s

No, it is not wrong but you might want to change the PKG_REV field to match 
with the SVN revision you want to use. If you are interested in the latest 
trunk you should set it to 1776. 
We don't update this number each time something gets committed.

Cheers,
Marek
