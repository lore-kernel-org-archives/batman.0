Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 Aug 2012 23:47:10 +0200
References: <1345413182-25515-1-git-send-email-sven@narfation.org>
 <1345414124-25938-1-git-send-email-sven@narfation.org>
In-Reply-To: <1345414124-25938-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208242347.10659.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Clear screen using ANSI escape
	codes
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

On Monday, August 20, 2012 00:08:44 Sven Eckelmann wrote:
> It is not necessary to call an external binary to clear the screen of a
> default unix terminal emulator. The external call using system("clear")
> may be used by an attacker to get untrusted code called with an higher
> privilege because batctl has to be run as using uid 0.
> 
> Reported-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Add comment
> 
>  functions.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision f1fff52.

Thanks,
Marek
