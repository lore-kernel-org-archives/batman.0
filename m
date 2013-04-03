Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Apr 2013 19:19:13 +0800
References: <1364934870-23095-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364934870-23095-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304031919.14015.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batctl: fix 4addr parsing in
	tcpdump
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

On Wednesday, April 03, 2013 04:34:29 Antonio Quartulli wrote:
> In the UNICAST4ADDR parsing routing a wrong type is used to
> parse the batman header, resulting in a wrong data
> visualization. Fix this by using the correct data type.
> 
> Introduced by 70aefcf8abefd509e5721c6ae228d3854d5e8b16
> ("batctl: Add minimal unicast 4addr dissector support")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - removed subtype print format
> 
>  tcpdump.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied in revision 0ae03c9.

Thanks,
Marek
