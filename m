Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 18 May 2011 12:24:15 +0200
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
	<1305407694-16789-6-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105181224.15481.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Only use in up and down
	gw representation
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

On Saturday 14 May 2011 23:14:51 Sven Eckelmann wrote:
> It is not save to provide memory for an int and then cast the pointer to
> it to long*. It is better to standardize the up and down gateway
> bandwith representation to simple ints and only use long inside
> conversation routines.

Applied in revision ff26dcd.

Thanks,
Marek
