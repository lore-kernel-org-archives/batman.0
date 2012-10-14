Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Oct 2012 02:03:24 +0800
References: <1350227959-27696-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1350227959-27696-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210150203.24299.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: enable fast client
	detection using unicast_4addr packets
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

On Sunday, October 14, 2012 23:19:19 Antonio Quartulli wrote:
> The "early client detection mechanism" can be extended to find new clients
> by means of unicast_4addr packets.
> 
> The unicast_4addr packet contains as well as the broadcast packet (which is
> currently used in this mechanism) the address of the originating node and
> can therefore be used to install new entries in the Global Translation
> Table
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v3:
> - fixed refcounting (again)
> 
>  routing.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied in revision d7cc20f.

Thanks,
Marek
