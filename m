Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 22:56:04 +0800
References: <1352038798-29658-2-git-send-email-sven@narfation.org>
 <1352147127-2932-1-git-send-email-sven@narfation.org>
In-Reply-To: <1352147127-2932-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072256.04521.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC-alt1/2 2/4] batman-adv: Mark correctly
	aligned headers not as __packed
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

On Tuesday, November 06, 2012 04:25:26 Sven Eckelmann wrote:
> Headers which are already perfectly aligned and create a 4 byte boundary
> non-ethernet header payload can have the __packed attribute removed. The
> __packed attribute doesn't change the appeareance of the packet for these
> headers because no extra padding is necessary to align the data members.
> The compiler will also create slightly faster code for loads of multi-byte
> members.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Because we had protests against the approach of splitting the 32 bit
> seqno... here is a different approach. Now get your dices to find out what
> David may will like.
> 
>  packet.h |   20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Applied in revision e754ea0.

Thanks,
Marek
