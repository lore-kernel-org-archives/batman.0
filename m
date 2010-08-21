Return-Path: <zukky@bb.banban.jp>
Message-ID: <4C6F5DC7.5010303@bb.banban.jp>
Date: Sat, 21 Aug 2010 14:01:59 +0900
From: Kazuki Shimada <zukky@bb.banban.jp>
MIME-Version: 1.0
References: <4C6437BF.9080909@web.de>	<201008130524.24059.sven.eckelmann@gmx.de>	<4C6E2EF6.6000407@bb.banban.jp>
	<201008201824.22693.lindner_marek@yahoo.de>
In-Reply-To: <201008201824.22693.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

  Hi, Marek Lindner.

> As far as I understand the current trunk should not exhibit this behaviour
> which gives me the impression that you are not running the latest version. You
> downloaded the devel package but did you also adjust the Makefile's SVN
> revision to your liking ?

This is my Makefile
~/openwrt/trunk/feeds/batman/batman-adv-devel/Makefile
---------------------------------------------------------------------------------------------------------------
#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=batman-adv-devel

PKG_REV:=1729

PKG_VERSION:=r$(PKG_REV)
PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_URL:=http://downloads.open-mesh.org/svn/batman/trunk
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
---------------------------------------------------------------------------------------------------------------

My update procedure is
cd openwrt/trunk
./script/feeds update

.... Is this wrong? :-s

Thanks,
Kazuki Shimada

> Regards,
> Marek
>
>

