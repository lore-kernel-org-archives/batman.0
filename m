Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 17 Jun 2010 10:57:08 +0200
References: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
	<201006170052.18499.lindner_marek@yahoo.de>
	<201006170110.19294.sven.eckelmann@gmx.de>
In-Reply-To: <201006170110.19294.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201006171057.09289.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use rx_handler_data pointer
	to store net_bridge_port pointer
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

On Thursday 17 June 2010 01:10:17 Sven Eckelmann wrote:
> I have merged it into maint (not in trunk) but somebody has to think about
> a way to get it working on olders kernel _when he wants to enable it the
> future_. This patch has to made on top of that patch to get it integrated
> in _one of the next kernel merge windows_.

Ok, I think we are on the same page then.  :-)
I applied the patch (revision 1699).

Thanks,
Marek
