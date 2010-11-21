Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 22 Nov 2010 00:07:28 +0100
References: <201011211432.44862.lindner_marek@yahoo.de>
	<1290349981-23883-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290349981-23883-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201011220007.30358.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Ensure that eth_type_trans
	gets linear memory
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

On Sunday 21 November 2010 15:33:01 Sven Eckelmann wrote:
> eth_type_trans tries to pull data with the length of the ethernet header
> from the skb. We only ensured that enough data for the first ethernet
> header and the batman header is available in non-paged memory of the skb
> and not for the ethernet after the batman header.
> 
> eth_type_trans would fail sometimes with drivers which don't ensure that
> all there data is perfectly linearised.

Ok, I went ahead and applied this patch in revision 1874 after some 
discussion. No Intel user needs to suffer if we can avoid it.  ;-)

Thanks,
Marek
