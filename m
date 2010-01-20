Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 20 Jan 2010 10:29:04 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <201001201015.59477.lindner_marek@yahoo.de>
Message-ID: <20100120092904.181520@gmx.net>
MIME-Version: 1.0
References: <20100119145806.275330@gmx.net>
	<201001201015.59477.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


-------- Original-Nachricht --------
> Datum: Wed, 20 Jan 2010 10:15:59 +0800
> Von: Marek Lindner <lindner_marek@yahoo.de>
>
> Complete configuration means: brctl show, ifconfig, cat /proc/net/batman-
> adv/interfaces (or batctl if) and ping output. 

Could be the first one in the list as brctl fails. CONFIG_BRIDGE is not configured in the device kernel. Is batman-adv dependent on this? I'll recompile the kernel and see what happens (it's a slow process), in the meanwhile, what other kernel configurations are needed for batman-adv?

-Juha
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/atbrowser
