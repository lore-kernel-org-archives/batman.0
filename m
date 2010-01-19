Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 19 Jan 2010 08:43:34 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <201001182138.32432.lindner_marek@yahoo.de>
Message-ID: <20100119074334.275290@gmx.net>
MIME-Version: 1.0
References: <20100118112706.91160@gmx.net> <20100118113954.GC7844@lunn.ch>
	<20100118132935.91200@gmx.net>
	<201001182138.32432.lindner_marek@yahoo.de>
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: b.a.t.m.a.n@lists.open-mesh.org


-------- Original-Nachricht --------
> Datum: Mon, 18 Jan 2010 21:38:32 +0800
> Von: Marek Lindner <lindner_marek@yahoo.de>
>
> Could you please let us know what part of the wiki does not work as
> expected ? 
> Only then we can improve it.  :)

Ah yes, the instructions were actually were in the repository version of the README file, but not in my version of the sources. The sources I have the README is dated 07-11-2009, should I try later version?

> Yes, the devices are talking to each other. "real recv" indicates you
> received 
> the other node's messages but the other node does not repeat our own 
> broadcasts (see "own_bcast"). Would be interesting to see the log from the
> other side. It looks like the messages get dropped there.

The log on the laptop side is pretty sparse:
[23707.971949] batman-adv: B.A.T.M.A.N. advanced 0.2 (compatibility version 8) loaded
[23727.025361] batman-adv: Adding interface: wlan0
[23727.028964] batman-adv: Interface activated: wlan0
[23727.028983] batman-adv: Creating new local hna entry: de:ba:6c:f3:8d:53
[23728.028287] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 1, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23729.008099] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 2, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23729.988106] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 3, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23730.968098] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 4, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23731.948075] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 5, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23732.928870] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 6, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23733.908100] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 7, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23734.908149] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 8, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23735.888136] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 9, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23736.868083] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 10, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23737.848084] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 11, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23738.848080] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 12, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23739.848080] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 13, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23740.828084] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 14, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23741.808080] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 15, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23742.808208] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 16, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23743.788082] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 17, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23744.788081] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 18, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23745.788083] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 19, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23746.788079] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 20, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23747.768130] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 21, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23748.768129] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 22, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23749.768280] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 23, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23750.748081] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 24, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23751.728082] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 25, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23752.728083] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 26, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]
[23753.708077] batman-adv: Sending own packet (originator 00:22:fa:dc:9a:ce, seqno 27, TQ 255, TTL 50, IDF off) on interface wlan0 [00:22:fa:dc:9a:ce]

i.e. no sign of any other packages than own. On the device side the log is in the same format as the one I sent yesterday. I'll try with the latest version from the repository next.

-Juha 

-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/atbrowser
