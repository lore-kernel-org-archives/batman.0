Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 14 May 2011 17:26:21 +0200
References: <1305117877-31345-1-git-send-email-sven@narfation.org>
	<1305140346-10563-1-git-send-email-sven@narfation.org>
In-Reply-To: <1305140346-10563-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105141726.21405.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCHv2] batman-adv: Add missing
	hardif_free_ref in forw_packet_free
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

On Wednesday 11 May 2011 20:59:06 Sven Eckelmann wrote:
> add_bcast_packet_to_list increases the refcount for if_incoming but the
> reference count is never decreased. The reference count must be
> increased for all kinds of forwarded packets which have the primary
> interface stored and forw_packet_free must decrease them. Also
> purge_outstanding_packets has to invoke forw_packet_free when a work
> item was really cancelled.

Applied in revision d18e485.

Thanks,
Marek
