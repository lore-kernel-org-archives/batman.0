Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAAOvAThfuXjDRDbhkPWxwzdJ+zZb5uUbdkXWxYDBDMJjVTU4NA@mail.gmail.com>
References: <CAAOvAThfuXjDRDbhkPWxwzdJ+zZb5uUbdkXWxYDBDMJjVTU4NA@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Wed, 11 Jul 2012 13:01:20 -0300
Message-ID: <CAHD-aqKH8PsSmawMUpTLTB0=tMYawJj=rkPTt4GfyqD_Mvs8Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] newbie error or repo misconfig?
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

On Tue, Jul 10, 2012 at 2:13 PM, Tony Godshall <togo@of.net> wrote:
> root@OpenWrt:~# opkg install kmod-batman-adv
> Installing kmod-batman-adv (3.3.8+2012.2.0-2) to root...
> Downloading http://downloads.openwrt.org/snapshots/trunk/ar71xx/packages/kmod-batman-adv_3.3.8+2012.2.0-2_ar71xx.ipk.
> Collected errors:
>  * satisfy_dependencies_for: Cannot satisfy the following dependencies
> for kmod-batman-adv:
>  *      kernel (= 3.3.8-1-65fa3307447a560c3a618c4d54bfa4dc) *   kernel
> (= 3.3.8-1-65fa3307447a560c3a618c4d54bfa4dc) *
>  * opkg_install_cmd: Cannot install package kmod-batman-adv.
>
> This is my foray into batman-adv land, with a freshly flashed
> TL-WR703n

You probably downloaded a snapshot (daily build), flashed the
TL-WR703n, and after a few days tried to install kmod-batman-adv.
The problem: every day the whole package tree is discarded and
rebuilt, so a particular trunk rev snapshot will only be able to "opkg
install kmod-*" successfully only for a few days (or weeks, or few
hours in worst-case scenario)
After that, the http://downloads.openwrt.org/ package tree
corresponding to your binary is gone forever.

Alternatives:
a) download today's trunk snapshot, reflash your router, and opkg
install kmod-* right away.
b) download svn source, compile your binary with kmod-batman-adv
included, reflash.
c) download svn source, compile packages and set up your own private
repo for trunk rXXXXX

Cheers!
