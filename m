Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 17 Jun 2010 00:52:18 +0200
References: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
	<201006170042.13864.sven.eckelmann@gmx.de>
In-Reply-To: <201006170042.13864.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201006170052.18499.lindner_marek@yahoo.de>
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

On Thursday 17 June 2010 00:42:11 Sven Eckelmann wrote:
> I have merged it into maint (not into trunk), but somebody has to think
> about  a way to to get it working on older kernels. This patch has to made
> on top of that patch to get it integrated into the next kernel merge
> window.

The code in question has not been enabled yet. It is just there as a 
possibility and could be enabled if it makes sense. I would say the one 
activating this code has to deal with the backward compatibility when it 
happens, ok ?  :-)

Cheers,
Marek
