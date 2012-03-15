Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 15 Mar 2012 14:50:44 +0800
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<1331417873-19354-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331417873-19354-5-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203151450.44403.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: avoid temporary routing
	loops by being strict on forwarded OGMs
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

On Sunday, March 11, 2012 06:17:53 Marek Lindner wrote:
> batman-adv would forward OGMs from non-besthops while replacing the the TQ
> and TTL values with the values from the best hop. In certain corner cases
> this leads to a temporary routing loop.
> This patch changes this behavior: Only packets from best next hops are
> forwarded - TQ and TTL values won't be replaced anymore. However, the
> protocol needs to rebroadcast OGMs from single hop neighbors regardless of
> whether or not they are the best hop. To handle this case a new flag is
> introduced to alert neighboring nodes about the forwarded OGM that is not
> from my best next hop. It is to be discarded by all nodes except for the
> one originating the OGM.

Applied in revision f76d019.

Regards,
Marek
