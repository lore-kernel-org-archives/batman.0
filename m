Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <201207021752.32274.lindner_marek@yahoo.de>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
	<CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
	<20120702143604.GD2917@ritirata.org>
	<201207021752.32274.lindner_marek@yahoo.de>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Mon, 2 Jul 2012 13:11:24 -0300
Message-ID: <CAHD-aq+gr5_gM4Qtg0qH=eQfjQvxyrhzGqCk-UwE6z9_tf+bsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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

Hi Marek!
Just to confirm and avoid useless compiling
PKG_VERSION:=2012.2.0
BATCTL_VERSION:=2012.2.0
PKG_MD5SUM:=68967ed1df709de18ab795722dde9341
BATCTL_MD5SUM:=7abd284098c514d3f2858e8a956c495e

~/trunk/feeds/packages/net/batman-adv$ svn info .
Path: .
URL: svn://svn.openwrt.org/openwrt/packages/net/batman-adv
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 32578
Node Kind: directory
Schedule: normal
Last Changed Author: marek
Last Changed Rev: 32578
Last Changed Date: 2012-07-02 12:51:27 -0300 (Mon, 02 Jul 2012)

Given the date and the author ;) I assume this rev should do the trick, right?

Thanks a lot!

Gui

On Mon, Jul 2, 2012 at 12:52 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Monday, July 02, 2012 16:36:04 Antonio Quartulli wrote:
>> Recently we fixed a bug that which fix has not been released yet. If we are
>> sure that this is the cause, you could eventually try an upgrade to a more
>> recente dev-version. But let's see the log first (if possible)
>
> You don't need the development version. I pushed these fixes into the latest
> batman-adv trunk package. If you update your package you should get them.
>
> Cheers,
> Marek
