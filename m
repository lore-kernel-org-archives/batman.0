Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 Jul 2012 18:26:52 +0200
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
	<201207021752.32274.lindner_marek@yahoo.de>
	<CAHD-aq+gr5_gM4Qtg0qH=eQfjQvxyrhzGqCk-UwE6z9_tf+bsQ@mail.gmail.com>
In-Reply-To: <CAHD-aq+gr5_gM4Qtg0qH=eQfjQvxyrhzGqCk-UwE6z9_tf+bsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201207021826.52532.lindner_marek@yahoo.de>
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

On Monday, July 02, 2012 18:11:24 Guido Iribarren wrote:
> Hi Marek!
> Just to confirm and avoid useless compiling
> PKG_VERSION:=2012.2.0
> BATCTL_VERSION:=2012.2.0
> PKG_MD5SUM:=68967ed1df709de18ab795722dde9341
> BATCTL_MD5SUM:=7abd284098c514d3f2858e8a956c495e
> 
> ~/trunk/feeds/packages/net/batman-adv$ svn info .
> Path: .
> URL: svn://svn.openwrt.org/openwrt/packages/net/batman-adv
> Repository Root: svn://svn.openwrt.org/openwrt
> Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
> Revision: 32578
> Node Kind: directory
> Schedule: normal
> Last Changed Author: marek
> Last Changed Rev: 32578
> Last Changed Date: 2012-07-02 12:51:27 -0300 (Mon, 02 Jul 2012)
> 
> Given the date and the author ;) I assume this rev should do the trick,
> right?

Yes, that looks about right. If you wish to update the package and not the 
full image you should update one more time because Jow reminded me to increase 
the packet version. 

Cheers,
Marek
