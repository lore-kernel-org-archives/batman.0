Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 15:01:53 +0800
References: <1369520121-5998-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1369520121-5998-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281501.53451.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: properly align tvlv
	infrastructure
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

On Sunday, May 26, 2013 06:15:20 Marek Lindner wrote:
> 4bytes long members must start at an address multiple of 4
> in order to avoid unaligned memory access.
> 
> Therefore, the tvlv short type is eliminated in favor of
> tvlv long and that distinction removed from the code.
> 
> Introduced by 0b6aa0d43767889eeda43a132cf5e73df4e63bf2
> "batman-adv: tvlv - basic infrastructure"
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  main.c   |   91
> +++++++++++++++++--------------------------------------------- packet.h
> |   44 +++++++-----------------------
>  types.h  |    1 -
>  3 files changed, 33 insertions(+), 103 deletions(-)

Applied in revision 1ab746a.

Regards,
Marek
