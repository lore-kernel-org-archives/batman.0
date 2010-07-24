Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 24 Jul 2010 19:56:07 +0200
References: <1279917512-22144-1-git-send-email-sven.eckelmann@gmx.de>
	<1279918164-22878-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279918164-22878-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201007241956.08384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Directly prepare icmp
	packets in socket buffer
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

On Friday 23 July 2010 22:49:24 Sven Eckelmann wrote:
> It is unnecessary to generate an icmp packet in an extra memory region
> and than copying it to a new allocated skb.
> 
> This also resolved the problem that we do inform the user that we
> couldn't send the packet because we couldn't allocate the socket buffer.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Applied in revision 1745.

Thanks,
Marek
