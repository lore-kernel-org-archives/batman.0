Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 20:01:22 +0800
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
	<1338928292-23085-6-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206102001.23043.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Transform
	BATADV_LOG_BUFF(idx) into function
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

On Wednesday, June 06, 2012 04:31:32 Sven Eckelmann wrote:
> The linux Documentation/CodingStyle says that:
>  * Chapter 12: "inline functions are preferable to macros resembling
> functions" * Chapter 12.2: Depending on local variables with a magic name
> is bad * Chapter 12.3: Macros with arguments used as l-value are bad
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_debugfs.c |   19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Applied in revision 4738c60.

Thanks,
Marek
