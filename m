Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 23:07:12 +0800
References: <1352038798-29658-2-git-send-email-sven@narfation.org>
 <1352147127-2932-1-git-send-email-sven@narfation.org>
 <1352147127-2932-2-git-send-email-sven@narfation.org>
In-Reply-To: <1352147127-2932-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072307.13017.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC-alt2/2 2/4] batman-adv: Use packing of 2
	for all headers before an ethernet header
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

On Tuesday, November 06, 2012 04:25:27 Sven Eckelmann wrote:
> All packet headers in front of an ethernet header have to be completely
> divisible by 2 but not by 4 to make the payload after the ethernet header
> again 4 bytes boundary aligned.
> 
> A packing of 2 is necessary to avoid extra padding at the end of the struct
> caused by a structure member which is larger than two bytes. Otherwise the
> structure would not fulfill the previously mentioned rule to avoid the
> misalignment of the payload after the ethernet header. It may also lead to
> leakage of information when the padding it not initialized before sending.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Because we had protests against the approach of splitting the 32 bit
> seqno... here is a different approach. Now get your dices to find out what
> David may will like.
> 
>  packet.h |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Applied in revision 52f79c4.

Thanks,
Marek
