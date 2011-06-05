Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 5 Jun 2011 22:27:06 +0200
References: <1306797945-22502-1-git-send-email-ordex@autistici.org>
	<1307205393-14227-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1307205393-14227-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106052227.06310.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 2/2] batman-adv: rename and move TT_*
	flags/structs to the proper locations
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

On Saturday, June 04, 2011 06:36:33 PM Antonio Quartulli wrote:
> struct tt_change is sent over the wire so need to be in packet.h as well
> as all the TT_CHANGE_* flags. TT_GLOBAL/CHANGE_ROAM as been renamed to
> TT_CLIENT_ROAM so that both tt_global_entry and tt_change can use the
> same same flag.

Applied in revision 78491cb.

Thanks,
Marek
