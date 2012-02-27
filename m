Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 27 Feb 2012 19:07:45 +0800
References: <1330280603-25510-1-git-send-email-ordex@autistici.org>
	<1330280603-25510-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1330280603-25510-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202271907.45896.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 1/7] batman-adv: add UNICAST_4ADDR
	packet type
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

On Monday, February 27, 2012 02:23:17 Antonio Quartulli wrote:
> The current unicast packet type does not contain the orig source address.
> This patches add a new unicast packet (called UNICAST_4ADDR) which
> provides two new fields: the originator source address and the subtype
> (the type of the data contained in the packet payload). The former is
> useful to identify the node which injected the packet into the network and
> the latter is useful to avoid creating new unicast packet types in the
> future: a macro defining a new subtype will be enough.

Applied in revision 1ab8816.

Thanks,
Marek
