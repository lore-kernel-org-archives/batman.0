Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 11 May 2012 14:59:39 +0800
References: <20120501190319.Horde.oIfHDR3HAoJPoCVnYaUF_lA@beta.mail.sapo.pt>
	<43098025.shuUEIUiJR@sven-desktop.home.narfation.org>
	<20120510224854.Horde.0SO0XL5SZhxPrDfGUeTRkCA@beta.mail.sapo.pt>
In-Reply-To: <20120510224854.Horde.0SO0XL5SZhxPrDfGUeTRkCA@beta.mail.sapo.pt>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201205111459.40354.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman-adv simple configuration example
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

On Friday, May 11, 2012 05:48:54 Pedro Nuno Costa Rodrigues wrote:
> I'm using backfire (openwrt build):
> cat /home/pedro/backfire/feeds/packages/net/batman-adv/Makefile | grep  
> 2012# Copyright (C) 2010-2012  
> OpenWrt.orgPKG_VERSION:=2012.0.0BATCTL_VERSION:=2012.0.0

You are trying to mix 2 different branches: backfire + trunk batman-adv
 * the batman-adv package coming with backfire is working fine with backfire
 * the batman-adv package from trunk works fine with trunk

Mixing the package with another branch is officially unsupported because there 
are some OpenWrt incompatibilities we can't not automatically handle. It 
certainly is doable but requires deeper knowledge of OpenWrt.

Cheers,
Marek
