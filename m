Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:26:19 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070226.20149.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 1/9] batman-adv: add UNICAST_4ADDR
	packet type
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Monday, October 01, 2012 15:57:35 Antonio Quartulli wrote:
> The current unicast packet type does not contain the orig source address.
> This patches add a new unicast packet (called UNICAST_4ADDR) which
> provides two new fields: the originator source address and the subtype
> (the type of the data contained in the packet payload). The former is
> useful to identify the node which injected the packet into the network and
> the latter is useful to avoid creating new unicast packet types in the
> future: a macro defining a new subtype will be enough.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.c           |   2 +
>  packet.h         |  37 +++++++++++----
>  routing.c        |   8 +++-
>  soft-interface.c |   2 +-
>  unicast.c        | 134
> +++++++++++++++++++++++++++++++++++++++++++++++++------
> unicast.h        |  32 ++++++++++++-
>  6 files changed, 189 insertions(+), 26 deletions(-)

Applied in revision 78fc6bb.

Thanks,
Marek
