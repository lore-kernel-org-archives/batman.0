Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Apr 2013 15:10:01 +0800
References: <1367136566-12593-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367136566-12593-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304291510.02220.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use the BigEndian notation
	for variables sent over the wire
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Sunday, April 28, 2013 16:09:26 Antonio Quartulli wrote:
> All the variables sent over the wire must report the
> BigEndian (__be*) notation so that sparse can easily spot
> any bug due to missing conversions.
> 
> This patch changes the type used by the up and download
> bandwidth in the new GW TVLV from uint32_t to __be32 and
> adds all the related conversions.
> 
> Introduced by: 0853ec7fafe0a195754454832993c6b35e22b842
> ("batman-adv: tvlv - gateway download/upload bandwidth container")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v1 was:
> batman-adv: properly handle Network Ordered variables
> 
> v2:
> change subject and commit message
> 
> 
> 
>  gateway_client.c | 24 +++++++++++++-----------
>  gateway_common.c |  4 ++--
>  packet.h         |  4 ++--
>  3 files changed, 17 insertions(+), 15 deletions(-)

Applied in revision b6acece.

Thanks,
Marek
