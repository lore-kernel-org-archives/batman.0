Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 19 May 2011 09:26:17 +0200
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
	<1305407694-16789-8-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105190926.19866.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Remove casts from type x
	to type x
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

On Saturday 14 May 2011 23:14:53 Sven Eckelmann wrote:
> Casting from pointer like 'struct orig_node*' to 'struct orig_node *'
> doesn't provide any additional functionality and can be savely removed.

Applied in revision 409c211.

Thanks,
Marek
