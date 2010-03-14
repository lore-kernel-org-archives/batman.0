Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 01:52:35 +0800
References: <20100314155025.GA18908@sven-atom.lazhur.ath.cx>
	<1268586955-29220-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1268586955-29220-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003150152.35548.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Clone shared bat packets
	before modifying them
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

On Monday 15 March 2010 01:15:55 Sven Eckelmann wrote:
> "tcpdump" and "batctl td" will receive packets with a wrong sequence
> number on systems with a different endianess than network byte order.
> This happens due to the reordering of bytes in the function which
> handles aggregated bat packets. The function which receives the bat
> packets must ensure that these buffers aren't shared with anything else
> before that function tries to write into it. Otherwise it has to copy
> the buffers so it is save again to change them.

Applied in rev 1598.

Thanks for this quick fix!

Cheers,
Marek
