Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 May 2011 16:36:54 +0200
References: <1303776426-29019-1-git-send-email-lindner_marek@yahoo.de>
	<1304260873-5356-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1304260873-5356-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105041636.55157.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: multi vlan support for
	bridge loop detection
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

On Sunday 01 May 2011 16:41:13 Marek Lindner wrote:
> The bridge loop detection for batman-adv allows the bat0 interface
> to be bridged into an ethernet segment which other batman-adv nodes
> are connected to. In order to also allow multiple VLANs on top of
> the bat0 interface to be bridged into the ethernet segment this
> patch extends the aforementioned bridge loop detection.

Applied in revision 0281a6a.

Regards,
Marek
