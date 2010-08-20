Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 20 Aug 2010 18:24:21 +0200
References: <4C6437BF.9080909@web.de>
	<201008130524.24059.sven.eckelmann@gmx.de>
	<4C6E2EF6.6000407@bb.banban.jp>
In-Reply-To: <4C6E2EF6.6000407@bb.banban.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008201824.22693.lindner_marek@yahoo.de>
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

On Friday 20 August 2010 09:29:58 Lemonde wrote:
>  also met problem similar to Tim's case.
> My environment is,
> board: gateworks avila gw2348-4
> wlan module: wistron dcma-82(ar5414)
> firmware: openwrt trunk r22692
> wlan driver: ath5k
> batman version: batman-adv-devel (refered to 
> http://www.open-mesh.org/wiki/building-batman-adv-with-openwrt) (for 
> trial of multi interface altering)

As far as I understand the current trunk should not exhibit this behaviour 
which gives me the impression that you are not running the latest version. You 
downloaded the devel package but did you also adjust the Makefile's SVN 
revision to your liking ?

Regards,
Marek
