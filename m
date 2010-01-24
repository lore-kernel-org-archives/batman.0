Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 24 Jan 2010 22:19:13 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <20100122182619.GA6956@pandem0nium>
Message-ID: <20100124211913.37820@gmx.net>
MIME-Version: 1.0
References: <20100119145806.275330@gmx.net> <20100121141227.319490@gmx.net>
	<4B588C35.2020409@gmail.com>	<201001211932.13914.sven.eckelmann@gmx.de>
	<20100122182619.GA6956@pandem0nium>
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
> Datum: Fri, 22 Jan 2010 19:26:19 +0100
> Von: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
>
> maybe just an idea, but could it be that we have a regression from the skb
> patch that some skb headers are wrong? 
> 
> An idea would be to compare the behaviour with the batman-adv 0.2 release
> or an revision < 1517, which still uses raw sockets instead of working 
> directly on the skb.

Hi,

I've been trying out with 0.2 release and with latest trunk, with same behaviour. 

-Juha
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
