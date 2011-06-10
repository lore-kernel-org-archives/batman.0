Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 Jun 2011 02:04:36 +0200
References: <1307632389-31676-1-git-send-email-lindner_marek@yahoo.de>
	<201106091743.50333.sven@narfation.org>
In-Reply-To: <201106091743.50333.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106100204.37006.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use NO_FLAGS define instead
	of hard-coding 0
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

On Thursday, June 09, 2011 05:43:48 PM Sven Eckelmann wrote:
>   On Thursday 09 June 2011 17:13:09 Marek Lindner wrote:
> > The definition NO_FLAGS was introduced to make the code more
> > readable and shall be used to initialize flag fields.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

Applied in revision aa33f41.

Thanks,
Marek
