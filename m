Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 5 Jun 2011 22:08:03 +0200
References: <1306797945-22502-1-git-send-email-ordex@autistici.org>
	<1307205393-14227-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1307205393-14227-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106052208.03533.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/2] batman-adv: modify
	TT_RESPONSE-full-table format
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

On Saturday, June 04, 2011 06:36:32 PM Antonio Quartulli wrote:
> In case of TT_REQUEST for a full table, the related TT_RESPONSE now
> carries a set of tt_change structures instead of pure MACs.
> This helps to keep the TT_RESPONSE format extensible. In particular, the
> flag field can be used for later purposes.

Applied in revision e455c1c.

Thanks,
Marek
