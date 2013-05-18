Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 18 May 2013 17:59:47 +0800
References: <1368388275-1383-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1368388275-1383-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305181759.48124.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: h_vlan_encapsulated_proto
	access refactoring
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

On Monday, May 13, 2013 03:51:15 Antonio Quartulli wrote:
> In the gateway code in case of VLAN tagged frame the ethhdr
> pointer is moved forward by 4 bytes so that the offset of
> h_proto in struct ethhdr matches the real
> h_vlan_encapsulated_proto address in the skb.
> 
> This trick is correct but the code is not easy to understand
> and may lead to bugs in case of re-use of ethhdr for other
> purposes.
> 
> Do some code refactoring in order to make it easier to
> understand and to change in the future.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - slightly change the commit subject and message
> - use __constant_htons() when comparing proto with constants
> 
> 
> 
>  gateway_client.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Applied in revision 9eff62f.

Thanks,
Marek
